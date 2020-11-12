class Person {
  String fullname;
  String id;
  String phoneNumber;
  int gender;
  Address address;
  DateTime joining;

  Person(
      {this.fullname,
      this.phoneNumber,
      this.id,
      this.gender,
      this.address,
      this.joining});

  /*generateId() {
    Uuid uuid = Uuid();
    String a = uuid.v4();
    print(a);
  }*/
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
  List list;

  Ratings(list) {
    this.list = list;
  }

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
