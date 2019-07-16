import 'dart:async';
import 'package:hacker_news/src/api/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../blocs/bloc_Provider.dart';
import '../models/item_model.dart';

class CommentsBloc implements BlocBase {
  final _repository = Repository();
  // 1- Define stream controller
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // 2- Retrieve data from stream
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // 3- Sink data to stream
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  @override
  void dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
