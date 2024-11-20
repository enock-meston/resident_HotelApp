import 'package:flutter/material.dart';

class ClientTransactionScreen extends StatefulWidget {
  const ClientTransactionScreen({super.key});

  @override
  State<ClientTransactionScreen> createState() => _ClientTransactionScreenState();
}

class _ClientTransactionScreenState extends State<ClientTransactionScreen> {
  // Sample transaction data
  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'TXN001',
      'amount': 100.0,
      'date': '2024-11-01',
      'status': 'Completed',
    },
    {
      'id': 'TXN002',
      'amount': 200.5,
      'date': '2024-11-02',
      'status': 'Pending',
    },
    {
      'id': 'TXN003',
      'amount': 50.0,
      'date': '2024-11-03',
      'status': 'Failed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _buildTransactionCard(transaction);
        },
      ),
    );
  }

  // Helper method to build a transaction card
  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final statusColor = _getStatusColor(transaction['status']);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction ID: ${transaction['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: \$${transaction['amount'].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${transaction['date']}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text(
                  'Status: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  transaction['status'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to determine status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Failed':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
