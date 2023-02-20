// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// A placeholder class that represents an entity or model.
class WPlant {
  const WPlant({required this.id, required this.image,this.humidity=1.0});

  final String id;
  final String image;
  final double humidity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'humidity':humidity,
    };
  }

  factory WPlant.fromMap(Map<String, dynamic> map) {
    return WPlant(
      id: map['id'],
      image: map['image'],
      humidity:map['humidity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WPlant.fromJson(String source) => WPlant.fromMap(json.decode(source));

  WPlant copyWith({
    String? id,
    String? image,
    double? humidity,
  }) {
    return WPlant(
      id: id ?? this.id,
      image: image ?? this.image,
      humidity: humidity ?? this.humidity,
    );
  }
}

List<WPlant> stores = const [
  WPlant(id: '1', image: 'assets/lotties/plant_1.json'),
  WPlant(id: '2', image: 'assets/lotties/plant_2.json'),
  WPlant(id: '3', image: 'assets/lotties/plant_3.json'),
  WPlant(id: '4', image: 'assets/lotties/plant_4.json'),
  WPlant(id: '5', image: 'assets/lotties/plant_5.json'),
  WPlant(id: '6', image: 'assets/lotties/plant_6.json'),
  WPlant(id: '7', image: 'assets/lotties/plant_7.json'),
  WPlant(id: '8', image: 'assets/lotties/plant_8.json'),
];
