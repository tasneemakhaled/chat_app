import 'package:chat_app/models/message-model.dart';
import 'package:flutter/material.dart';

class ChatBubble2 extends StatelessWidget {
  ChatBubble2({super.key, required this.message});
  Messagemodel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 32),
        // height: 70,
        // width: 200,
        // alignment: Alignment.centerLeft,
        child: Text(message.message),
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
      ),
    );
  }
}

class ChatBubble1 extends StatelessWidget {
  ChatBubble1({super.key, required this.message});
  Messagemodel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 32),
        // height: 70,
        // width: 200,
        // alignment: Alignment.centerLeft,
        child: Text(message.message),
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
      ),
    );
  }
}
