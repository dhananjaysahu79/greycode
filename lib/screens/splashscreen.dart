import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/methods/getUser.dart';
import 'package:chatapp/screens/homepage.dart';
import 'package:chatapp/screens/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  Future changeScreen() async {

    // First check user is already logged in or not
    List res = await getUserCreds();


    // If yes, navigate to homescreen else navigate it to loginpage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => res[0] == false ? LoginPage(): HomePage(res)),
    );

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
      ),

    child:Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            width:double.infinity,
            height: double.infinity,
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Images/splash_background.png"),
                fit: BoxFit.cover
            ) )
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text("Logo",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Column(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                      backgroundColor: Colors.deepPurple,
                    ),
                    SizedBox(height: 15,),
                    Text("Getting things ready..",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    ));
  }
}