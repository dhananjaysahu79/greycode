import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({ Key? key,required this.channel}) : super(key: key);
  final Channel channel;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: widget.channel,
      child: Scaffold(
        appBar: const ChannelHeader(),
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
}