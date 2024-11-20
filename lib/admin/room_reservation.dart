import 'package:flutter/material.dart';

class RoomReservation extends StatefulWidget {
  const RoomReservation({super.key});

  @override
  State<RoomReservation> createState() => _RoomReservationState();
}

class _RoomReservationState extends State<RoomReservation> {
  final List<Map<String, String>> _reservations = [
    {
      'client': 'John Doe',
      'roomNumber': '101',
      'checkIn': '2024-10-30',
      'checkOut': '2024-11-02',
    },
    {
      'client': 'Jane Smith',
      'roomNumber': '102',
      'checkIn': '2024-11-01',
      'checkOut': '2024-11-03',
    },
    {
      'client': 'Michael Johnson',
      'roomNumber': '103',
      'checkIn': '2024-10-29',
      'checkOut': '2024-11-01',
    },
    {
      'client': 'Emily Davis',
      'roomNumber': '104',
      'checkIn': '2024-10-31',
      'checkOut': '2024-11-05',
    },
  ]; // Sample list of room reservations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Reservations'),
        backgroundColor: Colors.green,
      ),
      body: _reservations.isEmpty
          ? Center(child: Text('No reservations made yet.'))
          : ListView.builder(
              itemCount: _reservations.length,
              itemBuilder: (context, index) {
                final reservation = _reservations[index];
                return ListTile(
                  title: Text('Client: ${reservation['client']}'),
                  subtitle: Text(
                    'Room: ${reservation['roomNumber']} - '
                    'Check-In: ${reservation['checkIn']} - '
                    'Check-Out: ${reservation['checkOut']}',
                  ),
                );
              },
            ),
    );
  }
}
