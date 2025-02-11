import 'package:flutter_assigments/core/database/hive_customer_model.dart';
import 'package:flutter_assigments/core/database/local_db.dart';
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
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
      geoAddress.value =
          "Lat: ${position.latitude}, Long: ${position.longitude}";
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e");
    } finally {
      isFetchingLocation.value = false;
    }
  }
}
