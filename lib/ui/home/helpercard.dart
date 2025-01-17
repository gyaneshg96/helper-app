import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HelperCard extends StatelessWidget {
  const HelperCard({
    Key key,
    this.image,
    this.name,
    this.locations,
    this.press,
    this.roles,
    this.gender,
  }) : super(key: key);

  final String image, name, locations, roles;
  final Function press;
  final int gender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: Dimens.default_padding,
        top: Dimens.default_padding,
        bottom: Dimens.default_padding,
        right: Dimens.default_padding,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              height: size.height * 0.15,
              padding: EdgeInsets.only(right: Dimens.default_padding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: 5,
                    color: AppColors.greenBlue[700].withOpacity(0.5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    child: Image.asset(image,
                        height: 150, width: 100, fit: BoxFit.fitHeight),
                  ),
                  SizedBox(width: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$name\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        WidgetSpan(child: SizedBox(height: 30)),
                        TextSpan(
                          text: "$locations".toUpperCase(),
                          style: TextStyle(
                            color: AppColors.greenBlue[500].withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      /*TextSpan(
                            text: "M\n",
                            style: Theme.of(context).textTheme.button),
                        */
                      SizedBox(height: 25),
                      Row(children: [
                        gender == 0
                            ? Icon(MdiIcons.genderMale)
                            : Icon(MdiIcons.genderFemale),
                      ]),
                      SizedBox(height: 12),
                      Text(
                        "$roles".toUpperCase(),
                        style: TextStyle(
                          color: AppColors.greenBlue[500].withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  /*RichText(
                      text: TextSpan(
                      children: [
                    TextSpan(
                      text: male == true ? "M\n" : "F\n",
                      style: TextStyle(
                        color: AppColors.greenBlue[500].withOpacity(0.5),
                      ),
                    ),
                    WidgetSpan(child: SizedBox(height: 30)),
                    TextSpan(
                      text: "$roles".toUpperCase(),
                      style: TextStyle(
                        color: AppColors.greenBlue[500].withOpacity(0.5),
                      ),
                    ),
                    /*Text(
                    '$roles',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: AppColors.greenBlue[500]),*/
                  ]))*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
