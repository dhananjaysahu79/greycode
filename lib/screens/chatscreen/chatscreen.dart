import 'package:flutter/material.dart';
import 'package:greycode/utils/constants.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
    { 
      Key? key,
      required this.channel,
      required this.receiverName,
      required this.imageUrl
    }) : super(key: key);
  final Channel channel;
  final String receiverName;
  final String imageUrl;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    watch();
  }

  Future watch() async{
    await widget.channel.watch();
  }
  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: widget.channel,
      child: Scaffold(
        appBar:  ChannelHeader(
          title: Text(
            widget.receiverName,
            style: boldFontStyle,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: buildImageAvatar(imageUrl: widget.imageUrl),
            )
          ],
        ),
        
        body: Column(
          children: [
            Expanded(
              child: MessageListView()
            ),
            MessageInput()
          ],
        )
      ),
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
}