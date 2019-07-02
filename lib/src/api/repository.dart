import 'dart:async';

import 'package:hacker_news/src/api/news_api_provider.dart';
import 'package:hacker_news/src/api/news_db_provider.dart';
import 'package:hacker_news/src/models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() async {
    return await apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    // 1 - search about item in db
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    // 2 - not found item in db then get it from api and save it in db
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }
}
