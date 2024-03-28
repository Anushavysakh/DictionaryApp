import 'package:dictionaryapp/models/meanings_model.dart';
import 'package:dictionaryapp/models/phonetics_model.dart';

class WordModel {
  String? word;
  String? phonetic;
  List<PhoneticsModel>? phonetics;
  String? origin;
  List<MeaningsModel>? meanings;

  WordModel({
    this.word,
    this.phonetic,
    this.phonetics,
    this.origin,
    this.meanings,
  });

  WordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    phonetic = json['phonetic'];
    if (json['phonetics'] != null) {
      phonetics = <PhoneticsModel>[];
      json['phonetics'].forEach((v) {
        phonetics!.add( PhoneticsModel.fromJson(v));
      });
    }
    origin = json['origin'];
    if (json['meanings'] != null) {
      meanings = <MeaningsModel>[];
      json['meanings'].forEach((v) {
        meanings!.add( MeaningsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['word'] = word;
    data['phonetic'] = phonetic;
    if (phonetics != null) {
      data['phonetics'] = phonetics!.map((v) => v.toJson()).toList();
    }
    data['origin'] = origin;
    if (meanings != null) {
      data['meanings'] = meanings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
