import 'dart:convert';

/// A placeholder class that represents an entity or model.
class WPlant {
  const WPlant({required this.id, required this.image});

  final String id;
  final String image;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory WPlant.fromMap(Map<String, dynamic> map) {
    return WPlant(
      id: map['id'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WPlant.fromJson(String source) => WPlant.fromMap(json.decode(source));
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
