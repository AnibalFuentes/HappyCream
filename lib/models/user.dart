
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? name;
  String? lastName;
  String? gender;
  String? role;
  String? birthDate;
  String? phone;
  String? email;
  String? idJefe;
  String? img;
  bool? state;

  User({
    this.name,
    this.lastName,
    this.gender,
    this.role,
    this.birthDate,
    this.phone,
    this.email,
    this.idJefe,
    this.uid,
    this.img,
    this.state,
  });
  static User fromDataSnapshot(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      uid: dataSnapshot['uid'],
      name: dataSnapshot['name'],
      lastName: dataSnapshot['lastName'],
      gender: dataSnapshot['gender'],
      role: dataSnapshot['role'],
      email: dataSnapshot['email'],
      phone: dataSnapshot['phone'],
      birthDate: dataSnapshot['birthDate'],
      img: dataSnapshot['img'],
      state: dataSnapshot['state'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'gender': gender,
        'birthDate': birthDate,
        'phone': phone,
        'email': email,
        'idJefe': idJefe,
        'img': img,
        'state': state,
      };
}
