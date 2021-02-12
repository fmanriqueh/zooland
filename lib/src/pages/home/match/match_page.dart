import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zooland/src/models/match_model.dart';
import 'package:zooland/src/providers/chat_provider.dart';
import 'package:zooland/src/providers/match_provider.dart';
import 'package:zooland/src/resources/auth.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MatchProvider.instance.fetchMatch(),
      builder: (_, snapshot) {
        if(snapshot.hasData) {
          return _showActiveMatchs(context, snapshot.data);
        }else if(snapshot.hasError) {
          return Center(
            child: Text('Algo salió mal...')
          );
        }
        return Center(
          child: Container(
            color: Colors.transparent,
            child: CupertinoActivityIndicator(
              radius: 15
            )
          )
        );
      }
    );
  }
  
  ListView _showActiveMatchs(context, List<MatchModel> matchs) {
    return ListView.builder(
      itemCount: matchs.length,
      itemBuilder: (_, index) {
        final match = matchs[index];
        UserMatch myUserMatch;
        UserMatch userMatch;
        match.participants.forEach((participant){
          if(participant.uid != Auth.instance.user.uid){
            userMatch = participant;
          } else {
            myUserMatch = participant;
          }
        });
        return ListTile(
          contentPadding: EdgeInsets.all(10.0),
          title: Text('${userMatch.name}: ${userMatch.petName} | ${myUserMatch.petName}'),
          subtitle: StreamBuilder(
            stream: ChatProvider.instance.subscribeChatLastMessage(match.uid),
            builder: (_, snapshot) {
              if(snapshot.data == null) {
                return Text('');
              }
              Event lastMessage = snapshot.data;
              return Text(
                lastMessage.snapshot.value['value'],
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/chat', arguments: {
              'title'     : '${userMatch.name}: ${userMatch.petName} | ${myUserMatch.petName}',
              'pictureUrl': userMatch.petPicture,
              'id'        : match.uid
            });
          },
          onLongPress: () {
            
          },
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(
              userMatch.petPicture
            ),
          ),
        );
      }
    );
  }
}