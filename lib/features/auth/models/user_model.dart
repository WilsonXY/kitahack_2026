enum UserRole { user, counselor, admin, unknown }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  // Create Model from Firebase
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['name'] ?? '',
      createdAt: (data['createdAt'] as dynamic).toDate() ?? DateTime.now(),
    );
  }

  // Converts User Model into a Map for Writing to Firestore
  Map<String,dynamic> toMap(){
    return{
      'uid' : uid,
      'name' : name,
      'email': email,
      'createdAt' : createdAt
    };
  }
}
