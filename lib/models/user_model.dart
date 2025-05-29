import 'dart:convert';

class User {
  String name;
  String email;
  String password;
  String? profilePic;

  User({
    required this.name,
    required this.email,
    required this.password,
    this.profilePic,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profilePic': profilePic,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],
    );
  }

  // what we do here is encode all the users and store in local storage
  static String encode(List<User> users) => json.encode(
    users.map<Map<String, dynamic>>((user) => user.toJson()).toList(),
  );

  // what we do here is decode the object from local storage and convert each of them into user object
  static List<User> decode(String usersString) =>
      (json.decode(usersString) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
}
