import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CustomerModel {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  String mobileNo;

  @HiveField(2)
  String email;

  @HiveField(3)
  String address;

  @HiveField(4)
  double latitude;

  @HiveField(5)
  double longitude;

  @HiveField(6)
  String geoAddress;

  @HiveField(7)
  String customerImage;

  CustomerModel({
    required this.fullName,
    required this.mobileNo,
    required this.email,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.geoAddress,
    required this.customerImage,
  });
}
