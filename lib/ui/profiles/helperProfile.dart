import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/common.dart';
import 'package:boilerplate/models/helper/helper.dart';
import 'package:boilerplate/ui/home/richtext.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class HelperProfile extends StatefulWidget {
  @override
  _HelperProfileState createState() => _HelperProfileState();
}

class _HelperProfileState extends State<HelperProfile> {
  _HelperProfileState();
  Helper helper;
  bool myHelper = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //will fetch username from server or cache

    helper = ModalRoute.of(context).settings.arguments;
    helper.ratings = Ratings([0, 2, 10, 14, 11]);
    helper.reviews = new List<Review>();
    for (int i = 0; i < 4; i++) {
      helper.reviews.add(Review(
          "Over 8+ years of experience and web development and 5+ years of experience in mobile applications development "));
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.greenBlue[500],
          leading: BackButton(),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  myHelper ? Icons.star : Icons.star_border,
                ),
                onPressed: () {
                  setState(() {
                    myHelper = !myHelper;
                  });
                }),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => {
                //
              },
            )
          ]),
      body: _makeBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.greenBlue[500],
          focusColor: AppColors.greenBlue[200],
          child: Icon(Icons.phone)),
    );
  }

  Widget _buildLocationRole(String company) {
    return Container(
      height: 30,
      padding: EdgeInsets.all(Dimens.default_padding / 3.5),
      child: Text(
        company,
        style: TextStyle(
            fontSize: 15,
            color: AppColors.greenBlue[900],
            fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Widget> _buildRatingsSection() {
    List<Widget> section = [];
    if (helper.ratings == null || helper.ratings.list.length == 0) {
      return section;
    }
    section.add(TitleWithCustomUnderline(text: "Ratings"));
    section.add(SizedBox(height: 20));
    int sum = helper.ratings.list.fold(0, (p, c) => p + c);
    for (int i = 4; i >= 0; i--) {
      section.add(SizedBox(height: 10));
      section.add(_buildSkillRow(
          (i + 1).toString(), helper.ratings.list[i] * 1.0 / sum));
    }
    section.add(SizedBox(height: 20));
    return section;
  }

  Row _buildSkillRow(String skill, double level) {
    return Row(
      children: <Widget>[
        Container(
            width: 20,
            child: Text(
              skill.toUpperCase(),
              textAlign: TextAlign.right,
            )),
        SizedBox(width: 10.0),
        Expanded(
          flex: 4,
          child: LinearProgressIndicator(
            value: level,
            backgroundColor: AppColors.greenBlue[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenBlue[700]),
          ),
        ),
        SizedBox(width: 30.0),
      ],
    );
  }

  Widget _makeIntro2(size) {
    String image = "assets/images/test_pic.jpg";
    // String image = helper.image;
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
          child: Image.asset(image,
              height: 150, width: 100, fit: BoxFit.fitHeight),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 222,
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                helper.fullname,
                style: TextStyle(fontSize: 32, color: AppColors.greenBlue[900]),
              ),
              SizedBox(height: 20),
              Text(
                // helper.areas.join(','),
                helper.areas,
                style: TextStyle(fontSize: 19, color: AppColors.greenBlue[700]),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      children: <Widget>[
        Container(
            width: 100.0,
            height: 100.0,
            child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.greenBlue[500],
                child: CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        AssetImage("assets/images/test_pic.jpg")))),
        SizedBox(width: 30.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              helper.fullname,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            // Text("Full Stack Developer"),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.map,
                  size: 15.0,
                  color: AppColors.greenBlue[700],
                ),
                SizedBox(width: 12.0),
                Text(
                  "Bengaluru",
                  style: TextStyle(color: AppColors.greenBlue[900]),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _makeBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            //_makeIntro2(size),
            _buildHeader(),
            SizedBox(height: 20),
            Divider(),
            ..._buildRatingsSection(),
            TitleWithCustomUnderline(text: "Services"),
            SizedBox(height: 10),
            _makeServicesSection(size),
            Divider(),
            SizedBox(height: 10),
            TitleWithCustomUnderline(text: "Locations"),
            SizedBox(height: 10),
            _locationsServed(size),
            // _makeAvailability(),
            _makeReviewSection()
          ],
        ));
  }

  Widget _locationsServed(size) {
    List services = helper.areas.split(',');
    return Container(
      height: 40.0 * services.length,
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i) {
            return _buildLocationRole(services[i].toUpperCase());
          }),
    );
  }

  Widget _singleLocation(String location) {
    return ListTile(title: Text(location));
  }

  //what the helper can do
  Widget _makeServicesSection(size) {
    List services = helper.services;
    return Container(
      height: 40.0 * services.length,
      child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int i) {
            return _buildLocationRole(services[i].toUpperCase());
          }),
    );
  }

  //what time of the day available
  /*Widget _makeAvailability() {
    return Container(height: 200, child: Text('Not available at all'));
  }*/

  Widget _makeReviewSection() {
    /*CarouselController controller = CarouselController();
    return Column(children: <Widget>[
      CarouselSlider.builder(
        options: CarouselOptions(height: 100),
        carouselController: controller,
        itemCount: helper.reviews.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Text(helper.reviews[i].comment));
        },
      ),
      RaisedButton(
        onPressed: () => controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear),
        child: Text('→'),
      )
    ]);*/
    List<Widget> reviews = new List<Widget>();
    if (helper.reviews == null || helper.reviews.length == 0) {
      return Column(children: []);
    }
    for (int i = 0; i < helper.reviews.length; i++) {
      reviews.add(Divider());
      reviews.add(_returnSingleReview(i));
    }
    return Column(children: reviews);
  }

  Widget _returnSingleReview(i) {
    return Column(children: [
      Row(children: <Widget>[
        Container(
            width: 50.0,
            height: 50.0,
            child: CircularProfileAvatar(
              "",
              radius: 30,
              backgroundColor: AppColors.greenBlue[800],
              initialsText: Text(
                "GC",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              elevation:
                  5.0, // sets elevation (shadow of the profile picture), default value is 0.0
              // foregroundColor: AppColors.greenBlue[500].withOpacity(0.5))),
            )),
        SizedBox(
          width: 10,
        ),
        Text("Gandu",
            style: TextStyle(fontSize: 20, color: AppColors.greenBlue[700])),
      ]),
      SizedBox(
        height: 10,
      ),
      Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Text(helper.reviews[i].comment,
              style: TextStyle(fontSize: 15, color: AppColors.greenBlue[900])))
    ]);
  }
}
