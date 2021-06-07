import 'package:agora_video_call/pages/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';
  
class AuthScreenView extends StatefulWidget {
  @override
  _AuthScreenViewState createState() => _AuthScreenViewState();
}
  
class _AuthScreenViewState extends State<AuthScreenView> {
  PageController pageController;
  int pageIndex = 0;
  
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }
  
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  
  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }
  
  onTap(int pageIndex) {
    //pageController.jumpToPage(pageIndex);
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
            
          //when pageIndex == 0
          LoginPage(), 
            
          //when pageIndex == 1
          RegisterPage()
                  ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              title: Text("Log-In"),
              icon: Icon(
                Icons.login,
              )),
          BottomNavigationBarItem(
              title: Text("Register"),
              icon: Icon(
               Icons.person_add_alt,
              )),
        ],
      ),
    );
  }
}