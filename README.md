# Flutter Product Listing App

## 📌 Overview

This Flutter application is built to showcase a list of products fetched from [FakeStore API](https://fakestoreapi.com/products). The app includes product listing, detailed product view, a favorites feature with local storage, and a fully responsive UI.

## 🌐 Demo
[Live Web App](https://mahm0ud-ahmed.github.io/ecommercetest/)

## 📸 Screenshots

<p align="center">
    <img src="https://github.com/user-attachments/assets/ac43c74d-9f15-43ad-a996-db0a7ae3f4b7" width="200" />
    <img src="https://github.com/user-attachments/assets/e520d435-c992-498f-8364-74b09845bbfe" width="200" />
    <img src="https://github.com/user-attachments/assets/b8432068-95be-4bd9-8029-946baec2ce70" width="200" />
    <img src="https://github.com/user-attachments/assets/2b9f27f9-0725-4e4a-816a-27ba52cef114" width="200" />
    <img src="https://github.com/user-attachments/assets/01f5ac5a-4f44-4f5b-ade8-7be210611777" width="200" />
    <img src="https://github.com/user-attachments/assets/5dbd3941-bc4e-41c4-9c0b-6d29e3a86359" width="200" />
</p>

## 📱 Features

- **Product Listing Screen**

  - Fetches products from [FakeStore API](https://fakestoreapi.com/products)
  - Displays products in a visually appealing **grid** layout
  - Shows **title, image, and price** for each product
  - **Tap on a product** to navigate to the details screen

- **Product Details Screen**

  - Displays **full details** of the selected product
  - Includes **title, image, price, description, and category**
  - Users can **mark/unmark** products as favorites

- **Favorites Feature**

  - Favorites are **saved using Hive**
  - Dedicated **Favorites Screen** to view saved items

- **Responsive UI**

  - Adapts dynamically across **mobile, tablet, and desktop**

- **Performance Optimization**

  - Efficient **state management** using **Bloc**
  - Smooth **navigation and UI rendering**

- **Additional Features**
  - **Dark Mode** using Flutter's **ThemeData**
  - **Deployed Web Version**

## 🚀 Installation & Setup

### 1️⃣ Prerequisites:

- Flutter SDK: 3.27.4
- Dart: 3.6.2
- Android Studio or an Android emulator.
- Firebase account with a project setup.

### 2️⃣ Clone the Repository:

1. Clone the repository:
   ```bash
   git clone https://github.com/Mahm0ud-Ahmed/ecommerce_test.git
   ```
2. Navigate to the project directory:
   ```bash
   cd ecommerce_test
   ```
3. Install the required dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Testing

To run the app on an emulator or Android device, follow the installation steps and execute:

```bash
flutter run
```

## Contribution

Feel free to fork this repository and create a pull request for any improvements or new features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
