// Disease class
import 'dart:convert';

class Disease {
  String id;
  String diseaseName;
  String antidote;
  String description;

  Disease({
    required this.id,
    required this.diseaseName,
    required this.antidote,
    required this.description,
  });

  factory Disease.fromMap(Map<String, dynamic> json) => Disease(
        id: json["_id"],
        diseaseName: json["diseaseName"],
        antidote: json["antidote"],
        description: json["description"],
      );

  List<Disease> postFromJson(String str) =>
      List<Disease>.from(json.decode(str).map((x) => Disease.fromMap(x)));

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json["_id"],
      diseaseName: json["diseaseName"],
      antidote: json["antidote"],
      description: json["description"],
    );
  }
}
