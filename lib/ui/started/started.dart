import 'package:boilerplate/models/common.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'staticdata.dart';

class StartedScreen extends StatefulWidget {
  @override
  _StartedScreenState createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  String city = "";
  String area = "";
  List<String> services = new List();
  User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = ModalRoute.of(context).settings.arguments;
    //getLocation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: _buildStartedScreen(),
      bottomNavigationBar: BottomAppBar(
          child: FlatButton(
              onPressed: () {
                currentUser.address = new Address(area: area, city: city);
                currentUser.services = services;
                Navigator.pushNamed(context, Routes.home,
                    arguments: currentUser);
              },
              child: Text('Proceed'))),
    );
  }

  Widget _buildStartedScreen() {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDetectLocation(),
                  _buildSelectCity(),
                  _buildSelectArea(),
                  _buildSelectServices()
                ])));
  }

  Widget _buildDetectLocation() {
    return RaisedButton(
        onPressed: () {
          this.city = "Bengaluru";
          this.area = "JP Nagar";
        },
        child: Text('Detect Location'));
  }

  Widget _buildSelectCity() {
    return DropdownButton<String>(
      value: city == "" ? "Enter your city ..." : city,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          city = newValue;
        });
      },
      items: StartedData.cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildSelectArea() {
    return DropdownButton<String>(
      value: city == "" ? "Enter your city ..." : city,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          city = newValue;
        });
      },
      items: StartedData.cities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildSelectServices() {
    return ListView(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(left: 14.0, top: 14.0),
        child: Text(
          "Select Your Services",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      CheckboxGroup(
        labels: StartedData.services,
        onSelected: (List<String> checked) {
          services = checked;
        },
        disabled: ['Gardening'],
      )
    ]);
  }
}
