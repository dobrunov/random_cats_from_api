// To parse this JSON data, do
//     final boredActivity = boredActivityFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../models/cat_facts_model.dart';

CatFacts catFactsCreateFromJson(String str) =>
    CatFacts.fromJson(json.decode(str));

String catFactsToJson(CatFacts data) => json.encode(data.toJson());

class CatFactsService {
  Future<CatFacts> getCatFacts() async {
    final response =
        await get(Uri.parse('https://cat-fact.herokuapp.com/facts/random'));
    final catFacts = catFactsCreateFromJson(response.body);
    return catFacts;
  }

  Future<Uint8List> getCatImage() async {
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse("https://cataas.com/cat")).load("");
    final Uint8List rawImage = imageData.buffer.asUint8List();
    return rawImage;
  }
}
