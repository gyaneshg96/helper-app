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

  User({
    fullname,
    phoneNumber,
    id,
    male,
    this.password
  }) : super (fullname, phoneNumber, id, male);
}
