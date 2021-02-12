import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:zooland/src/models/news_model.dart';
import 'package:zooland/src/providers/news_provider.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key key, @required this.newsModel, this.isAdmin}) : super(key: key);

  final NewsModel newsModel;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 300,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          elevation: 4,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/loading.gif'),
                      image: NetworkImage(
                        newsModel.imgUrl
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    left: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0)
                      ),
                      child: Padding(
                        padding:EdgeInsets.all(5.0),
                        child: Text(
                          '${newsModel.place}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff1089ff)
                          ),
                        )
                      ),
                    )
                  ),
                  isAdmin ? Positioned(
                    top: 8.0,
                    right: 6.0,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("¿Seguro que desea eliminar este evento?"),
                              content: Text('${newsModel.headline}'),
                              actions: [
                                FlatButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text('Cancelar')
                                ),
                                FlatButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Sí, seguro')
                                ),
                              ],
                            )
                          ).then((accept) {
                            if(accept == true) 
                              NewsProvider.instance.removeNews(newsModel.uid);
                          });
                        }
                      ),
                    )
                  ):Container(width: 0.0, height: 0.0),
                  isAdmin ? Positioned(
                    top: 56.0,
                    right: 6.0,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed:() {
                          Navigator.of(context).pushNamed('/edit-news', arguments: newsModel);
                        }
                      ),
                    )
                  ):Container(width: 0.0, height: 0.0)
                ],
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      '${newsModel.headline}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(top:10,left:0.0),
                child: Container(
                  width: 330,
                  child: Text(
                    '${newsModel.headline}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    StreamBuilder<Object>(
                      stream: NewsProvider.instance.subscribeLike(newsModel.uid),
                      builder: (context, snapshot) {
                        return FutureBuilder(
                          future: NewsProvider.instance.fetchLike(newsModel.uid),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return IconButton(
                                icon: Icon(
                                  snapshot.data == null ? Icons.favorite_border : Icons.favorite
                                  , size: 30.0,
                                ), 
                                onPressed: () {
                                  NewsProvider.instance.addOrRemoveLike(newsModel.uid);
                                }
                              );
                            }
                            return IconButton(
                              icon: Icon(Icons.favorite_border, size: 30.0,), 
                              onPressed: () {
                                NewsProvider.instance.addOrRemoveLike(newsModel.uid);
                              }
                            );
                          }
                        );
                      }
                    ),
                    StreamBuilder<Object>(
                      stream: NewsProvider.instance.subscribeAttendance(newsModel.uid),
                      builder: (context, snapshot) {
                        return FutureBuilder(
                          future: NewsProvider.instance.fetchAttendance(newsModel.uid),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return IconButton(
                                icon: Icon(
                                  snapshot.data == null ? Icons.assignment_outlined : Icons.assignment
                                  , size: 30.0,
                                ), 
                                onPressed: () {
                                  NewsProvider.instance.addOrRemoveAttendances(newsModel.uid);
                                }
                              );
                            }
                            return IconButton(
                              icon: Icon(Icons.assignment_outlined, size: 30.0,), 
                              onPressed: () {
                                NewsProvider.instance.addOrRemoveAttendances(newsModel.uid);
                              }
                            );
                          }
                        );
                      }
                    ),
                    Text("${newsModel.date}",
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
