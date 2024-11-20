import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/model/clients/client_model.dart';
import 'dart:convert';

class ClientController extends GetxController {
  final RxList<ClientModel> clients = <ClientModel>[].obs; // List to store users

  final String baseUrlSelect = Api.viewClient;

  // Method to fetch all users
  Future<void> fetchClients() async {
    try {
      final response = await http.get(Uri.parse(baseUrlSelect)); // Replace with your endpoint
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body); // Decode the response body
        // print(jsonData);
        List<dynamic> clientData = jsonData['data']; // Access the 'data' key

        // Map the client data to ClientModel
        clients.value = clientData.map((json) => ClientModel.fromJson(json)).toList();
      } else {
        print("client data ${response.body}");
        Get.snackbar("Error", "Failed to fetch Clients", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);

      Get.snackbar("Error", "Failed to fetch Clients: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

}
