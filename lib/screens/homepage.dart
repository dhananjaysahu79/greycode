import 'package:chatapp/screens/messagepage/MessagePage.dart';
import 'package:chatapp/screens/notificationpage/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'explorefriendspage/ExploreFriendsPage.dart';

class HomePage extends StatefulWidget {
  final userCreds;
  const HomePage(List this.userCreds, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  PageController _controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: buildPageView()
            ),
          ),
        bottomNavigationBar: buildBottomNavigationBar()
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
        MessagePage(),
        NotificationPage(),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
          _controller.jumpToPage(value);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined), 
          label: 'People'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined,),
          label: 'Messages'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), 
          label: 'Notifications'
        ),
      ],
    );
  }

  

}
