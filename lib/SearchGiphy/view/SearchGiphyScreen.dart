import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:giphyapp/SearchGiphy/viewmodel/SearchGiphyViewModel.dart';
import 'package:giphyapp/utils/AppConstants.dart';

import '../../Authentication/Login/view/LoginScreen.dart';
import '../../Favourites/view/FavouritesScreen.dart';

final SearchGiphyViewModel giphyController = Get.put(SearchGiphyViewModel());

class SearchGiphyScreen extends StatelessWidget {
  const SearchGiphyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    giphyController.callTrendingGiphyApi();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          AppConstants.title,
          style: GoogleFonts.poppins(color: Colors.blue.shade100),
        ),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => FavoritesScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                // Background color according to theme
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Text(
                      'Favorites',
                      style: GoogleFonts.poppins(
                        color: Colors.blueGrey[200],
                        // Text color according to theme
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red, // Heart icon color
                      size: 20,
                    ),
                    onPressed: () {
                      Get.to(() => FavoritesScreen());
                    },
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(), // Remove constraints to make it small
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              giphyController.giphyData.value = [];

              Get.offAll(() => LoginScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade900,
                // Background color according to theme
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.blue, // Heart icon color
                  size: 20,
                ),
                onPressed: () {
                  giphyController.giphyData.value = [];

                  Get.offAll(() => LoginScreen());
                },
                padding: EdgeInsets.zero,
                constraints:
                    BoxConstraints(), // Remove constraints to make it small
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.blueAccent,
              style: GoogleFonts.poppins(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search the giphy",
                hintStyle: GoogleFonts.poppins(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.blueAccent,
                  ),
                ),
                filled: true,
                fillColor: Colors.blueGrey[700],
              ),
              onChanged: (query) {
                log(query);
                if (query.isNotEmpty) {
                  giphyController.callSearchGiphyApi(query);
                } else {
                  log('EMPTY NOW');
                  giphyController.giphyData.value = [];
                  giphyController.callTrendingGiphyApi();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
                if (giphyController.isLoading.value &&
                    giphyController.giphyData.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (giphyController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      giphyController.errorMessage.value,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  );
                }

                if (giphyController.giphyData.isEmpty) {
                  return Center(
                    child: Text(
                      'No GIFs found',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  );
                }

                if (giphyController.isLoading.value && giphyController.giphyData.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!giphyController.isLoading.value &&
                          giphyController.hasMore.value &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        giphyController.loadMoreGifs();
                      }
                      return false;
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: giphyController.giphyData.length,
                      itemBuilder: (context, index) {
                        final gif = giphyController.giphyData[index];
                        final gifKey = gif['id'];
                        return Card(
                          color: Colors.blueGrey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  gif['images']['fixed_height']['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Obx(() {
                                    return IconButton(
                                      icon: Icon(
                                        giphyController.checkFavourite(gifKey)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: giphyController
                                                .checkFavourite(gifKey)
                                            ? Colors.red
                                            : Colors.grey,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        giphyController.addFavourite(gifKey);
                                        EasyLoading.showSuccess(
                                            'Giphy Added to Favourites!');
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints:
                                          BoxConstraints(), // Remove constraints to make it small
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
