import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resident_hotel_app/APIs/api.dart';
import 'package:resident_hotel_app/controller/FoodAndBeverageController.dart';

class FoodAndBeveragesScreen extends StatefulWidget {
  const FoodAndBeveragesScreen({super.key});

  @override
  State<FoodAndBeveragesScreen> createState() => _FoodAndBeveragesScreenState();
}

class _FoodAndBeveragesScreenState extends State<FoodAndBeveragesScreen> {
  // Initialize the controller
  final FoodAndBeverageController _controller =
      Get.put(FoodAndBeverageController());

  final List<Map<String, dynamic>> items = [
    {
      'name': 'Burger',
      'price': 5.99,
      'image': null, // Replace with actual image path if needed
      'type': 'Food',
    },
    {
      'name': 'Coffee',
      'price': 3.50,
      'image': null,
      'type': 'Beverage',
    },
  ];

  File? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedType = "Food"; // Default selection

  Future<void> _pickImage() async {
    Permission permission;

    // Check platform and assign the appropriate permission
    if (Platform.isAndroid) {
      // For Android 13 or higher, use READ_MEDIA_IMAGES
      if (await Permission.photos.request().isGranted) {
        permission = Permission.photos;
      } else {
        permission = Permission.storage;
      }
    } else {
      permission = Permission.photos; // iOS permissions for photo access
    }

    final status = await permission.request();

    if (status.isGranted) {
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
        }
      } catch (e) {
        print("Error picking image: $e");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Permission to access gallery is required. Please enable it in settings.'),
        ),
      );
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Item"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: "Type"),
                    items: ["Food", "Beverage"]
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text("Tap to select image"),
                            ),
                          )
                        : Image.file(
                            _selectedImage!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Call the controller to save the item
                await _controller.saveItem(
                  name: _nameController.text,
                  price: double.tryParse(_priceController.text) ?? 0.0,
                  type: _selectedType!,
                  imageFile: _selectedImage,
                );

                // Clear the input fields after saving
                setState(() {
                  _nameController.clear();
                  _priceController.clear();
                  _selectedType = "Food";
                  _selectedImage = null;
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the instance of the controller
    final FoodAndBeverageController controller = Get.put(FoodAndBeverageController());

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Food and Beverages'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: () {
      //         // Trigger the refresh functionality
      //         controller.fetchFoodItems(); // Call the fetch method to refresh data
      //       },
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          // Use Obx to react to changes in the foodItems list and isLoading state
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // If foodItems list is empty, show a message
          if (controller.foodItems.isEmpty) {
            return const Center(child: Text('No food items available.'));
          }

          return ListView.builder(
            itemCount: controller.foodItems.length,
            itemBuilder: (context, index) {
              final item = controller.foodItems[index]; // Access FoodItem
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 3,
                child: ListTile(
                  leading: item.image.isNotEmpty
                      ? Image.network(
                    Api.ServerName+item.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : const Icon(Icons.fastfood, size: 50),
                  title: Text(item.name), // Access name from FoodItem
                  subtitle: Text(
                    'Type: ${item.type} - \$${item.price}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    print('${item.name} clicked ${Api.ServerName+item.image}');
                  },
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
