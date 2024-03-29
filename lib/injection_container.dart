import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:youtube_search/data/network/youtube_data_source.dart';
import 'package:youtube_search/data/interactor/youtube_interactor.dart';
import 'package:youtube_search/ui/search/search_bloc.dart';

void initKiwi() {
  kiwi.Container()
    ..registerInstance(http.Client())
    ..registerFactory((c) => YoutubeDataSource(c.resolve()))
    ..registerFactory((c) => YoutubeInteractor(c.resolve()))
    ..registerFactory((c) => SearchBloc(c.resolve()));
}
