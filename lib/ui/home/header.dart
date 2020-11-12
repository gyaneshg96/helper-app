import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class HeaderWithSearchBox extends StatelessWidget {
  final TextEditingController controller;

  HeaderWithSearchBox({Key key, @required this.size, @required this.controller})
      : super(key: key);

  final Size size;
  Position _currentPosition;
  final Geolocator geolocator = Geolocator();

  void _getCurrentLocation() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    /*if (!await Geolocator.isLocationServiceEnabled()) {
      return;
    }*/
    _currentPosition = await Geolocator.getLastKnownPosition();
    if (_currentPosition == null) {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
    }
    _getAddressFromLatLng();
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      String _currentAddress = "${place.locality}, ${place.administrativeArea}";
      controller.text = _currentAddress;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.default_padding * 2.5),
      height: size.height * 0.18,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: Dimens.default_padding,
              right: Dimens.default_padding,
              bottom: 36 + Dimens.default_padding,
            ),
            height: size.height * 0.18 - 10,
            decoration: BoxDecoration(
              color: AppColors.greenBlue[500],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                /*Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    isSwitched = value;
                    print(isSwitched);
                  },
                  activeTrackColor: AppColors.greenBlueAccent[200],
                  activeColor: AppColors.greenBlue[700],
                ),*/
                /*FlutterSwitch(
                    value: isSwitched,
                    width: 70.0,
                    height: 35.0,
                    valueFontSize: 25.0,
                    toggleSize: 45.0,
                    padding: 8.0,
                    activeText: "Housekeep",
                    inactiveText: "Cook",
                    inactiveColor: AppColors.greenBlueAccent[200],
                    activeColor: AppColors.greenBlue[700],
                    showOnOff: true,
                    onToggle: (val) {
                      isSwitched = !isSwitched;
                    }),*/
                ClipOval(
                    child: Material(
                        color: AppColors.greenBlue[50],
                        child: InkWell(
                            // color: AppColors.greenBlueAccent[200],
                            child: IconButton(
                                icon: Icon(Icons.pin_drop_sharp),
                                color: AppColors.greenBlue[600],
                                // color: Co,
                                tooltip: "Get Your location",
                                onPressed: () {
                                  _getCurrentLocation();
                                })))),
                Spacer(),
                Image.asset("assets/images/saywah_logo_low.png")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: Dimens.default_padding),
              padding: EdgeInsets.symmetric(horizontal: Dimens.default_padding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                /*boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: AppColors.greenBlue[500].withOpacity(0.23),
                  ),
                ],*/
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {},
                      style: TextStyle(
                        color: AppColors.greenBlue[700],
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColors.greenBlue[700],
                          fontSize: 18,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  //SvgPicture.asset("assets/icons/search.svg"),
                  Icon(Icons.search, color: AppColors.greenBlue[700]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
