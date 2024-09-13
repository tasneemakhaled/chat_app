import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message-model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'chatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final controller2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          // print(snapshot.data!['message']);
          if (snapshot.hasData) {
            List<Messagemodel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Messagemodel.fromJson(snapshot.data!.docs[i]));
            }
            // print(snapshot.data!.docs[0]['message']);
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        KLogo,
                        height: 50,
                      ),
                      Text('Chat'),
                    ],
                  ),
                ),
                body: Column(children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: controller2,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBubble1(
                                  message: messagesList[index],
                                )
                              : ChatBubble2(
                                  message: messagesList[index],
                                );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'id': email,
                        });
                        controller.clear();
                        controller2.animateTo(
                          0,
                          // controller2.position.maxScrollExtent,
                          duration: Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Icon(Icons.send),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          )),
                    ),
                  ),
                ]));
          } else {
            return Text('Loading ....');
          }
        });
  }
}
