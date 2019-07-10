import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/bloc_Provider.dart';
import 'package:hacker_news/src/blocs/stories_bloc.dart';
import 'package:hacker_news/src/models/item_model.dart';

class ListItem extends StatelessWidget {
  final int itemId;
  ListItem({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoriesBloc>(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Stream Still loading....');
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Still loading item : $itemId');
            }
            return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }
}
