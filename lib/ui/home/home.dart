import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/helper/helper_store.dart';
import 'package:boilerplate/ui/dropdown/dropdown.dart';
import 'package:boilerplate/ui/home/header.dart';
import 'package:boilerplate/ui/home/listitem.dart';
import 'package:boilerplate/ui/home/richtext.dart';
import 'package:boilerplate/ui/profiles/helperProfile.dart';
import 'package:boilerplate/utils/authentication/baseauth.dart';
import 'package:boilerplate/utils/authentication/extrautils.dart';
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
  final String userId = "0";
  //guest

  //HomeScreen({this.userId, this.auth});
  //HomeScreen({this.userId});

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  HelperStore _helperStore;
  Future<List<Helper>> helpers;
  String selectedCategory;
  final GlobalKey _scaffoldKey = new GlobalKey();
  final locationController = TextEditingController();
  final List<String> categories = ['Cook', 'Housekeep', 'Both'];
  TabController _tabController;
  //ThemeStore _themeStore;
  //static final Firestore store = Firestore.instance;

  User currentUser;

  @override
  void initState() {
    super.initState();
    /*store
        .collection('users')
        .document(widget.userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        currentUser = User(fullname: snapshot.data["fullName"]);
      });
    });*/
    _tabController = new TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    // initializing stores

    //no dark theme for now
    //_themeStore = Provider.of<ThemeStore>(context);

    _helperStore = HelperStore();
    currentUser = User(fullname: "Sallu");

    // currentUser = ModalRoute.of(context).settings.arguments;
    helpers = _helperStore.getHelpers2("cooks", "btm");

    //will fetch username from server or cache

    // check to see if already called api
  }

  @override
  Widget build(BuildContext context) {
    String name = "Guest";
    //String name = currentUser.fullname;
    return Scaffold(
      key: this._scaffoldKey,
      appBar: _buildAppBar(_scaffoldKey),
      resizeToAvoidBottomPadding: false,
      body: _buildBody(),
      drawer: Dropdown(name),
      /*bottomNavigationBar: BottomAppBar(
        color: AppColors.greenBlue[500],
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
      )*/
    );
  }

  // app bar methods:-----------------------------------------------------------
  Widget _buildAppBar(GlobalKey _scaffoldKey) {
    return AppBar(
      //actions: _buildActions(context),
      elevation: 5,
      leading: IconButton(
        //icon: SvgPicture.asset("assets/icons/menu.svg"),
        icon: Icon(Icons.menu),
        onPressed: () => {
          if (Scaffold.of(context).isEndDrawerOpen)
            {Scaffold.of(context).openDrawer()}
          else
            {Navigator.of(context).pop()}
        },
      ),
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
        await ExtraUtils.logOut(context);
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    // String selectedCategory = "Cook";
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size, controller: locationController),
          _buildTabSelector(categories),
          //_buildCategorySelector(categories, selectedCategory),
          SizedBox(
            height: 10,
          ),
          Divider(),
          _buildTitle(),
          Divider(),
          _buildMainContent(size.height),
        ]);
  }

  Widget _buildTabSelector(List<String> categories) {
    List<Tab> tabs = List();
    for (int i = 0; i < categories.length; i++) {
      tabs.add(_buildSingleTab(i));
    }
    return TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        controller: _tabController,
        unselectedLabelColor: AppColors.greenBlue[700],
        labelColor: AppColors.greenBlue[100],
        indicator: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.greenBlue[400], AppColors.greenBlue[100]]),
            borderRadius: BorderRadius.circular(50)),
        tabs: tabs);
  }

  Widget _buildSingleTab(i) {
    return Tab(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.greenBlue[700], width: 2)),
          child: Align(
            alignment: Alignment.center,
            child: Text(categories[i],
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.greenBlue[900],
                    fontWeight: FontWeight.bold)),
          )),
    );
  }
  /*Widget _buildCategorySelector(categories, selectedCategory) {
    return Container(
      height: 35,
      child: ListView.separated(
          itemCount: categories.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 10,
            );
          },
          itemBuilder: (context, index) {
            return CategoryTile(
              category: categories[index],
              isSelected: selectedCategory == categories[index],
              context: this,
              selectedCategory: selectedCategory,
            );
          }),
    );
  }*/

  Widget _buildTitle() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.default_padding),
        child: TitleWithCustomUnderline(text: "Helpers"));
  }

  Widget _buildMainContent(size) {
    List<Widget> screens = List();
    for (int i = 0; i < categories.length; i++) {
      screens.add(_buildScreen(size, i));
    }
    return Container(
        height: size * 0.45,
        child: TabBarView(controller: _tabController, children: screens));
  }

  Widget _buildScreen(size, i) {
    return Container(
        height: size * 0.5,
        child: Observer(
          builder: (context) {
            return _helperStore.loading
                ? CustomProgressIndicatorWidget()
                : _buildAsyncList(i);
          },
        ));
  }

  FutureBuilder _buildAsyncList(int i) {
    // helpers = _helperStore.getHelpers2(i, locationController.text);
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
  }

  /*StreamBuilder _buildFirestoreList() {
    return StreamBuilder(
        stream: store.collection("helpers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return _buildListView(snapshot.data.documents);
        });
  }*/

  Widget _buildListView(List currentHelpers) {
    return currentHelpers != null
        ? ListView.builder(
            itemCount: currentHelpers.length,
            shrinkWrap: true,
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
      // newhelper.areas = List<String>.from(helper['areas']);
      newhelper.areas = helper['areas'];
      newhelper.services = List<String>.from(helper['services']);
      helper = newhelper;
    }
    // print(helper.areas.join(','));
    return HelperCard(
        image: "assets/images/test_pic.jpg",
        name: helper.fullname,
        // locations: helper.areas.join(','),
        locations: helper.areas,
        roles: helper.services.join(','),
        gender: helper.gender,
        press: () {
          Navigator.pushNamed(context, Routes.helperProfile, arguments: helper);
        });
  }

  // ignore: unused_element
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
