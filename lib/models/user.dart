import 'package:blnk_task/models/address.dart';

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.landLine,
    required this.email,
    this.address,
    this.frontIDURL,
    this.backIDURL,
  });

  late String firstName;
  late String lastName;
  late String mobileNumber;
  late String landLine;
  late String email;
  Address? address;
  String? frontIDURL;
  String? backIDURL;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      mobileNumber: json["mobileNumber"] as String,
      landLine: json["landLine"] as String,
      email: json["email"] as String,
      address: json["address"] != null
          ? Address.fromJson(json["address"] as Map<String, dynamic>)
          : null,
      frontIDURL: json["frontIDURL"] as String?,
      backIDURL: json["backIDURL"] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "mobileNumber": mobileNumber,
      "landLine": landLine,
      "email": email,
      "address": address?.toJson(),
      "frontIDURL": frontIDURL,
      "backIDURL": backIDURL,
    };
  }
}
