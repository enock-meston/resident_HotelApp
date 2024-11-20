import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/admin/admin_dashboard_screen.dart';
import 'package:resident_hotel_app/admin/home_screen.dart';
import 'package:resident_hotel_app/client/client_home_screen.dart';
import 'package:resident_hotel_app/screen/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userType = 'User';

  void userLoginMethod(String email, String password) async {
    // shared Preferences data
    SharedPreferences shared = await SharedPreferences.getInstance();

    var url = Uri.parse(Api.user_login);
    // Show loading dialog
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    // print('link ${url}');

    try {
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      var data = json.decode(response.body);

      // Check the status code and handle the response
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String user_id = data['user_id'] ?? ''; // Assign default value if null
        String names = data['names'] ?? '';
        String email = data['email'] ?? '';
        String username = data['username'] ?? '';
        String userType = data['userType'] ?? '';
        // print all data here
        print("========================${data}========================");
        print(user_id);
        print(names);
        print(email);
        print(username);
        print(userType);
        print("================================================");

        // print('data ${data['status']}');

        if (data['status'] == 'success') {
          shared.setString("user_id", user_id);
          shared.setString("names", names);
          shared.setString("email", email);
          shared.setString("username", username);
          shared.setString("userType", userType);

          // loading progress bar
          // Close the loading dialog
          Get.back();
          Get.offAll(HomeScreen());

          print("Login successful! ${data}");
        } else {
          Get.back();
          Get.snackbar(
            "Login Failed",
            data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
          // print("Login failed: ${data['message']}");
          // print("data! ${data}");
        }
      } else {
        Get.back();
        Get.snackbar(
          "Error",
          "Server error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        print("data in else! ${data}");
      }
    } catch (e) {
      // Close loading dialog
      Get.back();

      // Check if the error message contains "Network is unreachable"
      if (e.toString().contains("Network is unreachable")) {
        Get.snackbar(
          "Error",
          "Network is unreachable. Please check your connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        // Handle other exceptions
        Get.snackbar(
          "Error",
          "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }

      print("An error occurred: $e");
    }
  }

  void clientLoginMethod(String email, String password) async {
    var url = Uri.parse(Api.client_login);
    // shared Preferences data
    SharedPreferences shared = await SharedPreferences.getInstance();
    // Show loading dialog
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    // print('link ${url}');

    try {
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });

      var data = json.decode(response.body);

      // Check the status code and handle the response
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String client_id = data['client_id'] ?? ''; // Assign default value if null
        String names = data['names'] ?? '';
        String email = data['email'] ?? '';
        String phoneNumber = data['phoneNumber'] ?? '';
        String client_status = data['client_status'] ?? '';
        // print all data here
        print("========================${data}========================");
        print(client_id);
        print(names);
        print(email);
        print(phoneNumber);
        print(client_status);
        print("================================================");

        // print('data ${data['status']}');

        if (data['status'] == 'success') {
          shared.setString("clientId", client_id);
          shared.setString("names", names);
          shared.setString("email", email);
          shared.setString("phone", phoneNumber);
          shared.setString("clientStatus", client_status);

          // loading progress bar
          // Close the loading dialog
          Get.back();
          Get.offAll(ClientHomeScreen());

          print("Login successful! ${data}");
        } else {
          Get.back();
          Get.snackbar(
            "Login Failed",
            data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
          );
          // print("Login failed: ${data['message']}");
          // print("data! ${data}");
        }
      } else {
        Get.back();
        Get.snackbar(
          "Error",
          "Server error: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        print("data in else! ${data}");
      }
    } catch (e) {
      // Close loading dialog
      Get.back();

      // Check if the error message contains "Network is unreachable"
      if (e.toString().contains("Network is unreachable")) {
        Get.snackbar(
          "Error",
          "Network is unreachable. Please check your connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      } else {
        // Handle other exceptions
        Get.snackbar(
          "Error",
          "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }

      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text("Resident Hotel"),
        centerTitle: true,
        backgroundColor: Colors.green.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: _userType,
                    decoration: InputDecoration(
                      labelText: 'User Type',
                      labelStyle: TextStyle(color: Colors.green.shade900),
                      filled: true,
                      fillColor: Colors.green.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    dropdownColor: Colors.green.shade100,
                    items: ['User', 'Client']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email / Phone number/ username',
                      filled: true,
                      fillColor: Colors.green.shade100,
                      labelStyle: TextStyle(color: Colors.green.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email/ Phone number/username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.green.shade100,
                      labelStyle: TextStyle(color: Colors.green.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  if (_userType == 'User') ...[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          userLoginMethod(email, password);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                  if (_userType == 'Client') ...[
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          clientLoginMethod(email, password);
                          // Get.to(ClientHomeScreen());
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(SignupScreen());
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
