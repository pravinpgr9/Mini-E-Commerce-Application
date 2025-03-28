<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { type BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';

import { usePage } from '@inertiajs/vue3';


const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Dashboard', href: '/dashboard' },
];


const products = ref([]);
const cart = ref([]);
const cartLoaded = ref(false); // Track cart loading state

const newProduct = ref({ name: '', price: '', stock_quantity: '', description: '' });
const editingProduct = ref(null);
const currentPage = ref(1);
const perPage = 5;
const totalPages = computed(() => Math.ceil(products.value.length / perPage));
const authToken = localStorage.getItem('authToken');

const notify = (message: string) => alert(message);

const fetchProducts = async () => {
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/products', {
            headers: { Accept: 'application/json', Authorization: `Bearer ${authToken}` },
        });
        products.value = response.data;
    } catch (error) {
        console.error('Error fetching products:', error);
    }
};


const fetchCart = async () => {
    cartLoaded.value = false; // Reset loading state before fetching
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/cart', {
            headers: { Accept: 'application/json', Authorization: `Bearer ${authToken}` },
        });
        cart.value = response.data;
    } catch (error) {
        console.error('Error fetching cart:', error);
    } finally {
        cartLoaded.value = true; // Set to true once API call completes
    }
};

const addProduct = async () => {
    try {
        await axios.post('http://127.0.0.1:8000/api/products', newProduct.value, {
            headers: { Accept: 'application/json', Authorization: `Bearer ${authToken}` },
        });
        notify('Product added successfully!');
        fetchProducts();
        newProduct.value = { name: '', price: '', stock_quantity: '', description: '' };
    } catch (error) {
        console.error('Error adding product:', error);
    }
};

const editProduct = (product) => {
    editingProduct.value = { ...product };
};

const updateProduct = async () => {
    if (!editingProduct.value) return;
    try {
        await axios.put(`http://127.0.0.1:8000/api/products/${editingProduct.value.id}`, editingProduct.value, {
            headers: { Accept: 'application/json', Authorization: `Bearer ${authToken}` },
        });
        notify('Product updated successfully!');
        fetchProducts();
        editingProduct.value = null;
    } catch (error) {
        console.error('Error updating product:', error);
    }
};

const deleteProduct = async (id) => {
    if (!confirm('Are you sure you want to delete this product?')) return;
    try {
        await axios.delete(`http://127.0.0.1:8000/api/products/${id}`, {
            headers: { Accept: 'application/json', Authorization: `Bearer ${authToken}` },
        });
        notify('Product deleted successfully!');
        fetchProducts();
    } catch (error) {
        console.error('Error deleting product:', error);
    }
};


const removeFromCart = async (cartItemId) => {
    if (!confirm('Are you sure you want to remove this item from the cart?')) return;

    try {
        await axios.delete(`http://127.0.0.1:8000/api/cart/remove/${cartItemId}`, {
            headers: {
                Accept: 'application/json',
                Authorization: `Bearer ${authToken}`,
            },
        });

        notify('Product removed from cart!');
        fetchCart(); // Refresh cart after removal
    } catch (error) {
        console.error('Error removing product from cart:', error);
        notify('Failed to remove product from cart.');
    }
};


const addToCart = async (productId) => {
    const userId = localStorage.getItem('user_id'); // Retrieve user ID from localStorage

    if (!userId) {
        notify('User not authenticated!');
        return;
    }

    // Find the product by ID from the products array
    const product = products.value.find(p => p.id === productId);
    
    if (!product) {
        notify('Product not found!');
        return;
    }

    console.log(product); // This will now log the complete product object

    try {
        const payload = {
            user_id: userId,  // Include user_id in the payload
            product_id: product.id,
            name: product.name,
            price: product.price,
            quantity: 1 // Default quantity, you can make this dynamic if needed
        };
        
        await axios.post('http://127.0.0.1:8000/api/cart/add', payload, {
            headers: { 
                Accept: 'application/json', 
                Authorization: `Bearer ${authToken}` 
            },
        });
        
        notify('Product added to cart!');

        fetchCart();
    } catch (error) {
        let errorMessage = 'Failed to add to cart';
        
        if (error.response) {
            // Handle validation errors
            if (error.response.data.errors) {
                errorMessage = Object.values(error.response.data.errors)
                                   .flat()
                                   .join('\n');
            } else if (error.response.data.message) {
                errorMessage = error.response.data.message;
            }
        }
        
        notify(errorMessage);
        console.error('Cart error:', error.response?.data || error.message);
    }
};

const paginatedProducts = computed(() => {
    const start = (currentPage.value - 1) * perPage;
    return products.value.slice(start, start + perPage);
});

const nextPage = () => { if (currentPage.value < totalPages.value) currentPage.value++; };
const prevPage = () => { if (currentPage.value > 1) currentPage.value--; };


onMounted(() => {
    const auth = usePage().props.auth;
    
    if (auth && auth.token) {
        localStorage.setItem('authToken', auth.token);
        console.log('Auth token stored:', auth.token);

        fetchProducts();
    fetchCart();
    }
});

</script>

<template>
    <Head title="Dashboard" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p-6 bg-gray-50">
            <h2 class="text-2xl font-bold mb-4 text-center">Product Management</h2>
            
            <br />

            <h4 class="text-2xl font-bold mb-4">Add Product</h4>            
            <div class="flex gap-4 mb-6">
                <input v-model="newProduct.name" placeholder="Product Name" class="border rounded-lg p-2 shadow-md w-full" />
                <input v-model="newProduct.price" placeholder="Price" class="border rounded-lg p-2 shadow-md w-full" />
                <input v-model="newProduct.stock_quantity" placeholder="Quantity" class="border rounded-lg p-2 shadow-md w-full" />
                <input v-model="newProduct.description" placeholder="Description" class="border rounded-lg p-2 shadow-md w-full" />
                <button @click="addProduct" class="px-4 py-2 bg-green-600 text-white rounded-lg shadow-md hover:bg-green-700 transition">Add Product</button>
            </div>

<hr />
<!-- Display Cart Items -->
<div class="mt-6">
    <h3 class="text-xl font-bold mb-3">Shopping Cart Details</h3>
    <div v-if="cart.length > 0" class="bg-white p-4 rounded-lg shadow-md">
        <div v-for="item in cart" :key="item.id" class="flex justify-between items-center border-b py-2">
            <div>
                <p class="font-bold">{{ item.name }}</p>
                <p>Price: ${{ item.price }} | Quantity: {{ item.quantity }}</p>
            </div>
            <button 
                @click="removeFromCart(item.id)" 
                class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 transition">
                Remove
            </button>
        </div>
    </div>
    <p v-else-if="cartLoaded" class="text-gray-500">Your cart is empty.</p>
</div>
            
            <hr /> <br />

            <h4 class="text-2xl font-bold mb-4">Product List</h4>

            <div v-if="editingProduct" class="mt-4 bg-white p-4 rounded-lg shadow-md">
                <h3 class="text-xl font-semibold">Edit Product</h3>
                <div class="flex gap-4">
                    <input v-model="editingProduct.name" placeholder="Product Name" class="border rounded-lg p-2 shadow-md w-full" />
                    <input v-model="editingProduct.price" placeholder="Price" class="border rounded-lg p-2 shadow-md w-full" />
                    <input v-model="editingProduct.stock_quantity" placeholder="Stock" class="border rounded-lg p-2 shadow-md w-full" />
                    <input v-model="editingProduct.description" placeholder="Description" class="border rounded-lg p-2 shadow-md w-full" />
                    <button @click="updateProduct" class="px-4 py-2 bg-blue-600 text-white rounded-lg shadow-md hover:bg-blue-700 transition">Update</button>
                    <button @click="editingProduct = null" class="px-4 py-2 bg-gray-400 text-white rounded-lg shadow-md hover:bg-gray-500 transition">Cancel</button>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mt-6">
                <div v-for="product in paginatedProducts" :key="product.id" class="bg-white border border-gray-200 rounded-lg shadow-md p-4 hover:bg-gray-100 transition">
                    <h4 class="font-bold text-lg">{{ product.name }}</h4>
                    <p>Price: ${{ product.price }}</p>
                    <p>Stock Quantity: {{ product.stock_quantity }}</p>
                    <div class="flex justify-between mt-4">
                        <button @click="editProduct(product)" class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 transition">Edit</button>
                        <button @click="deleteProduct(product.id)" class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 transition">Delete</button>
                        <button @click="addToCart(product.id)" class="px-3 py-1 bg-yellow-500 text-white rounded hover:bg-yellow-600 transition">Add to Cart</button>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <div class="flex justify-between items-center mt-6">
                <button @click.prevent="prevPage()" :disabled="currentPage === 1"
                        class="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg disabled:bg-gray-200">Previous</button>
                <span>Page {{ currentPage }} of {{ totalPages }}</span>
                <button @click.prevent="nextPage()" :disabled="currentPage === totalPages"
                        class="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg disabled:bg-gray-200">Next</button>
            </div>
            
        </div>
    </AppLayout>
</template>

<style scoped>

</style>
