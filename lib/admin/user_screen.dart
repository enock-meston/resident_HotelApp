import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/admin/more_infor_screens/user_details_screen.dart';
import 'package:resident_hotel_app/controller/users/user_controller.dart';
import 'package:resident_hotel_app/model/users/user_model.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // Fetch users when the app starts
    userController.fetchUsers();
  }
  final List<UserModel> _users = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String? userType = 'Receptionist';

        return AlertDialog(
          title: Text('Add New User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: userType,
                decoration: InputDecoration(
                  labelText: 'User Type',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                items: ['Receptionist', 'Waiter', 'Accountant']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  userType = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String email = emailController.text;
                String Utype = userType.toString();
                if (name.isEmpty || email.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Missing Information"),
                        content: Text("Please fill in all the fields."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }else{

                  addNewUser(name,email,Utype);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void addNewUser(name,email,uType) async{
    // print("========== Name: $name, Email: $email, UserType: $uType");
    final url = Uri.parse(Api.addtUser); // Replace with your actual PHP API URL
    final response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "userType": uType,
      },
    );
    if(response.statusCode == 200){
      final responseData = json.decode(response.body);
      // print(" my data from responsedata: $responseData");
      if(responseData['status'] == 'success'){
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        userController.fetchUsers();
      //   make clear of textFields methods
        clearMethod();
      }else{
        print(" data from else 01: ${response.body}");
        // Show error dialog with server's message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
    else{
// Show error dialog if server did not respond successfully
      print(" my error from else 2: ${response.body}");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to connect to the server."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void clearMethod(){
    nameController.clear();
    emailController.clear();
}
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController()); // Retrieve the UserController

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              userController.fetchUsers(); // Refresh the user list
            },
          ),
        ],
      ),
      body:  Obx(() {
        return userController.users.isEmpty
            ? Center(child: Text('No users added yet.'))
            : ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            final user = userController.users[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(user.names.isNotEmpty ? user.names[0] : 'U'), // Initial of the user name
                backgroundColor: Colors.green.shade700,
              ),
              title: Text(user.names), // User name
              subtitle: Text('${user.email} • ${user.userType}'),
              onTap: () {
                // Navigate to UserDetailScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
