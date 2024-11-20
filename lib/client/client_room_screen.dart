import 'package:flutter/material.dart';
import 'package:resident_hotel_app/controller/rooms/room_controller.dart';
import 'package:get/get.dart';

class ClientRoomScreen extends StatefulWidget {
  const ClientRoomScreen({super.key});

  @override
  State<ClientRoomScreen> createState() => _ClientRoomScreenState();
}

class _ClientRoomScreenState extends State<ClientRoomScreen> {
  // Sample room data
  final List<Map<String, dynamic>> rooms = [
    {
      'title': 'Deluxe Room',
      'price': 120,
      'image': 'https://via.placeholder.com/150',
      'status': 'Available',
    },
    {
      'title': 'Suite Room',
      'price': 250,
      'image': 'https://via.placeholder.com/150',
      'status': 'Booked',
    },
    {
      'title': 'Standard Room',
      'price': 90,
      'image': 'https://via.placeholder.com/150',
      'status': 'Available',
    },
    {
      'title': 'Family Room',
      'price': 200,
      'image': 'https://via.placeholder.com/150',
      'status': 'Available',
    },
  ];
  final RoomController roomController = Get.put(RoomController()); // Retrieve the UserController

  @override
  void initState() {
    super.initState();
    roomController.fetchRooms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            final room = rooms[index];
            return _buildRoomCard(
              title: room['title'],
              price: room['price'],
              imageUrl: room['image'],
              status: room['status'],
            );
          },
        ),
      ),
    );
  }

  // Helper: Build a Room Card
  Widget _buildRoomCard({
    required String title,
    required int price,
    required String imageUrl,
    required String status,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Price: \$${price.toString()} per night'),
            Text(
              'Status: $status',
              style: TextStyle(
                color: status == 'Available' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: status == 'Available'
            ? ElevatedButton(
          onPressed: () {
            // Handle room booking action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Booking $title...'),
              ),
            );
          },
          child: const Text('Book Now'),
        )
            : const Text(
          'Booked',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
