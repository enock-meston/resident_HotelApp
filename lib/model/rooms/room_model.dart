class RoomModel {
  String roomId;
  String roomNumber;
  String roomType;
  String price;
  String status;

  RoomModel({
    required this.roomId,
    required this.roomNumber,
    required this.roomType,
    required this.price,
    required this.status,
  });

  // Factory method to create a UserModel from JSON
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['r_id'],
      roomNumber: json['room_number'],
      roomType: json['room_type'],
      price: json['price'],
      status: json['status'],
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'r_id': roomId,
      'room_number': roomNumber,
      'room_type': roomType,
      'price': price,
      'status': status,
    };
  }
}
