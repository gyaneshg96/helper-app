import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/helper/helper_store.dart';
import 'package:boilerplate/ui/dropdown/dropdown.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  HelperStore _helperStore;
  //ThemeStore _themeStore;
  
  User currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores

    //no dark theme for now
    //_themeStore = Provider.of<ThemeStore>(context);
    
    _helperStore = Provider.of<HelperStore>(context);

    //will fetch username from server or cache

    /*currentUser = User('Gyan', '873298229');
    currentUser.helpers = List();
    currentUser.helpers.add(Helper('ABC', '682322398'));
    currentUser.helpers.add(Helper('XYZ', '283298434'));
    currentUser.helpers.add(Helper('Bai', '323128317'));*/

    // check to see if already called api
    if (!_helperStore.loading) {
      _helperStore.getHelpers(currentUser);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
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
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    List<Helper> currentHelpers = currentUser.helpers;
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

  Widget _buildListItem(Helper helper) {
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
      onTap: () => {Navigator.pushNamed(context, Routes.helperProfile)},
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
