import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assigments/features/customer/controllers/customer_localdb.dart';
import 'package:flutter_assigments/routes/app_routs.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerListPage extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());
  void openGoogleMaps(double latitude, double longitude) async {
    final String googleMapUrl = Platform.isAndroid
        ? "geo:$latitude,$longitude?q=$latitude,$longitude"
        : "https://maps.apple.com/?q=$latitude,$longitude";

    if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
      await launchUrl(Uri.parse(googleMapUrl));
    } else {
      Get.snackbar("Error", "Could not open Google Maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer List")),
      body: Obx(() {
        if (controller.customers.isEmpty) {
          return Center(child: Text("No Customers Found"));
        }
        return ListView.builder(
          itemCount: controller.customers.length,
          itemBuilder: (context, index) {
            final customer = controller.customers[index];
            return Card(
              child: ListTile(
                onTap: () =>
                    openGoogleMaps(customer.latitude, customer.longitude),
                leading: customer.customerImage.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage:
                            FileImage(File(customer.customerImage)),
                      )
                    : CircleAvatar(child: Icon(Icons.person)),
                title: Text(customer.fullName),
                subtitle: Text(customer.geoAddress),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.deleteCustomer(index),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addCustomer),
        child: Icon(Icons.add),
      ),
    );
  }
}
