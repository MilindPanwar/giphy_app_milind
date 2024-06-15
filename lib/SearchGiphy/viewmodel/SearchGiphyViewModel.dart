import 'package:flutter/foundation.dart';
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
  var userInput = ''.obs;

  final RxSet<String> favorites = <String>{}.obs;

  void callTrendingGiphyApi() async {
    isLoading.value=true;

    try {
      final data = await api.getTrendingGiphy(offset.value, AppConstants.giphyApiKey, 25);
      final giphyList = data.response.data['data'];
      if (giphyList is Iterable) {
        giphyData.addAll(giphyList);
      } else {
        if (kDebugMode) {
          print("Error: Expected data.response.data['data'] to be an Iterable");
        }
      }

      offset.value += 25;
      hasMore.value = data.response.data['pagination']['total_count'] > offset.value;
      isLoading.value=false;
    } catch (e) {
      isLoading.value=false;
      if (kDebugMode) {
        print(e);
      }
      errorMessage.value = e.toString();

    } finally {
    }
  }

  final RxString searchQuery = ''.obs;

  void callSearchGiphyApi(String query) async {
    if (isLoading.value) return;

    isLoading.value = true;
    searchQuery.value = query;
    offset.value = 0;
    giphyData.clear();
    hasMore.value = true;

    try {
      final data = await api.searchGiphy(query, offset.value, AppConstants.giphyApiKey, 25);
if(data.response.statusCode==200){
  final giphyList = data.response.data['data'];

  if (giphyList is Iterable) {
    giphyData.addAll(giphyList);
  } else {
    print("Error: Expected data.response.data['data'] to be an Iterable");
  }

  offset.value += 25;
  hasMore.value = data.response.data['pagination']['total_count'] > offset.value;
}else{
}

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


}