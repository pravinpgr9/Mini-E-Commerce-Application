<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ProductController extends Controller
{
    // Fetch all products
    public function index()
    {
        return response()->json(Product::all(), 200);
    }

    // Add a new product (Authenticated users only)
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'stock_quantity' => 'required|integer',
        ]);

        $product = Product::create($request->only(['name', 'description', 'price', 'stock_quantity']));

        return response()->json($product, 201);
    }

    // Update product details (Authenticated users only)
    public function update(Request $request, $id)
    {
        $product = Product::find($id);
        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        $request->validate([
            'name' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'price' => 'sometimes|numeric',
            'stock_quantity' => 'sometimes|integer',
        ]);

        $product->update($request->only(['name', 'description', 'price', 'stock_quantity']));

        return response()->json($product, 200);
    }

    // Delete a product (Authenticated users only)
    public function destroy($id)
    {
        $product = Product::find($id);
        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        $product->delete();

        return response()->json(['message' => 'Product deleted'], 200);
    }
}
