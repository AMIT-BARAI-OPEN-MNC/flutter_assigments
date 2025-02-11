import 'package:flutter_assigments/features/auth/view/login.dart';
import 'package:flutter_assigments/features/customer/view/add_customer_ui.dart';
import 'package:flutter_assigments/features/customer/view/customer_list_ui.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String login = '/login';
  static const String customerList = '/customerList';
  static const String addCustomer = '/addCustomer';

  static final routes = [
    GetPage(name: customerList, page: () => CustomerListPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: addCustomer, page: () => AddCustomerPage()),
  ];
}
