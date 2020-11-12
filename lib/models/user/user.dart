import 'package:boilerplate/models/common.dart';
import 'package:boilerplate/models/helper/helper.dart';

class User extends Person {
  String emailId;
  String password;
  List orders;
  List<Helper> helpers;
  List savedPayments;
  List preferences;
  List pastOrder;
  List<String> services;

  User({fullname, phoneNumber, id, gender, password})
      : this.password = password,
        super(
            fullname: fullname,
            phoneNumber: phoneNumber,
            id: id,
            gender: gender);

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      fullname: json["fullname"],
      phoneNumber: json["phoneNumber"],
      gender: int.parse(json["gender"]),
      password: json["password"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "password": password
      };
}
