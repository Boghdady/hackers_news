import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/bloc_Provider.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';
import '../models/item_model.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CommentsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(context, bloc),
    );
  }

  Widget buildBody(BuildContext context, CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }
        final futureItem = snapshot.data[itemId];
        return FutureBuilder(
            future: futureItem,
            builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text('Loading....');
              }
              return buildTitle(context, itemSnapshot.data);
            });
      },
    );
  }

  Widget buildTitle(BuildContext context, ItemModel item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
