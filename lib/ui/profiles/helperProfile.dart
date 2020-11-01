import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/helper/helper.dart';
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
      height: 5.0,
      width: 5.0,
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

    helper = ModalRoute.of(context).settings.arguments;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange,
            leading: BackButton(color: Colors.amber[50]),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0)),
        _makeIntro(),
        Padding(padding: EdgeInsets.all(10.0)),
        Divider(),
        _servicesHeading(),
        Divider(),
        _makeServicesSection(),
        Divider(),
        _locationsServed()
        // _makeAvailability(),
        // _makeReviewSection()
      ],
    ));
  }

  Widget _locationsServed() {
    return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
            itemCount: helper.areas.length,
            padding: EdgeInsets.all(3),
            itemBuilder: (BuildContext context, int i) {
              return _singleLocation(helper.areas[i]);
            }));
  }

  Widget _singleLocation(String location) {
    return ListTile(title: Text(location));
  }

  Widget _makeIntro() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/img_login.jpg'),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(helper.fullname,
                        style: TextStyle(
                            fontFamily: FontFamily.productSans,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    subtitle: Text(helper.phoneNumber,
                        style: TextStyle(fontSize: 20)),
                  )))
        ]);
  }

  //what the helper can do
  Widget _makeServicesSection() {
    List services = helper.services;
    return Container(
      height: 50,
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i) {
            return new ListTile(
                leading: MyBullet(),
                title: new Text(
                  services[i],
                  style: TextStyle(
                      fontFamily: FontFamily.roboto,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ));
          }),
    );
  }

  //what time of the day available
  Widget _makeAvailability() {
    return Container(height: 200, child: Text('Not available at all'));
  }

  Widget _servicesHeading() {
    return Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text('Services',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: FontFamily.roboto, fontSize: 20)));
  }

  Widget _makeReviewSection() {
    CarouselController controller = CarouselController();
    return Column(children: <Widget>[
      CarouselSlider.builder(
        options: CarouselOptions(height: 300),
        carouselController: controller,
        itemCount: helper.areas.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(child: Text(helper.areas[i]));
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
