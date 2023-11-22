import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? name;
  String? description;
  String? image;
  GeoPoint? location;
  String? id;

  EventModel({
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    this.id,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
    location = json['location'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['location'] = location;
    return data;
  }
}
