import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/model/food_and_bevarages_model.dart';

class FoodAndBeverageController extends GetxController {


  // select food and beverage
  var foodItems = <FoodItem>[].obs; // List of FoodItem that will be observed
  var isLoading = true.obs; // To track loading state

  // URL for your API endpoint
  final String apiUrl = Api.get_food_and_beverages;

  @override
  void onInit() {
    super.onInit();
    fetchFoodItems(); // Fetch data when the controller is initialized
  }

  // Fetch data from API
  Future<void> fetchFoodItems() async {
    try {
      isLoading(true); // Set loading to true while fetching data
      final response = await http.get(Uri.parse(apiUrl));
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = json.decode(response.body);

        // Check if the response body is in the expected format
        if (jsonResponse is Map<String, dynamic>) {
          // Properly parse the JSON into the FoodAndBeveragesModel
          FoodAndBeveragesModel model = FoodAndBeveragesModel.fromJson(jsonResponse);

          // Set the list of food items
          foodItems.value = model.data;
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching food items: $e");
    } finally {
      isLoading(false); // Set loading to false after data is fetched
    }
  }

  // save food and beverage
  Future<void> saveItem({
    required String name,
    required double price,
    required String type,
    required File? imageFile,
  }) async {
    final url = Uri.parse(Api.save_food_and_beverage);

    // Prepare the request
    var request = http.MultipartRequest("POST", url);
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['type'] = type;

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final result = jsonDecode(responseData.body);

        if (result['success']) {
          Get.snackbar("Success", "Item saved successfully!",
              snackPosition: SnackPosition.BOTTOM);
          fetchFoodItems();
        } else {
          Get.snackbar("Error", result['message'] ?? "Failed to save item!",
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar("Error", "Server error occurred!",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }



}
