// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'plant_model.dart';

class WUser {
  final String id;
  final List<WPlant> plants;

  WUser({
    required this.id,
    required this.plants,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plants': plants.map((e) => e.toMap()).toList(),
    };
  }

  factory WUser.fromMap(Map<String, dynamic> map) {
    return WUser(
      id: map['id'],
      plants: (map['plants'] as List).map((e) => WPlant.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WUser.fromJson(String source) => WUser.fromMap(json.decode(source));

  factory WUser.empty() => WUser(plants: [], id: "");

  WUser copyWith({
    String? id,
    List<WPlant>? plants,
  }) {
    return WUser(
      id: id ?? this.id,
      plants: plants ?? this.plants,
    );
  }
}
