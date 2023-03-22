import 'dart:convert';

List<PlaceModel> placeListFromJson(String value) => List<PlaceModel>.from(json
    .decode(value)['place']
    .map((place) => PlaceModel.placeFromJson(place)));

class PlaceModel {
  final int id;
  final String name;
  final int time;

  PlaceModel({
    required this.id,
    required this.name,
    required this.time,
  });

  factory PlaceModel.placeFromJson(Map<String, dynamic> data) =>
      PlaceModel(id: data['id'], name: data['name'], time: data['time']);
}
