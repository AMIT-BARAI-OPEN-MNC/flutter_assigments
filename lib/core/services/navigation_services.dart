import 'package:get/get.dart';

class NavigationService {
  // Push to a new page
  static void push(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  // Replace the current page (No Back Navigation)
  static void pushReplacement(String route, {dynamic arguments}) {
    Get.offNamed(route, arguments: arguments);
  }

  // Pop current page
  static void pop() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back();
    }
  }
}
