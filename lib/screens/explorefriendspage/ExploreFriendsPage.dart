import 'package:chatapp/methods/getUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/utilities.dart';
import '../loginscreen.dart';

class ExploreFriendsPage extends StatefulWidget {
  final userCreds;
  const ExploreFriendsPage(List this.userCreds, {Key? key}) : super(key: key);

  @override
  State<ExploreFriendsPage> createState() => _ExploreFriendsPageState();
}

class _ExploreFriendsPageState extends State<ExploreFriendsPage> {
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Explore Friends", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height:20),
          meetNewPeople(),
        ],
      )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: buildWelcomeBackUser(),
      ),
    );
  }


  Row buildWelcomeBackUser(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            buildImageAvatar(imageUrl: widget.userCreds[0].photoUrl),
            SizedBox(
              width: 10,
            ),
            buildWelcomeBackText(name: widget.userCreds[0].fullName,),
          ],
        ),
        IconButton(
          onPressed: () async {
            if (await logOutUser())
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            else
              showSnackBar("something went wrong at our end.", context);
          },
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ))
      ],
    );
  }

  Stack buildImageAvatar(
    {
      required String imageUrl
    }){
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(
                imageUrl
              )
          )),
        ),
      ],
    );
  }

 Column buildWelcomeBackText(
   {required String name}
   ){
   return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back!",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w700),
        ),
        Text(
          widget.userCreds[0].fullName,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
              fontWeight: FontWeight.w900),
        ),
      ],
    );
 }

 Expanded meetNewPeople(){
   return Expanded(
     child: StreamBuilder<QuerySnapshot>(
       stream: FirebaseFirestore.instance.collection("users").snapshots(),
       builder: (context, AsyncSnapshot <QuerySnapshot>snapshot) {
          if (snapshot.hasError)
            return Text("Something went wrong");
          switch (snapshot.connectionState){
            case ConnectionState.waiting: return showCircularProgress();
          default:
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.only(bottom: 20),
            itemBuilder: ((context, index) {
              return ListTile(
                leading: buildImageAvatar(
                   imageUrl: snapshot.data!.docs[index]["imageUrl"],
                ),
                title: Text(
                  snapshot.data!.docs[index]["Name"],
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.w900),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add, color: Colors.black,), 
                  onPressed: () {  },  
                ),
              );
            })
          );
        }
       }
     ),
   );
 }

}
