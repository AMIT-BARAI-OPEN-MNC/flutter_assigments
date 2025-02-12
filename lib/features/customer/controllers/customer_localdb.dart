import 'dart:io';

import 'package:flutter_assigments/core/database/hive_customer_model.dart';
import 'package:flutter_assigments/core/database/local_db.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomerController extends GetxController {
  var customers = <CustomerModel>[].obs;
  RxString imagePath = "".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString geoAddress = "".obs;
  RxBool isFetchingLocation = false.obs;

  @override
  void onInit() {
    loadCustomers();

    super.onInit();
  }

  void loadCustomers() {
    customers.value = LocalDB.getAllCustomers();
  }

  void addCustomer(CustomerModel customer) {
    LocalDB.addCustomer(customer).then((_) {
      customers.add(customer);
    });
  }

  void deleteCustomer(int index) {
    LocalDB.deleteCustomer(index).then((_) {
      customers.removeAt(index);
    });
  }

  Future<void> pickImage() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.photos.request(); // Android 13+
      if (status.isDenied) {
        status = await Permission.storage.request(); // Below Android 13
      }
    } else {
      status = await Permission.photos.request(); // iOS
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
      }
    } else {
      Get.snackbar(
          "Permission Denied", "Please allow photo access in settings.");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      var status = await Geolocator.requestPermission();
      if (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever) {
        Get.snackbar("Permission Denied", "Please allow access to location.");
        return;
      }

      isFetchingLocation.value = true;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      await getGeoAddress(position.latitude, position.longitude).then((value) {
        geoAddress.value = value;
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e");
    } finally {
      isFetchingLocation.value = false;
    }
  }

  Future<String> getGeoAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        return "Address not found";
      }
    } catch (e) {
      return "Error fetching address: $e";
    }
  }
}
