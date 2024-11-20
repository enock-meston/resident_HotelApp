class ClientModel {
  final int clientId;
  final String names;
  final String phoneNumber;
  final String email;
  final String password;
  final String status;
  final DateTime addedOn;

  ClientModel({
    required this.clientId,
    required this.names,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.status,
    required this.addedOn,
  });

  // Factory constructor for creating a new ClientModel instance from a JSON map
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: int.parse(json['client_id']), // Convert client_id to int
      names: json['names'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'] ?? '', // Provide default if password is missing
      status: json['status'],
      addedOn: DateTime.parse(json['addedOn']),
    );
  }

  // Method for converting ClientModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'names': names,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'status': status,
      'addedOn': addedOn.toIso8601String(),
    };
  }
}
