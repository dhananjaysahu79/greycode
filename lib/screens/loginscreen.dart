import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatapp/methods/getUser.dart';
import 'package:chatapp/methods/handleSignIn.dart';
import 'package:chatapp/screens/homepage.dart';
import 'package:chatapp/utils/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
      ),

    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          // Background Image
          Container(
            width:double.infinity,
            height: double.infinity,
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Images/splash_background.png"),
                fit: BoxFit.cover
            ) )
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Top Login text in bold
                Container(
                  height: height/4,
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                    width:width/2.5,
                    child: Text("Login",
                     style: TextStyle(
                       fontSize: 35,
                       fontWeight: FontWeight.bold
                     ),
                    )
                    ),
                  ),
                ),
               
              
               SizedBox(height: 15),

               Expanded(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Color(0xFF7B51D3))
                       ),
                       onPressed: _confirmSIgnIn, 
                       child: Container(
                         width: width/1.4,
                         child: Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Continue with google",style: TextStyle(
                                  letterSpacing: 1,fontSize: 19, color: Colors.white,fontWeight: FontWeight.bold),
                                ),
                                 Container(
                                   height: 38,
                                   width: 38,
                                   decoration:BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(20),
                                     image: DecorationImage(
                                       image: AssetImage("assets/Images/google.png"),
                                       fit: BoxFit.cover
                                   ) )
                                 ),
                             ],
                           ),
                         ),
                       ),
                       ),


                       SizedBox(height: 25),
                        Container(
                          alignment: Alignment.center,
                          width: width/1.5,
                          child: Column(
                            children: [
                              Text("By signing into chatapp, you agree to the",style: TextStyle(color: Colors.black54,fontSize: 14),),
                              SizedBox(height: 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Terms of Service ",style: TextStyle(color: Color(0xFF7B51D3),fontSize: 14,fontWeight: FontWeight.bold),),
                                  Text(" and  ",style: TextStyle(color: Colors.black54,fontSize: 14),),
                                  Text("Privacy Policy",style: TextStyle(color: Color(0xFF7B51D3),fontSize: 14,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ],
                          ),

                        ),

                   ],
                 ),
               ),

                 

              ],
            ),
          ),
        ],
      )
     )
    );
  }

  

  Future<void> _confirmSIgnIn() async {

    var isLogged = await signInWithGoogle();
    List res = await getUserCreds();

    if (isLogged && res[0] != false){
      showSnackBar("Logged in Successfully", context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(res)),
      );
    }
    
    else
    showSnackBar("Login Failed! Please try after sometime", context);
  }
}