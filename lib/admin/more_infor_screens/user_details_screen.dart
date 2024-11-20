import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/controller/users/user_controller.dart';
import '../../model/users/user_model.dart'; // Adjust the import as needed
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;

  UserDetailScreen({required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // Fetch users when the app starts
    userController.fetchUsers();
  }
  // Function to permanently delete the user
  void _deleteUser(BuildContext context) async {
    Navigator.pop(context);
    // delete from http
    var url = Uri.parse("${Api.deleteUser}?user_id=${widget.user.userId}");
    print(url);
    final response = await http.delete(url); // Use DELETE method
    if (response.statusCode == 200) {
      // Decode the JSON response from the server
      var responseData = json.decode(response.body);
      var message = responseData['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.user.names} ${message}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete ${widget.user.names}.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.names),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade700,
              child: Text(
                widget.user.names.isNotEmpty ? widget.user.names[0] : 'U',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Text('Name: ${widget.user.names}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Email: ${widget.user.email}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Username: ${widget.user.username}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('User Type: ${widget.user.userType}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Status: ${widget.user.status}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 8), // Add some space between the buttons
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _deleteUser(context),
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Optional color
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
