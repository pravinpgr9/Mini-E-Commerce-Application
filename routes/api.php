<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartController;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/products', [ProductController::class, 'index']);
    Route::post('/products', [ProductController::class, 'store']); // Admin only
    Route::put('/products/{id}', [ProductController::class, 'update']); // Admin only
    Route::delete('/products/{id}', [ProductController::class, 'destroy']); // Admin only


    Route::post('/cart/add', [CartController::class, 'addToCart']); // Add item to cart
    Route::get('/cart', [CartController::class, 'viewCart']); // View all cart items
    Route::delete('/cart/remove/{id}', [CartController::class, 'removeFromCart']); // Remove item from cart

});

