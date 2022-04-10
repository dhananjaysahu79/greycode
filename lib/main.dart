import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/screens/loginscreen.dart';
import 'package:chatapp/screens/splashscreen.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "chatapp",
      debugShowCheckedModeBanner:false,

      // default theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'GoogleSans',
        canvasColor: Colors.white,
        primaryIconTheme: IconThemeData(color: Colors.black),

        // page transition slide animation
        pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),

      // Splashscreen will decide which screen to show
      home: SplashScreen(),
      // home: MyHomePage(title: "chatapp"),
     
    );
  }
}


// Step 1: Open SplashScreen
// Step 2: SplashScreen will decide which screen to show
// How will splashscreen decide which screen to show? {
//   1. Check if user has credentials stored in shared preferences
//      if yes then show home page.
//   2. Else show login screen.
// }
// Step 3: Open LoginScreen
// {
//   1. Check userId is present at firestore database
//   2. Store its credentials in shared preferences.
//   3. If yes show homepage.
//   4. If No, store userId with default data in firestore database and store
//   its creds in shared preferences. then show homepage.
// }



