import 'dart:convert';

import 'package:hacker_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

String baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    String url = baseUrl + '/topstories.json';
    final response = await client.get(url);
    final ids = json.decode(response.body);

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    String url = baseUrl + '/item/$id.json';
    final response = await client.get(url);
    final parsedJson = json.decode(response.body);
    ItemModel item = ItemModel.fromJson(parsedJson);
    return item;
  }
}
