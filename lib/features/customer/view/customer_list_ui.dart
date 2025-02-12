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
        ? "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude"
        : "https://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d";

    if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
      await launchUrl(Uri.parse(googleMapUrl),
          mode: LaunchMode.externalApplication);
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
                leading: customer.customerImage.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage:
                            FileImage(File(customer.customerImage)),
                      )
                    : CircleAvatar(child: Icon(Icons.person)),
                title: Text(customer.fullName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customer.mobileNo),
                    Text(customer.email),
                    Text(customer.address),
                    Text(customer.geoAddress),
                    Text('Latitude: ${customer.latitude}' +
                        '\n' +
                        'Longitude: ${customer.longitude}'),
                    InkWell(
                      onTap: () =>
                          openGoogleMaps(customer.latitude, customer.longitude),
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Icon(Icons.location_on,
                                color: Color.fromARGB(255, 53, 50, 250))),
                      ),
                    ),
                  ],
                ),
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
