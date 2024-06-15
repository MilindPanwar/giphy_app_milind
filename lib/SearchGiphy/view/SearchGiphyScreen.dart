import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giphyapp/SearchGiphy/viewmodel/SearchGiphyViewModel.dart';
import 'package:giphyapp/utils/AppConstants.dart';

class SearchGiphyScreen extends StatelessWidget {
  const SearchGiphyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchGiphyViewModel controller = Get.put(SearchGiphyViewModel());
    controller.callTrendingGiphyApi();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search the giphy",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (query) {
                log(query);
                if (query.isNotEmpty) {
                  // controller.giphyData.value=[];

                  controller.callSearchGiphyApi(query);
                }else{
                  log('EMPTY NOW');
                  controller.giphyData.value=[];
                  controller.callTrendingGiphyApi();
                }
              },
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.giphyData.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                if (controller.giphyData.isEmpty) {
                  return const Center(child: Text('No GIFs found'));
                }

                return ListView.builder(
                  itemCount: controller.giphyData.length,
                  itemBuilder: (context, index) {
                    final gif = controller.giphyData[index];
                    return ListTile(
                      leading: Image.network(gif['images']['fixed_height']['url']),
                      title: Text(gif['title'] ?? 'No Title'),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
