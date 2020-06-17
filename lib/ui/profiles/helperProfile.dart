import 'package:boilerplate/data/models/helper.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HelperProfile extends StatefulWidget {
  @override
  _HelperProfileState createState() => _HelperProfileState();
}

//move this somewhere else
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HelperProfileState extends State<HelperProfile> {
  _HelperProfileState();
  Helper helper;
  bool myHelper = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //will fetch username from server or cache

    helper = Helper('Kantabai', '8232398123');
    helper.services = [
      'Washing bathroom',
      'Utensils, mopping and trash collecting',
      'Dusting one a month',
      'Ironing'
    ];
    helper.reviews = new List();
    helper.reviews.add(new Review("Gaand faad diya"));
    helper.reviews.add(new Review("Gandiya faad diya"));
    helper.reviews.add(new Review("Ghanta"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            leading: BackButton(color: Colors.white),
            actions: <Widget>[
              Checkbox(
                  value: myHelper,
                  onChanged: (bool value) {
                    myHelper = value;
                  }),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => {
                  //
                },
              )
            ]),
        body: _makeBody());
  }

  Widget _makeBody() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _makeIntro(),
        _makeServicesSection(),
        _makeAvailability(),
        _makeReviewSection()
      ],
    ));
  }

  Widget _makeIntro() {
    return Row(children: <Widget>[
      Container(
          width: 140.0,
          height: 140.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/img_login.jpg'),
              fit: BoxFit.cover,
            ),
          )),
      Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(helper.fullname),
            Text(helper.phoneNumber),
            Text('Rating : 95%')
          ],
        ),
      )
    ]);
  }

  //what the helper can do
  Widget _makeServicesSection() {
    List services = helper.services;
    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i) {
            return new ListTile(
                leading: MyBullet(), title: new Text(services[i]));
          }),
    );
  }

  //what time of the day available
  Widget _makeAvailability() {
    return Container(height: 200, child: Text('Not available at all'));
  }

  Widget _makeReviewSection() {
    CarouselController controller = CarouselController();
    return Column(children: <Widget>[
      CarouselSlider.builder(
        options: CarouselOptions(height: 300),
        carouselController: controller,
        itemCount: helper.reviews.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(child: Text(helper.reviews[i].comment));
        },
      ),
      RaisedButton(
        onPressed: () => controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear),
        child: Text('→'),
      )
    ]);
  }
}
