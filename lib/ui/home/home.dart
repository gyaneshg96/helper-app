import 'dart:async';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/helper/helper_store.dart';
import 'package:boilerplate/ui/dropdown/dropdown.dart';
import 'package:boilerplate/ui/home/header.dart';
import 'package:boilerplate/ui/home/helpercard.dart';
import 'package:boilerplate/ui/home/richtext.dart';
import 'package:boilerplate/ui/home/shimmercard.dart';
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
import 'package:shimmer/shimmer.dart';
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
  bool connected;
  List<Future<List<Helper>>> allhelpers;
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

    _helperStore = HelperStore();
    currentUser = User(fullname: "Sallu");
    connected = false;

    Timer.periodic(Duration(seconds: 5), (timer) async {
      String str = await _helperStore.healthCheck();
      if (str == "OK" && connected == false) {
        setState(() {
          connected = true;
          populateHelpers();
        });
      }
      if (str == "" && connected == true) {
        setState(() {
          connected = false;
        });
      }
    });

    _tabController = new TabController(length: 3, initialIndex: 0, vsync: this);
  }

  serverHealthCheck() {}

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    // initializing stores

    //no dark theme for now
    //_themeStore = Provider.of<ThemeStore>(context);

    // currentUser = ModalRoute.of(context).settings.arguments;
    /*String str = await _helperStore.healthCheck();
    if (str == "") {
      retryFuture(_helperStore.healthCheck, 5);
    }*/
    populateHelpers();

    //will fetch username from server or cache

    // check to see if already called api
  }

  void populateHelpers() {
    allhelpers = List();
    for (int i = 0; i < 3; i++) {
      allhelpers.add(
          _helperStore.getHelpers2(indexToString(i), locationController.text));
    }
  }

  void retryFuture(future, delay) {
    Future.delayed(Duration(seconds: delay), () {
      future();
    });
  }

  String indexToString(int index) {
    switch (index) {
      case 0:
        return "cooks";
      case 1:
        return "housekeep";
      case 2:
        return "helpers";
    }
    return "helpers";
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

  //TODO: use toggle buttons
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
                colors: [AppColors.greenBlue[500], AppColors.greenBlue[200]]),
            borderRadius: BorderRadius.circular(50)),
        tabs: tabs);
  }

  Widget _buildSingleTab(i) {
    return Tab(
      child: Container(
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Align(
            alignment: Alignment.center,
            child: Text(categories[i].toUpperCase(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
    // _helperStore.loading = true;
    return Container(
        height: size * 0.5,
        child: Observer(
          builder: (context) {
            return _helperStore.loading
                ? _buildShimmerWidget()
                : _buildAsyncList(i);
          },
        ));
  }

  Widget _buildShimmerWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
              child: Shimmer.fromColors(
                  baseColor: AppColors.greenBlue[300],
                  highlightColor: AppColors.greenBlue[100],
                  enabled: true,
                  child: ListView.builder(
                    itemBuilder: (_, __) => ShimmerCard(),
                    itemCount: 3,
                  )))
        ]));
  }

  FutureBuilder _buildAsyncList(int i) {
    // helpers = _helperStore.getHelpers2(i, locationController.text);
    return FutureBuilder<List<Helper>>(
      future: allhelpers[i],
      builder: (BuildContext context, AsyncSnapshot<List<Helper>> snapshot) {
        if (snapshot.hasData) {
          List<Helper> helpers = snapshot.data;
          return _buildListView(helpers);
        }
        return _buildListView(null);
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
    if (currentHelpers == null) {
      return Center(
          child: Column(children: <Widget>[
        SizedBox(height: 30),
        ColorFiltered(
          child: Image.asset("assets/images/no_internet2.jpg",
              height: 150, width: 150),
          colorFilter:
              ColorFilter.mode(AppColors.greenBlue[300], BlendMode.color),
        ),
        SizedBox(height: 30),
        Text(AppLocalizations.of(context).translate('server_error'),
            style: TextStyle(
                color: AppColors.greenBlue[700],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ]));
    }
    if (currentHelpers.length == 0) {
      return Center(
          child: Column(children: <Widget>[
        SizedBox(height: 30),
        ColorFiltered(
          child: Image.asset("assets/images/not_found.jpg",
              height: 150, width: 150),
          colorFilter:
              ColorFilter.mode(AppColors.greenBlue[500], BlendMode.color),
        ),
        SizedBox(height: 30),
        Text(AppLocalizations.of(context).translate('home_tv_no_helper_found'),
            style: TextStyle(
                color: AppColors.greenBlue[700],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ]));
    }
    return ListView.builder(
      itemCount: currentHelpers.length,
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return _buildListItem(currentHelpers[position]);
      },
    );
  }

  //use a simple heuristic to keep length of string in check
  String prioritiseLocations(String locations) {
    locations = locations.trim();
    if (locations.length > 0 && locations[locations.length - 1] == ',') {
      locations = locations.substring(0, locations.length - 1);
    }
    List<String> listt = locations.split(',');
    int pos = 0;
    for (int i = 0; i < listt.length; i++) {
      if (listt[i].contains(locationController.text)) {
        pos = i;
        break;
      }
    }
    String removed = listt.removeAt(pos);
    //apply heuristic
    if (listt.length == 0 || (removed.length + listt[0].length) > 20) {
      return removed;
    }
    return removed + ", " + listt[0];
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
        image: helper.gender == 0
            ? "assets/images/blank_man.jpg"
            : "assets/images/blank_woman",
        name: helper.fullname,
        // locations: helper.areas.join(','),
        locations: prioritiseLocations(helper.areas),
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
