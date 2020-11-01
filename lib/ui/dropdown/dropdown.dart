import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/utils/authentication/extrautils.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String name;

  Dropdown(this.name);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Text(
                'Hi $name',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: AppColors.greenBlue[700],
              )),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Your orders'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.forward),
            title: Text('Refer App'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.forward),
            title: Text('Insert Helper'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Feedback/Contact'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('About'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await ExtraUtils.logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
