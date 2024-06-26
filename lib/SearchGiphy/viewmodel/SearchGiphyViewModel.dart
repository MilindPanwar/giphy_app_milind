import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:giphyapp/SearchGiphy/data/api/SearchGiphyApi.dart';
import 'package:giphyapp/utils/AppConstants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class SearchGiphyViewModel extends GetxController {
  final api = SearchGiphyApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  var giphyData = [].obs;
  var offset = 0.obs;
  var hasMore = true.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;
  RxSet<String> listOfFavourites = RxSet<String>();
  var favouriteGiphyData = [].obs;


  void callTrendingGiphyApi() async {

    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final data = await api.getTrendingGiphy(
          offset.value, AppConstants.giphyApiKey, 50);
      final giphyList = data.response.data['data'];

      if (giphyList is Iterable) {
        giphyData.value= data.response.data['data'] ;
      } else {
        if (kDebugMode) {
          print("Error: Expected data.response.data['data'] to be an Iterable");
        }
      }

      offset.value += 25;
      hasMore.value =
          data.response.data['pagination']['total_count'] > offset.value;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void callSearchGiphyApi(String query) async {
    if (isLoading.value || searchQuery.value != query) return;

    isLoading.value = true;

    try {
      final data = await api.searchGiphy(
          query, offset.value, AppConstants.giphyApiKey, 25);
      final giphyList = data.response.data['data'];

      if (giphyList is Iterable) {
        if (searchQuery.value != query) {
          giphyData.value =  data.response.data['data'];
        } else {
          giphyData.addAll(giphyList);
        }
      } else {
        print("Error: Expected data.response.data['data'] to be an Iterable");
      }

      offset.value += 25;
      hasMore.value = data.response.data['pagination']['total_count'] > offset.value;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreGifs() {
    try {
      if (searchQuery.isEmpty) {
        callTrendingGiphyApi();
      } else {
        callSearchGiphyApi(searchQuery.value);
      }
    } finally {
      isLoading.value = false;
    }
  }
  void setSearchQuery(String query) {
    searchQuery.value = query;
    offset.value = 0;
    giphyData.clear();
    hasMore.value = true;
  }
  void addFavourite(String giphyKey, passedGif) {
    if (listOfFavourites.contains(giphyKey)) {
      favouriteGiphyData.remove(passedGif);
      listOfFavourites.remove(giphyKey);
      EasyLoading.showSuccess(
          'Giphy Removed from Favourites!');
    } else {

      listOfFavourites.add(giphyKey);
      favouriteGiphyData.add(passedGif);
      EasyLoading.showSuccess(
          'Giphy Added to Favourites!');
    }
  }

  bool checkFavourite(String giphyKey) {
    return listOfFavourites.contains(giphyKey);
  }
}
