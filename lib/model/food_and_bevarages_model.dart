class FoodAndBeveragesModel {
  bool success;
  List<FoodItem> data;

  FoodAndBeveragesModel({
    required this.success,
    required this.data,
  });

  // Factory method to parse JSON into the Dart model
  factory FoodAndBeveragesModel.fromJson(Map<String, dynamic> json) {
    return FoodAndBeveragesModel(
      success: json['success'],
      data: List<FoodItem>.from(
        json['data'].map((item) => FoodItem.fromJson(item)),
      ),
    );
  }

  // Method to convert Dart object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class FoodItem {
  String id;
  String name;
  String price;
  String type;
  String image;
  String status;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.image,
    required this.status
  });

  // Factory method to parse a food item from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      type: json['type'],
      image: json['image'],
      status: json['status'],
    );
  }

  // Method to convert food item to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'image': image,
      'status': status,
    };
  }
}
