import 'dart:convert';

class User {
  String name;
  String email;
  String countryCode; // New field
  String mobileNumber; // New field
  String password;
  String? profileImageUrl;

  User({
    required this.name,
    required this.email,
    required this.countryCode, // Add to constructor
    required this.mobileNumber, // Add to constructor
    required this.password,
    this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'countryCode': countryCode, // Include in JSON
      'mobileNumber': mobileNumber, // Include in JSON
      'password': password,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      countryCode: json['countryCode'], // Read from JSON
      mobileNumber: json['mobileNumber'], // Read from JSON
      password: json['password'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  static String encode(List<User> users) => json.encode(
    users.map<Map<String, dynamic>>((user) => user.toJson()).toList(),
  );

  static List<User> decode(String usersString) =>
      (json.decode(usersString) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
}