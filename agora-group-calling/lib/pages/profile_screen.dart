import 'package:agora_video_call/models/user_model.dart';
import 'package:agora_video_call/provider/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinbox/material.dart';

class ProfileScreen extends StatefulWidget {
  final User firebaseUser;
  final UserModel userModel;
  ProfileScreen(this.firebaseUser, this.userModel);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int counter = 0;
  TextEditingController cityController = TextEditingController();
  TextEditingController magicPowerController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (profileProvider.editProfileInfos) {
            profileProvider.editProfileInfos = false;
          } else {
            profileProvider.editProfileInfos = true;
          }
        },
        child: GestureDetector(
          child: Container(
            width: 60,
            height: 60,
            child: profileProvider.editProfileInfos
                ? Icon(Icons.save)
                : Icon(Icons.edit),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red[900]),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.red[900]),
                  child: Column(children: [
                    SizedBox(
                      height: 110.0,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage: AssetImage('assets/X.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.userModel.username,
                      style: GoogleFonts.poppins(
                          color: Colors.grey[900], fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'Followers',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '12',
                          style: GoogleFonts.poppins(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Card(
                      color: Colors.grey[700],
                      margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      child: Container(
                        width: 310.0,
                        height: 290.0,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Info",
                                  style: GoogleFonts.poppins(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: Colors.blueAccent[400],
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "City",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              color: Colors.red[900]),
                                        ),
                                        profileProvider.editProfileInfos
                                            ? SizedBox(
                                                width: 120,
                                                height: 30,
                                                child: TextField(
                                                  controller: cityController,
                                                ),
                                              )
                                            : Text(
                                                cityController.text ??
                                                    "FairyTail, Magnolia",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      color: Colors.yellowAccent[400],
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Magic Power",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              color: Colors.red[900]),
                                        ),
                                        profileProvider.editProfileInfos
                                            ? SizedBox(
                                                width: 120,
                                                height: 30,
                                                child: TextField(
                                                  controller:
                                                      magicPowerController,
                                                ),
                                              )
                                            : Text(
                                                magicPowerController.text ??
                                                    "Spatial & Sword Magic, Telekinesis",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.pinkAccent[400],
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Interests",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              color: Colors.red[900]),
                                        ),
                                        profileProvider.editProfileInfos
                                            ? SizedBox(
                                                width: 120,
                                                height: 30,
                                                child: TextField(
                                                  controller:
                                                      interestController,
                                                ),
                                              )
                                            : Text(
                                                interestController.text ??
                                                    "Eating cakes",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.bowlingBall,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hobbies",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              color: Colors.red[900]),
                                        ),
                                        profileProvider.editProfileInfos
                                            ? SizedBox(
                                                width: 120,
                                                height: 30,
                                                child: TextField(
                                                  controller: hobbiesController,
                                                ),
                                              )
                                            : Text(
                                                hobbiesController.text ??
                                                    "Team Natsu",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12.0,
                                                  color: Colors.black,
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: () {
                print('clicked');
                profileProvider.editAge = false;
              },
              child: Card(
                color: Colors.grey[700],
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            FaIcon(FontAwesomeIcons.twitter),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'cememirboy',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch(
                              'https://www.instagram.com/cememirboy/')) {
                            launch('https://www.instagram.com/cememirboy/');
                          }
                        },
                        child: Container(
                          child: Column(children: [
                            FaIcon(FontAwesomeIcons.instagram),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'cememirboy',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Text(
                            'Age',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          GestureDetector(
                            child: !profileProvider.editAge
                                ? Text(
                                    '23',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.w500),
                                  )
                                : SizedBox(
                                    width: 140,
                                    height: 30,
                                    child: SpinBox(
                                      min: 10,
                                      max: 100,
                                      value: 23,
                                      onChanged: (value) => print(value),
                                      
                                    ),
                                  ),
                            onTap: () {
                              profileProvider.editAge = true;
                            },
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
