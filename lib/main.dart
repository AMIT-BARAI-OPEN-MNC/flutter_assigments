import 'package:flutter/material.dart';
import 'package:flutter_assigments/core/database/local_db.dart';
import 'package:flutter_assigments/core/database/login_Status.dart';
import 'package:flutter_assigments/routes/app_routs.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(CustomerModelAdapter());
  await LocalDB.init();
  await Hive.openBox('appBox');
  rout();
  runApp(MyApp());
}

String rout() {
  bool isUserLoggedIn = LocalStorage.isLoggedIn;
  if (isUserLoggedIn == true) {
    return AppRoutes.customerList;
  } else {
    return AppRoutes.login;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Management',
      initialRoute: rout(), // Start from login page
      getPages: AppRoutes.routes,
    );
  }
}
