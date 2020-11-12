import 'dart:ui';

import 'package:boilerplate/models/common.dart';

class Helper extends Person {
  Image image;
  List<Review> reviews;
  Ratings ratings;
  List slots;
  String idproofNumber;
  List<String> services;
  int currentUsers;
  int totalUsers;
  String city;
  String areas;

  Helper({fullname, phoneNumber, id, gender, areas, services, city})
      : this.areas = areas,
        this.services = services,
        this.city = city,
        super(
            id: id,
            fullname: fullname,
            phoneNumber: phoneNumber,
            gender: gender);

  factory Helper.fromMap(Map<String, dynamic> json) => Helper(
      id: json["id"],
      fullname: json["fullname"],
      phoneNumber: json["phoneNumber"],
      gender: int.parse(json["gender"]),
      services: List<String>.from(json["services"]),
      areas: List<String>.from(json["areas"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "services": services,
        "areas": areas
      };
}

class Review {
  int userId;
  int id;
  int helperId;
  String comment;
  DateTime posted;

  Review(String comment) {
    this.comment = comment;
  }
}

class Slot {
  DateTime start;
  DateTime end;
  bool available;
}
