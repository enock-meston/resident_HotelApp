import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resident_hotel_app/APIs/api.dart';
import 'dart:convert';

import '../../model/rooms/room_model.dart';
import '../../model/users/user_model.dart';

class RoomController extends GetxController {
  final RxList<RoomModel> rooms = <RoomModel>[].obs; // List to store users

  final String baseUrlSelect = Api.viewRoom;

  // Method to fetch all users
  Future<void> fetchRooms() async {
    try {
      final response = await http.get(Uri.parse(baseUrlSelect)); // Replace with your endpoint
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body); // Decode the response body
        // print(jsonData);
        List<dynamic> roomData = jsonData['data']; // Access the 'data' key

        // Map the room data to RoomModel
        rooms.value = roomData.map((json) => RoomModel.fromJson(json)).toList();
      } else {
        // print("room data ${response.body}");
        Get.snackbar("Error", "Failed to fetch rooms", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to fetch rooms: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

}
