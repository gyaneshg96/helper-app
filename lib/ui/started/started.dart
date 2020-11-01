import 'package:boilerplate/models/common.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'staticdata.dart';

class StartedScreen extends StatefulWidget {
  @override
  _StartedScreenState createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  String city;
  String area;
  List<String> services = new List();
  static final ErrorStore errorStore = ErrorStore();
  String userId;

  @override
  void initState() {
    super.initState();
    city = 'Enter your city';
    area = 'Enter your area';
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userId = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: _buildStartedScreen(),
      bottomNavigationBar: BottomAppBar(
          child: FlatButton(
              onPressed: () async {
                if (canProceed) {
                  try {
                    await _pushUserData();
                    Route home = MaterialPageRoute(
                        //builder: (context) => HomeScreen(userId: userId));
                        builder: (context) => HomeScreen());
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, home);
                  } catch (e) {
                    errorStore.errorMessage = "Cant push details";
                  }
                } else {
                  errorStore.errorMessage = "Incomplete Details";
                }
              },
              child: Text('Proceed'))),
    );
  }

  bool get canProceed =>
      area.isNotEmpty && city.isNotEmpty && services.length == 0;

  Future<void> _pushUserData() async {
    Firestore store = Firestore.instance;
    await store
        .collection('users')
        .document(userId)
        .setData({area: area, city: city}, merge: true);
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
                  _buildHeading(),
                  _buildCheckBoxes()
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
      value: this.city,
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
          this.city = newValue;
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
      value: this.area,
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
          this.area = newValue;
        });
      },
      items: StartedData.areas[this.city]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildHeading() {
    return Container(
      padding: const EdgeInsets.only(left: 14.0, top: 14.0),
      child: Text(
        "Select Your Services",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }

  Widget _buildCheckBoxes() {
    return CheckboxGroup(
      labels: StartedData.services,
      onSelected: (List<String> checked) {
        services = checked;
      },
      disabled: ['Gardening'],
    );
  }
}
