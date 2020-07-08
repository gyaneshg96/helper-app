class Person {
  String fullname;
  int id;
  String phoneNumber;
  bool male;
  Address address;
  DateTime joining;

  Person(
      {this.fullname,
      this.phoneNumber,
      this.id,
      this.male,
      this.address,
      this.joining});
}

class Address {
  String house;
  String street;
  String area;
  String city;
  String pincode;

  Address({this.house, this.street, this.area, this.city, this.pincode});
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
