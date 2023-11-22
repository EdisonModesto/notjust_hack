import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? coverPhoto;
  String? businessName;
  String? businessDescription;
  List<String>? businessImages;

  GeoPoint? location;
  String? type;
  String? id;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
    required this.coverPhoto,
    required this.businessName,
    required this.businessDescription,
    required this.businessImages,
    required this.location,
    required this.type,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePhoto = json['profilePhoto'];
    coverPhoto = json['coverPhoto'];
    businessName = json['businessName'];
    businessDescription = json['businessDescription'];
    businessImages = json['businessImages'].cast<String>();
    location = json['location'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['profilePhoto'] = profilePhoto;
    data['coverPhoto'] = coverPhoto;
    data['businessName'] = businessName;
    data['businessDescription'] = businessDescription;
    data['businessImages'] = businessImages;
    data['location'] = location;
    data['type'] = type;

    return data;
  }
}
