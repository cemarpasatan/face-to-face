
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face2face/models/user_model.dart';
import 'package:face2face/pages/HomePage.dart';
import 'package:face2face/pages/channel_screen.dart';
import 'package:face2face/pages/profile_screen.dart';
import 'package:face2face/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavbar extends StatefulWidget {
  final User firebaseUser;
  BottomNavbar(this.firebaseUser);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      MyHomePage(widget.firebaseUser),
      ChannelsScreen(widget.firebaseUser),
      ProfileScreen(widget.firebaseUser, user),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        activeColorPrimary: Colors.red[700],
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.videocam,
          // color: Colors.black,
        ),
        title: ("Channels"),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        activeColorPrimary: Colors.red[700],
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        activeColorPrimary: Colors.red[700],
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  UserModel user;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);

    AuthenticationService(FirebaseAuth.instance)
        .getUserFromDB(uid: widget.firebaseUser.uid)
        .then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      controller: _controller,

      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style14, // Choose the nav bar style with this property.
    );
  }
}
