import 'package:dictionaryapp/models/defenition_model.dart';

class MeaningsModel {
  String? partOfSpeech;
  List<DefinitionsModel>? definitions;

  MeaningsModel({this.partOfSpeech, this.definitions});

  MeaningsModel.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <DefinitionsModel>[];
      json['definitions'].forEach((v) {
        definitions!.add(DefinitionsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partOfSpeech'] = partOfSpeech;
    if (definitions != null) {
      data['definitions'] = definitions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
