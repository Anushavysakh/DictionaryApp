import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:dictionaryapp/screens/word_detail_screen.dart';
import 'package:dictionaryapp/word_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchingText = "";
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> filteredList = [];
  TextEditingController _searchController = TextEditingController();
  final String _baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(children: [
        const SizedBox(
          height: 200,
        ),
        Text(
          "Dictionary",
          style: TextStyle(fontSize: 50, color: Colors.amber),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            controller: _searchController,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: Colors.white70,
              filled: true,
              hintText: 'Search for a word',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.deepPurple,
                weight: 30,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onChanged: (value) {
              wordProvider.fetchWord(_searchController.text.toLowerCase());
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        IconButton(
            onPressed: () async {
              if (_searchController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Missing!"),
                      content: Text("Type a word"),
                    );
                  },
                );
                Text("Type a word");
              } else
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WordDetailScreen(),
                ));
              _searchController.clear();
            },
            icon: Icon(Icons.arrow_circle_right_outlined,size: 100,))
      ]),
    );
  }
}
