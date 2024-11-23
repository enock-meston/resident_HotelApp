import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/controller/FoodAndBeverageController.dart';

class ClientFoodScreen extends StatefulWidget {
  const ClientFoodScreen({super.key});

  @override
  State<ClientFoodScreen> createState() => _ClientFoodScreenState();
}

class _ClientFoodScreenState extends State<ClientFoodScreen> {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final FoodAndBeverageController controller = Get.put(FoodAndBeverageController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle navigation for 'Food'
                    },
                    child: const Text(
                      'Food',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle navigation for 'Beverages'
                    },
                    child: const Text(
                      'Beverages',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle navigation for 'My List'
                    },
                    child: const Text(
                      'My List',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        // Check loading state
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if the list is empty
        if (controller.foodItems.isEmpty) {
          return const Center(child: Text('No food items available.'));
        }

        // Display grid of food and beverages
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: GridView.builder(
            itemCount: controller.foodItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = controller.foodItems[index];
              return _buildFoodBeverageCard(
                name: item.name, // Use item.name
                price: item.price, // Use item.price
                type: item.type, // Use item.price
                imageUrl: item.image, // Use item.image
                status: item.status, // Use item.status
              );
            },
          ),
        );
      }),
    );
  }

  // Helper: Build a food/beverage card
  Widget _buildFoodBeverageCard({
    required String name,
    required String price,
    required String imageUrl,
    required String status,
    required String type,
  }) {
    final isAvailable = status == 'available';

    return Card(
      elevation: 4,
      color: isAvailable ? Colors.white : Colors.grey[300],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.network(
              Api.ServerName+imageUrl,
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
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(height: 1),
                            Text('${price} Rwf'),
                            const SizedBox(width: 1),
                            Text('-${type} Type'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1),
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
              backgroundColor: Colors.green,
            ),
            child: Text('Order Now', style: TextStyle(
              color: Colors.white,
            ),),
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
