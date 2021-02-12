import 'dart:async';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:zooland/src/resources/auth.dart';
import 'package:zooland/src/models/message_model.dart';
import 'package:zooland/src/providers/chat_provider.dart';
import 'package:zooland/src/widgets/activity_indicator.dart';
import 'package:zooland/src/widgets/error_indicator.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController _textController;
  ScrollController _scrollControler;
  List _messages;

  @override
  void initState() {
    super.initState();
    _textController  = TextEditingController();
    _scrollControler = ScrollController();
    _messages = List();
  }

  @override
  void dispose() {
    _scrollControler.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map chat = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                chat['pictureUrl']
              )
            ),
            SizedBox(width: 5.0),
            Text(chat['title']),
          ],
        ),
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          _showMessages(chat['id']),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(24),
                color: Color.fromRGBO(230, 230, 230, 1)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Escribir un mensaje'
                      )
                    )
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if(_textController.text != '' && _textController.text != null) {
                        ChatProvider.instance.sendMessage(chat['id'], _textController.text);
                        _textController.text = '';
                      }
                    },
                    enableFeedback: true,
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  _showMessages(id) {
    return StreamBuilder<Object>(
      stream: ChatProvider.instance.subscribeChatLastMessage(id),
      builder: (context, snapshot) {
        print(snapshot.data);
        return FutureBuilder(
          future: ChatProvider.instance.fetchChat(id),
          builder: (_, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                controller: _scrollControler,
                reverse: true,
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 60.0),
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return _messageTile(snapshot.data[index]);
                }
              );
            } else if(snapshot.hasError) {
              return ErrorIdicator();
            }
            return ActivityIndicator();
          }
        );
      }
    );
  }

  _messageTile(MessageModel message){
    final bool sendByMe = message.author == Auth.instance.user.uid;
    return Row(
      mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0),
              bottomLeft: sendByMe ? Radius.circular(24.0) : Radius.circular(0.0),
              bottomRight: !sendByMe ? Radius.circular(24.0) : Radius.circular(0.0)
            ),
            color: Colors.blue
          ),
          padding: EdgeInsets.all(16.0),
          
          child:  Text(
              message.value,
              style: TextStyle(
                color: Colors.white,
              ),
              
          ),
        ),
      ],
    );
    /*
    return ListTile(
      title: Text(message.value),
    );
    */
  }
}
