import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/news_details.dart';
import 'package:hacker_news/src/screens/news_list.dart';

import 'blocs/bloc_Provider.dart';
import 'blocs/stories_bloc.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(
      bloc: StoriesBloc(),
      child: MaterialApp(
        title: 'HackersNews',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (BuildContext context) {
        final int itemId = settings.arguments;
        return NewsDetails(
          itemId: itemId,
        );
      });
    }
  }
}
