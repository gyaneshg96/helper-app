import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/helper/helper_store.dart';
import 'package:boilerplate/ui/dropdown/dropdown.dart';
import 'package:boilerplate/utils/authentication/baseauth.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  //will stay constant over the course of time
  final String userId;
  // HomeScreen({this.userId, this.auth});
  HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  HelperStore _helperStore;
  //ThemeStore _themeStore;
  static final Firestore store = Firestore.instance;

  User currentUser;

  @override
  void initState() {
    super.initState();
    store
        .collection('users')
        .document(widget.userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      currentUser = User(fullname: snapshot["fullname"]);
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    // initializing stores

    //no dark theme for now
    //_themeStore = Provider.of<ThemeStore>(context);

    _helperStore = HelperStore();
    // currentUser = ModalRoute.of(context).settings.arguments;
    //helpers = _helperStore.getHelpers(currentUser);

    //will fetch username from server or cache

    // check to see if already called api
  }

  @override
  Widget build(BuildContext context) {
    // String name = fbUser.displayName;
    String name = currentUser.fullname;
    final GlobalKey _scaffoldKey = new GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(_scaffoldKey),
      body: _buildBody(),
      drawer: Dropdown(name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  //search for a made
                }),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                //lists the marked for later helpers
              },
            )
          ],
        ),
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  Widget _buildAppBar(GlobalKey _scaffoldKey) {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_posts')),
      actions: _buildActions(context),
      /*leading: IconButton(
        icon: Icon(Icons.gamepad, color: Colors.white),
        onPressed: () => {
          if (Scaffold.of(context).isEndDrawerOpen)
            {Scaffold.of(context).openDrawer()}
          else
            {Navigator.of(context).pop()}
        },
      ),*/
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[_buildLogoutButton(), _buildSOSButton()];
  }

  Widget _buildSOSButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            launch("tel://100");
          },
          icon: Icon(Icons.help),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Navigator.of(context).popUntil((route) => route.isFirst);
        preferences.setBool(Preferences.is_logged_in, false);
        preferences.setString(Preferences.auth_token, "");
        Navigator.of(context).pushReplacementNamed(Routes.splash);
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(children: <Widget>[_buildMainContent()]);
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _helperStore.loading
            ? CustomProgressIndicatorWidget()
//            : Material(child: _buildAsyncList());
            : Material(child: _buildFirestoreList());
      },
    );
  }

  /*FutureBuilder _buildAsyncList() {
    return FutureBuilder<List<Helper>>(
      future: helpers,
      builder: (BuildContext context, AsyncSnapshot<List<Helper>> snapshot) {
        if (snapshot.hasData) {
          List<Helper> helpers = snapshot.data;
          return _buildListView(helpers);
        }
        if (snapshot.hasError) {
          return _buildListView(null);
        }
        return Container();
      },
    );
  }*/

  StreamBuilder _buildFirestoreList() {
    return StreamBuilder(
        stream: store.collection("helpers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return _buildListView(snapshot.data.documents);
        });
  }

  Widget _buildListView(List currentHelpers) {
    return currentHelpers != null
        ? ListView.separated(
            itemCount: currentHelpers.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(currentHelpers[position]);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_helper_found'),
            ),
          );
  }

  Widget _buildListItem(helper) {
    if (helper is DocumentSnapshot) {
      Helper newhelper = new Helper();
      newhelper.fullname = helper['fullname'];
      newhelper.phoneNumber = helper['phoneNumber'];
      newhelper.areas = List<String>.from(helper['areas']);
      newhelper.services = List<String>.from(helper['services']);
      helper = newhelper;
    }
    return ListTile(
      dense: true,
      leading: Icon(Icons.person_pin_circle),
      //image of a person
      title: Text(
        helper.fullname,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      subtitle: Text(
        helper.phoneNumber,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.helperProfile, arguments: helper);
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_helperStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_helperStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  //No language support now

  /*_buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }*/

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
