// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grd_proj/core/api/end_points.dart';

class SignUpModel {
  List ? email;
  List ? password;
  List ? firstName;
  List ? lasttName;
  List ? userName;
  List ? phoneNumber;
  String ? description;
  SignUpModel({
    this.email,
    this.password,
    this.firstName,
    this.lasttName,
    this.userName,
    this.phoneNumber,
    this.description,
  });

  factory SignUpModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return SignUpModel(
        email: jsonData["Email"],
        password: jsonData["Password"],
        firstName: jsonData[ApiKey.firstName],
        lasttName: jsonData["LastName"],
        userName: jsonData[ApiKey.userName],
        phoneNumber: jsonData[ApiKey.phoneNumber],
        description: jsonData['description']
        );
  }
}


