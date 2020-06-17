import 'dart:ui';

import 'package:boilerplate/data/models/common.dart';

class Helper extends Person {
  Image image;
  List<Review> reviews;
  Ratings ratings;
  List slots;
  String idproofNumber;
  List<String> services;
  int currentUsers;
  int totalUsers;

  Helper(String fullname, String phoneNumber) : super(fullname, phoneNumber);
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
