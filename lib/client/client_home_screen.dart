import 'package:flutter/material.dart';
import 'package:resident_hotel_app/client/client_dashboard.dart';
import 'package:resident_hotel_app/client/client_food_screen.dart';
import 'package:resident_hotel_app/client/client_profile_screen.dart';
import 'package:resident_hotel_app/client/client_room_screen.dart';
import 'package:resident_hotel_app/client/client_transaction_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ClientDashboard(),
    const ClientRoomScreen(),
    const ClientFoodScreen(),
    const ClientTransactionScreen(),
    const ClientProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text("Resident Hotel"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures consistent background color
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.green.shade700,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_service),
            label: "Rooms",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage_rounded),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Paid",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
