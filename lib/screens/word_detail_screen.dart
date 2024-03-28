import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../word_provider.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({super.key});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final wordProvider = Provider.of<WordProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(wordProvider.word!.word.toString(),style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurpleAccent.shade100,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (wordProvider.word == null) {
              return Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.only(
                      left: 200, right: 3200, top: 400, bottom: 400),
                  child: const CircularProgressIndicator());
            } else {
              final word = wordProvider.word!;
              final phoneticText = word.phonetics![index].text ?? '';
              final meaning = word.meanings?[0];
              final partOfSpeech = meaning?.partOfSpeech?[index] ?? '';
              final definition = meaning?.definitions?[0].definition ?? '';
              final example = meaning?.definitions?[0].example ?? '';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${word.word} (${partOfSpeech ?? ''})',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () async {
                              try {
                                await audioPlayer
                                    .setSourceUrl(word.phonetics![0].audio!);
                                audioPlayer
                                    .setPlayerMode(PlayerMode.mediaPlayer);
                                await audioPlayer.play(
                                    UrlSource(word.phonetics![0].audio!),
                                    volume: 500);
                              } on Exception catch (e) {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                        title: Text("Note!"),
                                        content: Text("Audio not available"));
                                  },
                                );
                              }
                            },
                            icon: const Icon(Icons.record_voice_over_outlined)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      phoneticText.toString(),
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Meaning:",
                      style: TextStyle(
                        backgroundColor: Colors.white70,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      definition.toString(),
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Example:",
                      style: TextStyle(
                        backgroundColor: Colors.white70,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      example.toString(),
                      style: TextStyle(fontSize: 23),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
