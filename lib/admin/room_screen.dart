import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:resident_hotel_app/controller/rooms/room_controller.dart';

import '../model/rooms/room_model.dart';



class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final RoomController roomController = Get.put(RoomController()); // Retrieve the UserController

  @override
  void initState() {
    super.initState();
    roomController.fetchRooms();
  }
  final List<RoomModel> _rooms = []; // Sample list of room data
  void addRoomMethod(String roomNum, String roomTy, String roomprice) async {

    final url = Uri.parse(Api.addRoom); // Replace with your actual PHP API URL
    final response = await http.post(
      url,
      body: {
        "room_number": roomNum,
        "roomType": roomTy,
        "price": roomprice,
      },
    );
    // check response if is 200
    if (response.statusCode == 200) {
      var resData = json.decode(response.body);
      if (resData['status'] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${resData['message']}')),
        );
        roomController.fetchRooms();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${resData['message']}')),
        );
      }

    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error message"),
            content: Text('${json.decode(response.body)}'),
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

  void _showAddRoomDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController roomNumberController = TextEditingController();
        String? roomType = 'Single';
        final TextEditingController roomPriceController = TextEditingController();

        return AlertDialog(
          title: Text('Add New Room'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roomNumberController,
                decoration: InputDecoration(
                  labelText: 'Room Number',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: roomType,
                decoration: InputDecoration(
                  labelText: 'Room Type',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                items: ['Single', 'Double', 'Suite']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  roomType = value;
                },
              ),
              SizedBox(height: 8),
              TextField(
                controller: roomPriceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
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
                String roomNum = roomNumberController.text;
                String roomTy = roomType.toString();
                String roomprice = roomPriceController.text;

              if(roomNum.isEmpty || roomprice.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All fields are required')),
                );
                }else{
                // add room methods
                addRoomMethod(roomNum,roomTy,roomprice);
                Navigator.of(context).pop(); // Close dialog after saving

              }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final RoomController roomController = Get.put(RoomController()); // Retrieve the UserController

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              roomController.fetchRooms(); // Refresh the user list
            },
          ),
        ],
      ),
      body: Obx(() {
        return roomController.rooms.isEmpty
            ? Center(child: Text('No rooms added yet.'))
            : ListView.builder(
          itemCount: roomController.rooms.length,
          itemBuilder: (context, index) {
            final room = roomController.rooms[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(room.roomNumber.isNotEmpty ? room.roomNumber[0] : 'U'), // Initial of the user name
                backgroundColor: Colors.green.shade700,
              ),
              title: Text(room.roomNumber), // User name
              subtitle: Text('${room.roomType} • ${room.price} Rwf • ${room.status}'),
              onTap: () {
                // Navigate to UserDetailScreen
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => RoomDetailScreen(room: room),
                //   ),
                // );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoomDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

