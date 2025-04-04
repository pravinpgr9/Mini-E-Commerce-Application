
```markdown
# Laravel 12 Project with Vue, JWT Authentication, and Product Management API

This is a Laravel 12 project with Vue.js frontend and JWT authentication using Laravel Sanctum. It includes product management, cart functionality, and a user dashboard, with routes protected by authentication. Follow the steps below to set up the project.

---

## Prerequisites

Before starting, make sure you have the following installed on your system:
- PHP 8.1 or higher
- Composer
- Node.js and npm
- MySQL or MariaDB
- Laravel 12
- Vue.js (Frontend)

---

## Running the project:

### 1. **Clone the Repository**

Start by cloning the repository to your local machine:

```bash
git clone https://github.com/your-username/your-repository.git
cd your-repository

2. Set up the MySQL Database

Update the .env file with your database credentials:

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=ecomm-app
DB_USERNAME=root
DB_PASSWORD=

3. Install Dependencies

Run the following commands to install the backend and frontend dependencies:

composer install
npm install

4. Run the Migrations

Run the migrations to set up the database tables:

php artisan migrate


## Running the Project

After setting up the database, running migrations, and setting the environment variables, you can run the Laravel backend and Vue.js frontend.

For Laravel backend, run below command in separate terminal: 
php artisan serve

The backend will be running at http://127.0.0.1:8000.

For Vue.js frontend, run below command in separate terminal: 

npm run dev

User Credentials
To log in, use the following credentials:

Email: ttedd45@gmail.com
Password: demo12345


NOTE : My Local Database copy is also added into the Project root directory named : 
ecomm-app.sql


Video Walkthrough
For a detailed walkthrough of setting up and running the project, check out the video below:

Project Setup Video Guide

https://drive.google.com/file/d/1jifB9Jwx5hH7oebBJT6Y6q9egriYdunK/view?usp=sharing

## My Steps on Project

### 1. **Create a new Laravel Project**

To create a new Laravel 12 project, run the following command in your terminal:

```bash
composer create-project --prefer-dist laravel/laravel my-laravel-app "12.*"
```

### 2. **Set up Vue.js Frontend**

While creating the Laravel project, select the Vue.js frontend starter kit for your project when prompted. This will set up Vue.js in your Laravel application for managing the frontend.

### 3. **Set up the Database**

Ensure that you have MySQL or MariaDB installed on your machine. Then, set up the database for your application by creating a new database.

- Open the `.env` file in the root of your project.
- Configure the database connection by updating the following lines with your database credentials:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=my_database
DB_USERNAME=root
DB_PASSWORD=password
```

Replace `my_database`, `root`, and `password` with your actual database name, username, and password.

### 4. **Run Migrations**

Once the database is configured, you can run the migrations to set up the necessary tables in your database.

```bash
php artisan migrate
```

### 5. **Install API Support**

Run the `install:api` command to set up API support for your project:

```bash
php artisan install:api
```

This command will set up the necessary API routes and controller logic.

### 6. **Set up API Routes**

In the `routes/api.php` file, set up your routes for authentication, product management, and cart management:

```php
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CartController;

// Route for authenticated user
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Authentication Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes for Product and Cart management
Route::middleware('auth:sanctum')->group(function () {
    // Product Routes (Admin only)
    Route::get('/products', [ProductController::class, 'index']);
    Route::post('/products', [ProductController::class, 'store']); // Admin only
    Route::put('/products/{id}', [ProductController::class, 'update']); // Admin only
    Route::delete('/products/{id}', [ProductController::class, 'destroy']); // Admin only

    // Cart Routes
    Route::post('/cart/add', [CartController::class, 'addToCart']); // Add item to cart
    Route::get('/cart', [CartController::class, 'viewCart']); // View all cart items
    Route::delete('/cart/remove/{id}', [CartController::class, 'removeFromCart']); // Remove item from cart
});
```

### 7. **Create the Auth Controller**

You need to create an `AuthController` for handling user registration, login, and logout using JWT authentication.

Run the following command to create the controller:

```bash
php artisan make:controller AuthController
```

In the `AuthController.php` file, implement the logic for user registration and login.

```php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // Registration logic
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|confirmed|min:8',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json(['message' => 'User created successfully'], 201);
    }

    // Login logic
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string|min:8',
        ]);

        if (Auth::attempt($request->only('email', 'password'))) {
            $user = Auth::user();
            $token = $user->createToken('API Token')->plainTextToken;

            return response()->json(['token' => $token]);
        }

        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    // Logout logic
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logged out successfully']);
    }
}
```

### 8. **Create Product and Cart Controllers**

You can now create `ProductController` and `CartController` for managing products and cart items.

```bash
php artisan make:controller ProductController
php artisan make:controller CartController
```

Implement CRUD logic for products and cart items in these controllers.

---

## API Endpoints

Once the controllers are created, your API will have the following endpoints:

- **Authentication:**
    - `POST /login`: Login a user and get the JWT token.
    - `POST /register`: Register a new user.
    - `POST /logout`: Logout the authenticated user.

- **Products (Admin Only):**
    - `GET /products`: Get all products.
    - `POST /products`: Create a new product.
    - `PUT /products/{id}`: Update a product.
    - `DELETE /products/{id}`: Delete a product.

- **Cart:**
    - `POST /cart/add`: Add a product to the cart.
    - `GET /cart`: Get all cart items.
    - `DELETE /cart/remove/{id}`: Remove a product from the cart.

---

## Frontend (Vue.js)

### 1. **Set up Vue.js Components**

#### Create the Dashboard View

After setting up Vue.js, you'll create a simple dashboard view that shows the logged-in user's details, product listing, and cart functionalities.

- **Dashboard.vue**:
    - Show user information.
    - Display product listing in a grid with pagination.
    - Implement cart functionality (add/remove items).

### 2. **Create Product Management Form**

For admins, create a form to manage products:


### 3. **Set up Vue Router**

Set up Vue Router to handle navigation for the dashboard and product management form.

---

## Conclusion

This project sets up Laravel 12 with JWT authentication using Sanctum for user management and CRUD operations on products and cart. The Vue.js frontend is used to show a dashboard with product listings, a cart, and a product management form. The application is protected with Sanctum authentication.

