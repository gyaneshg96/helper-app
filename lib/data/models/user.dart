import 'package:boilerplate/data/models/common.dart';
import 'package:boilerplate/data/models/helper.dart';

class User extends Person {
  String emailId;
  String password;
  List orders;
  List<Helper> helpers;
  List savedPayments;
  List preferences;
  List pastOrder;
}
