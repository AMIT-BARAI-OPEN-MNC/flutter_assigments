import 'package:flutter_assigments/core/database/hive_customer_model.dart';
import 'package:hive/hive.dart';

class LocalDB {
  static const String _customerBox = "customerBox";

  // Initialize Hive
  static Future<void> init() async {
    Hive.registerAdapter(CustomerModelAdapter());
    await Hive.openBox<CustomerModel>(_customerBox);
  }

  // Get Hive Box
  static Box<CustomerModel> get box => Hive.box<CustomerModel>(_customerBox);

  // Add Customer
  static Future<void> addCustomer(CustomerModel customer) async {
    await box.add(customer);
  }

  // Get All Customers
  static List<CustomerModel> getAllCustomers() {
    return box.values.toList();
  }

  // Update Customer (Index Required)
  static Future<void> updateCustomer(int index, CustomerModel customer) async {
    await box.putAt(index, customer);
  }

  // Delete Customer
  static Future<void> deleteCustomer(int index) async {
    await box.deleteAt(index);
  }
}

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 0;

  @override
  CustomerModel read(BinaryReader reader) {
    return CustomerModel(
      fullName: reader.readString(),
      mobileNo: reader.readString(),
      email: reader.readString(),
      address: reader.readString(),
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      geoAddress: reader.readString(),
      customerImage: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer.writeString(obj.fullName);
    writer.writeString(obj.mobileNo);
    writer.writeString(obj.email);
    writer.writeString(obj.address);
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
    writer.writeString(obj.geoAddress);
    writer.writeString(obj.customerImage);
  }
}
