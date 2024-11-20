import 'package:flutter/material.dart';
import 'package:resident_hotel_app/controller/users/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? phone;
  String? UserStatus;

  @override
  void initState() {
    super.initState();
    _loadUserRole(); // Load the user role when the screen initializes
  }

  // Method to load user role from SharedPreferences
  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('names');
      phone = prefs.getString('phone');
      email = prefs.getString('email');
      UserStatus = prefs.getString('clientStatus');
    });
  }


  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: const NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Implement image picker
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Name
              Text(
                'Name:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                name ?? 'No name available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Email
              Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                email ?? 'No email available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Phone
              Text(
                'Phone:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                phone ?? 'No phone number available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Status
              Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                UserStatus ?? 'No status available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Save Button (optional: can remove since fields are non-editable)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black12,
                ),
                onPressed: () {
                  userController.showLogoutConfirmation(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
