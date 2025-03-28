<?php


namespace App\Http\Controllers;

use App\Models\Cart;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth; // <-- Add this at the top


class CartController extends Controller
{
    // Add product to cart
    public function addToCart(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
            'product_id' => 'required|integer|exists:products,id',
            'name' => 'required|string',
            'price' => 'required|numeric',
            'quantity' => 'required|integer|min:1',
        ]);

        // Check if product already exists in the user's cart
        $cartItem = Cart::where('user_id', $request->user_id)
                        ->where('product_id', $request->product_id)
                        ->first();

        if ($cartItem) {
            $cartItem->increment('quantity', $request->quantity);
        } else {
            $cartItem = Cart::create([
                'user_id' => $request->user_id,  // Associate item with the user
                'product_id' => $request->product_id,
                'name' => $request->name,
                'price' => $request->price,
                'quantity' => $request->quantity
            ]);
        }

        return response()->json(['message' => 'Product added to cart', 'cart' => $cartItem], 200);
    }

    public function viewCart()
    {
        $user = Auth::user();

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // Fetch only the cart items of the logged-in user
        $cartItems = Cart::where('user_id', $user->id)->get();

        return response()->json($cartItems, 200);
    }

    // Remove product from cart
    public function removeFromCart($id)
    {
        $cartItem = Cart::find($id);

        if (!$cartItem) {
            return response()->json(['message' => 'Product not found in cart'], 404);
        }

        $cartItem->delete();
        return response()->json(['message' => 'Product removed from cart'], 200);
    }
}
