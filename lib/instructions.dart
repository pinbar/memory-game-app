import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Instructions extends StatefulWidget {
  const Instructions({super.key});
  static const String description =
      'Tap a tile, then guess which other tile has a word with the same starting letter.\n\nIf you get it wrong, both words flip back so you can guess again. \n \nGood Luck!';

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void initState() {
    _setupTts();
    super.initState();
  }

  @override
  void dispose() async {
    Future.delayed(Duration.zero, () async {
      await flutterTts.stop();
    });
    isSpeaking = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Instructions'),
      content: SingleChildScrollView(
        child: Column(children: [
          const Text(Instructions.description),
          IconButton(
            icon: isSpeaking
                ? const Icon(Icons.record_voice_over_outlined,
                    color: Colors.purple)
                : const Icon(Icons.volume_down),
            onPressed: isSpeaking ? _pauseSpeaking : _startSpeaking,
          )
        ]),
      ),
    );
  }

  Future _setupTts() async {
    // flutterTts.getLanguages.then((value) => print(value)); //see all the languages on the device
    await flutterTts.setLanguage('en-US');
  }

  Future _startSpeaking() async {
    setState(() {
      isSpeaking = true;
    });
    await flutterTts.speak(Instructions.description);
    if (isSpeaking == true) {
      await flutterTts.awaitSpeakCompletion(true);
      setState(() {
        isSpeaking = false;
      });
    }
  }

  Future _pauseSpeaking() async {
    await flutterTts.pause();
    setState(() {
      isSpeaking = false;
    });
  }
}
