import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'messagepage/MessagePage.dart';
import 'notificationpage/NotificationPage.dart';

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
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
        child: Scaffold(
          body: SafeArea(child: buildPageView()),
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
        MessagePage(widget.userCreds),
        NotificationPage(widget.userCreds),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      // type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
          _controller.jumpToPage(value);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined), 
          label: 'People'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined,),
          label: 'Chats'),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), 
          label: 'Notifications'
        ),
      ],
    );
  }

  

}
