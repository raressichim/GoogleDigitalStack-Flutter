import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AudioApp());
}

class AudioApp extends StatelessWidget {
  const AudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(useMaterial3: true), home: HomePage());
  }
}

class HomePage extends StatelessWidget {

  HomePage({super.key});
  final List<String> words = <String>[
    'hello',
    'hello(ro)',
    'how are you?',
    'how are you?(ro)',
    'my names is Rares',
    'my name is Rares(ro)',
    'I am ok',
    'I am ok(ro)'
  ];
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio GridView'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                playAudio(index);
              },
              child: Card(
                elevation: 4.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.blue, Colors.purple],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(child: Text(words[index])),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final AudioCache player = AudioCache();
  final List<String> audioList = <String>[
    'hello.mp3',
    'hello(ro).mp3',
    'how_are_you.mp3',
    'how_are_you(ro).mp3',
    'my_name_is.mp3',
    'my_name_is(ro).mp3',
    'i_am_ok.mp3',
    'i_am_ok(ro).mp3'
  ];

  Future<void> playAudio(int i) async {
    audioPlayer.audioCache = player;
    await audioPlayer.play(AssetSource(audioList[i]));
  }
}
