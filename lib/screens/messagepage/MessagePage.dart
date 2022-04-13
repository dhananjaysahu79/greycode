import 'package:flutter/material.dart';
import 'package:greycode/screens/chatscreen/chatscreen.dart';
import 'package:greycode/screens/messagepage/methods.dart';
import 'package:greycode/utils/utilities.dart';
import '../../methods/createUser.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessagePage extends StatefulWidget {
  final userCreds;
  const MessagePage(this.userCreds, { Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade100,
            height: 100,
            child: Row(
              children: [
                Expanded(child: buildFriendsSlider()),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  "Recent Chats",
                  style: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

   AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Chats',
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildFriendsSlider() {
    return FutureBuilder(
      future: getFriendList(widget.userCreds[0].uid),
      builder: (context, AsyncSnapshot  snapshot) {
        if (snapshot.hasError)
          return Text("Something went wrong");
        if (snapshot.data?.length == 0) return Text("Your Friends list will be shown here");
        switch (snapshot.connectionState){
          case ConnectionState.waiting: return showCircularProgress();
        default:
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async{
                  List res = await createChannel(context,widget.userCreds[0].uid, snapshot.data[index].uid);
                  if(res[0]){
                    showSnackBar("Channel Created: $res[1]", context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            channel: res[1],
                            receiverName: snapshot.data[index].fullName,
                            imageUrl: snapshot.data[index].photoUrl

                          ),
                        ),
                      );
                  }
                  else showSnackBar("Error in createChannel: $res[1]", context);
                },
                child: buildImageAvatar(
                  imageUrl: snapshot.data[index].photoUrl,
                ),
              ),
            );
          },
        );
      }}
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
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
        Container(
          height: 45,
          width: 45,
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
}