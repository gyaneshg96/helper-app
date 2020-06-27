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
  List<String> areas;

  Helper({
    fullname,
    phoneNumber,
    id,
    male,
    this.areas,
    this.services
  }) : super (fullname, phoneNumber, id, male)

  factory Helper.fromMap(Map<String, dynamic> json) => Helper(
        id: json["id"],
        fullname: json["fullname"],
        phoneNumber: json["phoneNumber"],
        male: json["male"] == "male",
        services: json["services"],
        areas: json["areas"]
      );

  Map<String, dynamic> toMap() => {
        
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
