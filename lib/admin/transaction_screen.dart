import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  // const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Map<String, dynamic>> clients = [
    {
      'name': 'John Doe',
      'transactions': [
        {'date': '2024-10-25', 'amount': '\$50.00', 'status': 'Completed'},
        {'date': '2024-10-24', 'amount': '\$30.00', 'status': 'Pending'},
      ],
    },
    {
      'name': 'Jane Smith',
      'transactions': [
        {'date': '2024-10-23', 'amount': '\$75.00', 'status': 'Completed'},
        {'date': '2024-10-22', 'amount': '\$100.00', 'status': 'Completed'},
      ],
    },
    {
      'name': 'Alice Brown',
      'transactions': [
        {'date': '2024-10-20', 'amount': '\$60.00', 'status': 'Pending'},
        {'date': '2024-10-18', 'amount': '\$40.00', 'status': 'Completed'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Transactions'),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, clientIndex) {
          final client = clients[clientIndex];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text(
                client['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: List.generate(client['transactions'].length, (transactionIndex) {
                final transaction = client['transactions'][transactionIndex];
                return ListTile(
                  leading: Icon(
                    transaction['status'] == 'Completed'
                        ? Icons.check_circle
                        : Icons.pending,
                    color: transaction['status'] == 'Completed'
                        ? Colors.green
                        : Colors.orange,
                  ),
                  title: Text('Amount: ${transaction['amount']}'),
                  subtitle: Text('Date: ${transaction['date']}'),
                  trailing: Text(
                    transaction['status']!,
                    style: TextStyle(
                      color: transaction['status'] == 'Completed'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
