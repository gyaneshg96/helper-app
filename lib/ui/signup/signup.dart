import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../../stores/theme/theme_store.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;

  //focus node:-----------------------------------------------------------------
  FocusNode _passwordFocusNode;

  //form key:-------------------------------------------------------------------
  final _formKey = GlobalKey<FormState>();

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

  @override
  void initState() {
    super.initState();

    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          primary: true,
          appBar: EmptyAppBar(),
          body: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Material(
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildLeftSide(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    ));
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        'assets/images/img_login.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppIconWidget(image: 'assets/icons/ic_appicon.png'),
                  TabBar(
                    labelColor: Colors.blueGrey,
                    tabs: <Widget>[
                      Tab(text: 'Using Email'),
                      Tab(text: 'Using Phone')
                    ],
                  ),
                  _buildFullNameField(),
                  Container(
                      height: 600,
                      child: TabBarView(
                        children: <Widget>[
                          SizedBox(
                              height: 500,
                              width: 300,
                              child: Column(
                                children: <Widget>[
                                  _buildEmailIdField(),
                                  _buildPasswordField(),
                                  _buildSignUpButton(false),
                                  _googleButton(),
                                  _facebookButton()
                                ],
                              )),
                          SizedBox(
                              height: 500,
                              width: 300,
                              child: Column(
                                children: <Widget>[
                                  _buildPhoneNumberField(),
                                  _buildPasswordField(),
                                  _buildSignUpButton(true),
                                  _googleButton(),
                                  _facebookButton()
                                ],
                              ))
                        ],
                      )),
                ]),
          ),
        ));
  }

  Widget _buildEmailIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('signup_et_user_email'),
          inputType: TextInputType.emailAddress,
          icon: Icons.email,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildFullNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('signup_et_full_name'),
          inputType: TextInputType.text,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _fullNameController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.fullName,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('signup_et_user_password'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _googleButton() {
    return Flexible(
        flex: 1,
        child: GoogleSignInButton(
          onPressed: () {
            //google api
          },
        ));
  }

  Widget _facebookButton() {
    return Flexible(
        flex: 1,
        child: FacebookSignInButton(
          onPressed: () {
            //facebook api
          },
        ));
  }

  Widget _buildPhoneNumberField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('signup_et_phone_number'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.phone,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _phoneNumberController,
          errorText: _store.formErrorStore.phoneNumber,
          onChanged: (value) {
            _store.setPassword(_phoneNumberController.text);
          },
        );
      },
    );
  }

  Widget _buildSignUpButton(bool phone) {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate("signup_btn_sign_up"),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () async {
        if (phone ? _store.canRegisterPhoneNumber : _store.canRegisterEmail) {
          DeviceUtils.hideKeyboard(context);
          var success = await _store.register();
          if (success.isNotEmpty) {
            Navigator.pushNamed(context, Routes.started, arguments: success);
          }
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
    );
  }

  //General Methods
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

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _phoneNumberController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }
}
