import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greycode/screens/settingspage/SettingPage.dart';
import 'package:greycode/utils/constants.dart';
import 'messagepage/MessagePage.dart';
import 'notificationpage/NotificationPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'explorefriendspage/ExploreFriendsPage.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  final userCreds;
  const HomePage(List this.userCreds, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
        child: Scaffold(
          body: SafeArea(child: buildPageView()),
        bottomNavigationBar: buildbottomNavbar()
      )
    );
  }


  PageView buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      children: [
        ExploreFriendsPage(widget.userCreds),
        MessagePage(widget.userCreds),
        NotificationPage(widget.userCreds),
        SettingsPage()
      ],
    );
  }

  // BottomNavigationBar buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     // type: BottomNavigationBarType.fixed,
  //     currentIndex: _selectedIndex,
  //     onTap: (value) {
  //       setState(() {
  //         _selectedIndex = value;
  //         _controller.jumpToPage(value);
  //       });
  //     },
  //     items: const [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.people_alt_outlined), 
  //         label: 'People'
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.message_outlined,),
  //         label: 'Chats'),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.favorite_border), 
  //         label: 'Notifications'
  //       ),
  //     ],
  //   );
  // }


  Widget buildbottomNavbar() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GNav(
          selectedIndex: _selectedIndex,
          tabBackgroundColor: matteBlack,
          activeColor: Colors.white,
          gap: 8,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onTabChange: (value){
             setState(() {
              _selectedIndex = value;
              _controller.jumpToPage(value);
            });
          },
          tabs: [
             GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
             GButton(
              icon: LineIcons.facebookMessenger,
              text: 'Messages',
            ),
             GButton(
              icon: LineIcons.heart,
              text: 'Notifications',
            ),
             GButton(
              icon: LineIcons.userFriends,
              text: 'Friends',
            ),
          ],
        ),
      ),
    );
  }
}
