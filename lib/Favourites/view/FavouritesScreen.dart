import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../SearchGiphy/view/SearchGiphyScreen.dart';
import '../../SearchGiphy/viewmodel/SearchGiphyViewModel.dart'; // Import your view model

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final SearchGiphyViewModel giphyController =
        Get.find(); // Retrieve the controller

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          'Favorite GIFs',
          style: GoogleFonts.poppins(color: Colors.blue.shade100),
        ),

        backgroundColor: Colors.blueGrey[800],
        // Use primary color from theme
      ),
      body: Obx(() {
        // Retrieve only unique favorite GIFs based on ID
        final List<dynamic> uniqueFavoriteGifs = giphyController.giphyData
            .where((gif) => giphyController.checkFavourite(gif['id']))
            .toList();

        if (uniqueFavoriteGifs.isEmpty) {
          return Center(
            child: Text(
              'No favorite GIFs yet!',
              style: GoogleFonts.poppins(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: uniqueFavoriteGifs.length,
            itemBuilder: (context, index) {
              final gif = uniqueFavoriteGifs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color:
                      Theme.of(context).cardColor, // Use card color from theme
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    leading: CachedNetworkImage(
                      imageUrl: gif['images']['fixed_height']['url'],
                      width: 50,
                      height: 50,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(
                      gif['title'] ?? 'Untitled',
                      style: GoogleFonts.poppins(),
                    ),
                    // Add more details or actions if needed
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}