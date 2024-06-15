import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'SearchGiphyApi.g.dart';

@RestApi(baseUrl: "https://api.giphy.com/v1/gifs")
abstract class SearchGiphyApi {
  factory SearchGiphyApi(Dio dio) = _SearchGiphyApi;

  @GET("/trending")
  Future<HttpResponse> getTrendingGiphy(
      @Query("offset") int offset,
      @Query("api_key") String apiKey,
  @Query("limit") int limit ,


  );

  @GET("/search")
  Future<HttpResponse> searchGiphy(
      @Query("q") String query,
      @Query("offset") int offset,
      @Query("api_key") String apiKey,
  @Query("limit") int limit ,
  );
}
