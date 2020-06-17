class Person {
  String fullname;
  int id;
  String phoneNumber;
  bool male;
  Address address;
  DateTime joining;

  Person(String fullname, String phoneNumber) {
    this.fullname = fullname;
    this.phoneNumber = phoneNumber;
  }
}

class Address {
  String street;
  int pincode;
  String city;
  String state;
}

class Ratings {
  List list = new List(5);

  double getTotalRating() {
    int i, users = 0;
    double sum = 0;
    for (i = 0; i < 5; i++) {
      sum += list[i] * (i + 1);
      users += list[i];
    }
    return sum / users;
  }
}
