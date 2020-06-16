import 'dart:html';

import 'package:boilerplate/data/models/helper.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HelperProfile extends StatefulWidget {
  Helper helper;
  bool myHelper;
  @override
  _MaidProfileState createState() {
    // TODO: implement createState
    _MaidProfileState();
  }
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

class _MaidProfileState extends State<HelperProfile> {
  Helper helper;
  bool myHelper = false;

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
          children: <Widget>[],
        ),
      )
    ]);
  }

  //what the helper can do
  Widget _makeServicesSection() {
    List services = helper.services;
    return Container(
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i) {
            return new ListTile(
                leading: MyBullet(), title: new Text(services[i]));
          }),
    );
    /*return Container(
      child: Column(children: <Widget>[
        new ListTile(
          leading: new MyBullet(),
          title: new Text('Utensils, mopping and trash collecting'),
        ),
        new ListTile(
          leading: new MyBullet(),
          title: new Text('Washing bathroom'),
      ),
      new ListTile(
          leading: new MyBullet(),
          title: new Text('Dusting one a month'),
        ),
        new ListTile(
          leading: new MyBullet(),
          title: new Text('Ironing'),
    )]));*/
  }

  //what time of the day available
  Widget _makeAvailability() {
    return null;
  }

  Widget _makeReviewSection() {
    List<Review> reviews = helper.reviews;
    CarouselController controller = CarouselController();
    return Column(children: <Widget>[
      CarouselSlider.builder(
        options: CarouselOptions(height: 400),
        carouselController: controller,
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(child: Text(reviews[i].comment));
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
