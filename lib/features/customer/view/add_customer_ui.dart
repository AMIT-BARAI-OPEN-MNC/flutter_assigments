import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_assigments/core/database/hive_customer_model.dart';
import 'package:flutter_assigments/features/customer/controllers/customer_localdb.dart';

class AddCustomerPage extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final nameValid = ValueNotifier<bool>(true);
  final mobileValid = ValueNotifier<bool>(true);
  final emailValid = ValueNotifier<bool>(true);
  final addressValid = ValueNotifier<bool>(true);

  void validateFields() {
    nameValid.value = nameController.text.isNotEmpty;
    mobileValid.value = mobileController.text.isNotEmpty;
    emailValid.value = emailController.text.isNotEmpty;
    addressValid.value = addressController.text.isNotEmpty;
  }

  void saveCustomer() {
    validateFields();
    if (_formKey.currentState!.validate() &&
        controller.latitude.value != 0 &&
        controller.imagePath.value.isNotEmpty) {
      final customer = CustomerModel(
        fullName: nameController.text,
        mobileNo: mobileController.text,
        email: emailController.text,
        address: addressController.text,
        latitude: controller.latitude.value,
        longitude: controller.longitude.value,
        geoAddress: controller.geoAddress.value,
        customerImage: controller.imagePath.value,
      );

      controller.addCustomer(customer);
      Get.back();
    } else {
      Get.snackbar("Error", "Please fill all fields and select an image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Customer")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildValidatedTextField(
                    nameController, "Full Name", nameValid),
                _buildValidatedTextField(
                    mobileController, "Mobile No", mobileValid,
                    isPhone: true),
                _buildValidatedTextField(emailController, "Email", emailValid,
                    isEmail: true),
                _buildValidatedTextField(
                    addressController, "Address", addressValid),
                SizedBox(height: 16),
                Obx(() => buildCustomButton(
                      icon: Icons.location_on,
                      label: controller.latitude.value != 0.0
                          ? controller.geoAddress.value
                          : "Capture Location",
                      onTap: controller.isFetchingLocation.value
                          ? null
                          : controller.getCurrentLocation,
                      isLoading: controller.isFetchingLocation.value,
                    )),
                SizedBox(height: 10),
                buildCustomButton(
                  icon: Icons.image,
                  label: "Pick Image",
                  onTap: controller.pickImage,
                  isLoading: false,
                ),
                Obx(() => controller.imagePath.value != ''
                    ? Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Image.file(
                          File(controller.imagePath.value),
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox.shrink()),
                SizedBox(height: 10),
                buildCustomButton(
                  icon: Icons.save,
                  label: "Save Customer",
                  onTap: saveCustomer,
                  isLoading: false,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(TextEditingController controller,
      String label, ValueNotifier<bool> isValid,
      {bool isPhone = false, bool isEmail = false}) {
    return ValueListenableBuilder<bool>(
      valueListenable: isValid,
      builder: (context, isValid, child) {
        return Padding(
          padding: EdgeInsets.only(top: 15),
          child: TextFormField(
            controller: controller,
            keyboardType: isPhone
                ? TextInputType.phone
                : isEmail
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: isValid ? Colors.grey : Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: isValid ? Colors.blue : Colors.red),
              ),
              errorText: isValid ? null : "$label is required",
            ),
            onChanged: (value) => isValid = value.isNotEmpty,
          ),
        );
      },
    );
  }

  Widget buildCustomButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool isLoading,
    Color color = Colors.blue,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isLoading ? Colors.white : color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
