import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resident_hotel_app/controller/clients/client_controller.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

  @override
  Widget build(BuildContext context) {
    final ClientController clientController = Get.put(ClientController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              clientController.fetchClients();
            },
          ),
        ],
      ),
      body: Obx(() {
        return clientController.clients.isEmpty
            ? Center(child: Text('No rooms added yet.'))
            : ListView.builder(
          itemCount: clientController.clients.length,
          itemBuilder: (context, index) {
            final client = clientController.clients[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(client.names.isNotEmpty ? client.names[0] : 'U'), // Initial of the user name
                backgroundColor: Colors.green.shade700,
              ),
              title: Text(client.names), // User name
              subtitle: Text('${client.email} • ${client.status}'),
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
    );
  }
}
