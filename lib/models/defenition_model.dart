class DefinitionsModel {
  String? definition;
  String? example;
  List<String>? synonyms;
  List<String>? antonyms;

  DefinitionsModel({this.definition, this.example, this.synonyms, this.antonyms});

  factory DefinitionsModel.fromJson(Map<String, dynamic> json) {
    return DefinitionsModel(
      definition: json['definition'],
      example: json['example'],
      synonyms: List<String>.from(json['synonyms'].map((x) => x)),
      antonyms: List<String>.from(json['antonyms'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['example'] = example;
    data['synonyms'] = synonyms;
    data['antonyms'] = antonyms;
    return data;
  }
}