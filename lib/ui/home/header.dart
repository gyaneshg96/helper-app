import 'package:boilerplate/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:flutter_switch/flutter_switch.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.default_padding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: Dimens.default_padding,
              right: Dimens.default_padding,
              bottom: 36 + Dimens.default_padding,
            ),
            height: size.height * 0.2 - 27,
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
                FlutterSwitch(
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
                    }),
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
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColors.greenBlue[700].withOpacity(0.5),
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
