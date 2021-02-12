import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zooland/src/models/message_model.dart';

class ChatProvider {

  ChatProvider._internal();
  static final ChatProvider instance = ChatProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<Event> subscribeChatLastMessage(id) {
    return _database.reference()
      .child('chats')
      .child(id)
      .onChildAdded;
  }

  Stream<Event> subscribeChat(id) {
    return _database.reference()
      .child('chats')
      .child(id)
      .onChildAdded
      .asBroadcastStream();
  }

  Future<void> fetchChat(id) async {
    final chatRef =  _database.reference()
      .child('chats')
      .child(id)
      .orderByChild('timestamp');
      //.limitToLast(15);

    return await chatRef.once().then((snapshot) {
      if(snapshot.value == null) {
        return List();
      }
      return MessageList().fromJson(snapshot.value);
    });
  }

  Future<void> sendMessage(id, value) {
    final chatRef = _database.reference()
      .child('chats')
      .child(id)
      .push();

    final message = MessageModel(
      author: _auth.currentUser.uid,
      value: value,
      timestamp: ServerValue.timestamp
    );

    return chatRef.set(message.toJson());
  }
}