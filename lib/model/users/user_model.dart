class UserModel {
  String userId;
  String names;
  String email;
  String username;
  String userType;
  String status;

  UserModel({
    required this.userId,
    required this.names,
    required this.email,
    required this.username,
    required this.userType,
    required this.status,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      names: json['names'],
      email: json['email'],
      username: json['username'],
      userType: json['userType'],
      status: json['status'],
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'names': names,
      'email': email,
      'username': username,
      'userType': userType,
      'status': status,
    };
  }
}
