import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:boilerplate/data/models/common.dart';

class Helper extends Person {
  Image image;
  List<Review> reviews;
  Ratings ratings;
  List slots;
  String idproofNumber;
  List services;
  int currentUsers;
  int totalUsers;
}

class Review {
  int userId;
  int id;
  int helperId;
  String comment;
  DateTime posted;
}

class Slot {
  DateTime start;
  DateTime end;
  bool available;
}
