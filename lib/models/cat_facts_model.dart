import 'package:intl/intl.dart';

class CatFacts {
  CatFacts({
    required this.text,
    required this.createdAt,
  });

  String text;
  String createdAt;

  /// create object CatFacts with named constructor
  factory CatFacts.fromJson(Map<String, dynamic> json) => CatFacts(
      text: json["text"],
      createdAt: DateFormat("dd-MM-yyyy hh:mm")
          .format(DateTime.parse(json["createdAt"])));

  Map<String, dynamic> toJson() => {
        "text": text,
        "createdAt": createdAt,
      };
}
