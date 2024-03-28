import 'dart:convert';

import 'package:dictionaryapp/models/word_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WordProvider with ChangeNotifier {
  WordModel? _word;
  bool _isLoading = false;
  String _error = '';

  WordModel? get word => _word;

  bool get isLoading => _isLoading;

  String get error => _error;

  Future<WordModel?> fetchWord(String word) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      final response = await http.get(
          Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));
      if (response.statusCode == 200) {
        _word = WordModel.fromJson(json.decode(response.body)[0]);

        notifyListeners();
        return _word;
      } else {
        _error = 'Failed to load word';
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error: $e';
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }
}
