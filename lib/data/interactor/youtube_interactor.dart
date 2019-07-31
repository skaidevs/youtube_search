import 'package:youtube_search/data/network/youtube_data_source.dart';
import 'package:built_collection/built_collection.dart';
import 'package:youtube_search/data/model/search/search_item.dart';
import 'package:youtube_search/data/model/search/model_search.dart';

class YoutubeInteractor {
  YoutubeDataSource _youtubeDataSource;
  String _lastSearchQuery;
  String _nextPageToken;

  YoutubeInteractor(this._youtubeDataSource);

  Future<BuiltList<SearchItem>> searchVideos(String query) async {
    final searchResult = await _youtubeDataSource.searchVideos(query: query);

    _cacheValues(query: query, nextPageToken: searchResult.nextPageToken);

    if (searchResult.items.isEmpty) throw NoSearchResultException();
    return searchResult.items;
  }

  void _cacheValues({String query, String nextPageToken}) {
    _lastSearchQuery = query;
    _nextPageToken = nextPageToken;
  }

  Future<BuiltList<SearchItem>> fetchNextResultPage() async {
    if (_lastSearchQuery == null) {
      throw SearchNotInitiatedException();
    }

    if (_nextPageToken == null) {
      throw NoNextPageTokenException();
    }

    final nextSearchResult = await _youtubeDataSource.searchVideos(
      query: _lastSearchQuery,
      pageToken: _nextPageToken,
    );

    _cacheValues(
        query: _lastSearchQuery, nextPageToken: nextSearchResult.nextPageToken);

    return nextSearchResult.items;
  }
}

class NoSearchResultException implements Exception {
  final message = 'No Results';
}

class SearchNotInitiatedException implements Exception {
  final message = 'Cannot get the next result page withouth searching first.';
}

class NoNextPageTokenException implements Exception {}
