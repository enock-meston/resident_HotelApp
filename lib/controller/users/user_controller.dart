import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../model/users/user_model.dart';

class UserController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs; // List to store users

  final String baseUrlSelect = Api.SelectUser;

  // Method to fetch all users
  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrlSelect)); // Replace with your endpoint
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body); // Decode the response body
        List<dynamic> userData = jsonData['data']; // Access the 'data' key

        // Map the user data to UserModel
        users.value = userData.map((json) => UserModel.fromJson(json)).toList();
      } else {
        print("user data ${response.body}");
        Get.snackbar("Error", "Failed to fetch users", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to fetch users: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Function to clear user data and logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear SharedPreferences
    // Navigate to the login screen or any other appropriate screen
    Get.offAll(LoginScreen()); // Assuming '/login' is your login route
  }

  // Function to show a confirmation dialog
  void showLogoutConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () {
        logout(); // Call the logout function if confirmed
      },
      onCancel: () {
        Navigator.pop(context); // Close dialog on cancel
      },
    );
  }
}
