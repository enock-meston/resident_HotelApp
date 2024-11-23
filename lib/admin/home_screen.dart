import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resident_hotel_app/admin/admin_dashboard_screen.dart';
import 'package:resident_hotel_app/admin/clent_screen.dart';
import 'package:resident_hotel_app/admin/food_and_beverages_screen.dart';
import 'package:resident_hotel_app/admin/room_reservation.dart';
import 'package:resident_hotel_app/admin/room_screen.dart';
import 'package:resident_hotel_app/admin/transaction_screen.dart';
import 'package:resident_hotel_app/admin/user_screen.dart';
import 'package:resident_hotel_app/controller/users/user_controller.dart';
import 'package:resident_hotel_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _title = 'Home';
  Widget _selectedScreen = AdminDashboardScreen(); // Default screen
  String? userType;
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserRole(); // Load the user role when the screen initializes
  }

  // Method to load user role from SharedPreferences
  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.getString('userType');
      username = prefs.getString('username');
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(  // Use ListView instead of Column for scrolling support
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '${userType} - ${username}',
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                '${email}',
                style: TextStyle(fontSize: 14),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.green,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _title = 'Home';
                  _selectedScreen = AdminDashboardScreen();
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            if (userType == 'Manager')
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('User'),
                onTap: () {
                  setState(() {
                    _title = 'User';
                    _selectedScreen = UserScreen();
                  });
                  Navigator.pop(context);
                },
              ),
            if (userType == 'Manager')
              ListTile(
                leading: const Icon(Icons.room),
                title: const Text('Rooms'),
                onTap: () {
                  setState(() {
                    _title = 'Rooms';
                    _selectedScreen = RoomScreen();
                  });
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.person_2),
              title: const Text('Clients'),
              onTap: () {
                setState(() {
                  _title = 'Clients';
                  _selectedScreen = ClientScreen();
                });
                Navigator.pop(context);
              },
            ),
            if (userType == 'Manager')
              ListTile(
                leading: const Icon(Icons.fastfood),
                title: const Text('Food & Beverages'),
                onTap: () {
                  setState(() {
                    _title = 'Food & Beverages';
                    _selectedScreen = FoodAndBeveragesScreen();
                  });
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Room Reservation'),
              onTap: () {
                setState(() {
                  _title = 'Room Reservation';
                  _selectedScreen = RoomReservation();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Transactions'),
              onTap: () {
                setState(() {
                  _title = 'Transaction';
                  _selectedScreen = TransactionScreen();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _title = 'Profile';
                  _selectedScreen = ProfileScreen();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // logout
                userController.showLogoutConfirmation(context);
              },
            ),
          ],
        ),
      ),
      body: _selectedScreen, // Display the selected screen
    );
  }
}
