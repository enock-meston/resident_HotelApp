import 'package:flutter/material.dart';

class ClientFoodScreen extends StatefulWidget {
  const ClientFoodScreen({super.key});

  @override
  State<ClientFoodScreen> createState() => _ClientFoodScreenState();
}

class _ClientFoodScreenState extends State<ClientFoodScreen> {
  // Sample food and beverage data
  final List<Map<String, dynamic>> foodAndBeverages = [
    {
      'category': 'Food',
      'items': [
        {
          'name': 'Pizza',
          'price': 8.99,
          'image': 'https://via.placeholder.com/150',
          'status': 'Available',
        },
        {
          'name': 'Burger',
          'price': 5.49,
          'image': 'https://via.placeholder.com/150',
          'status': 'Out of Stock',
        },
      ],
    },
    {
      'category': 'Beverage',
      'items': [
        {
          'name': 'Coke',
          'price': 1.99,
          'image': 'https://via.placeholder.com/150',
          'status': 'Available',
        },
        {
          'name': 'Coffee',
          'price': 2.49,
          'image': 'https://via.placeholder.com/150',
          'status': 'Available',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food and Beverages'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foodAndBeverages.length,
            itemBuilder: (context, index) {
              final category = foodAndBeverages[index];
              return _buildCategorySection(category['category'], category['items']);
            },
          ),
        ),
      ),
    );
  }

  // Helper: Build a category section
  Widget _buildCategorySection(String category, List items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildFoodBeverageCard(
                name: item['name'],
                price: item['price'],
                imageUrl: item['image'],
                status: item['status'],
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper: Build a food/beverage card
  Widget _buildFoodBeverageCard({
    required String name,
    required double price,
    required String imageUrl,
    required String status,
  }) {
    final isAvailable = status == 'Available';

    return Card(
      elevation: 4,
      color: isAvailable ? Colors.white : Colors.grey[300],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text('\$${price.toStringAsFixed(2)}'),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: isAvailable ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          isAvailable
              ? ElevatedButton(
            onPressed: () {
              // Handle order action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ordering $name...'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            child: const Text('Order Now'),
          )
              : const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Out of Stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
