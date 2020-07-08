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

  Helper({fullname, phoneNumber, id, male, areas, services})
      : this.areas = areas,
        this.services = services,
        super(id: id, fullname: fullname, phoneNumber: phoneNumber, male: male);

  factory Helper.fromMap(Map<String, dynamic> json) => Helper(
      id: int.parse(json["id"]),
      fullname: json["fullname"],
      phoneNumber: json["phoneNumber"],
      male: json["male"] == 'true',
      services: List<String>.from(json["services"]),
      areas: List<String>.from(json["areas"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "fullname": fullname,
        "phoneNumber": phoneNumber,
        "male": male,
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
