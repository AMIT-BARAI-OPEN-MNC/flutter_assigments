# flutter_assigments

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



lib/
│── main.dart
│── core/
│   │── database/ (Local DB Helper)
│   │── services/ (Utility functions, APIs)
│── features/
│   │── auth/  (Login Feature)
│   │   │── models/user_model.dart
│   │   │── views/login_page.dart
│   │   │── controllers/login_controller.dart
│   │── customer/  (Customer Management Feature)
│   │   │── models/customer_model.dart
│   │   │── views/customer_list_page.dart
│   │   │── views/add_customer_page.dart
│   │   │── controllers/customer_controller.dart 
│── routes/ (App Routes)
│── utils/ (Constants, Helpers)
