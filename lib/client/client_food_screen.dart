import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/controller/FoodAndBeverageController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientFoodScreen extends StatefulWidget {
  const ClientFoodScreen({super.key});

  @override
  State<ClientFoodScreen> createState() => _ClientFoodScreenState();
}

class _ClientFoodScreenState extends State<ClientFoodScreen> {

  orderFoodOrBeverage(String Id) async{
    SharedPreferences sPref =await SharedPreferences.getInstance();
    var MyId = sPref.getString('clientId');
    var MyName = sPref.getString('names');
    print('my Id ${MyId} and ${MyName} and Food Id is ${Id}');

    var Url = Uri.parse(Api.orderFood);
    

  }

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
                status: item.status,
                id: item.id,// Use item.status
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
    required String id,
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
              String Fid = id.toString();
              // _showConfirmationDialog(context);
              // orderFoodOrBeverage(Fid);
              _showConfirmationDialog(context, Fid, name);
              // Handle order action
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Ordering $name...'),
              //   ),
              // );
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

  void _showConfirmationDialog(BuildContext context, String Fid, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Text('Are you sure you want to order $name?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                orderFoodOrBeverage(Fid); // Proceed with the order
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ordering $name...'),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
