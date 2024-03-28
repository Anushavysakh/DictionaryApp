class PhoneticsModel {
  String? text;
  String? audio;

  PhoneticsModel({this.text, this.audio});

  PhoneticsModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['text'] = text;
    data['audio'] = audio;
    return data;
  }
}
