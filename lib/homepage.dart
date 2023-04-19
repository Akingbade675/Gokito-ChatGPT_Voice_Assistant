import 'package:flutter/material.dart';
import 'package:gokito/service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'widgets/features_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  final OpenAIService openAIService = OpenAIService();
  final FlutterTts tts = FlutterTts();
  bool speechEnabled = false;
  String lastWords = '';
  String chatResult = '';
  String? generatedImageUrl, generatedText;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await speechToText.listen(
      onResult: (result) {
        lastWords = result.recognizedWords;
      },
    );
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Gokito'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 119, 187, 243),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/robot.jpg'),
                    ),
                  ),
                )
              ],
            ),
            // chat bubble
            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                  top: 30,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                    ),
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: Radius.zero)),
                child: generatedImageUrl == null
                    ? Text(
                        chatResult == ''
                            ? "Good Morning, what task can I do for you?"
                            : chatResult,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      )
                    : Image.network(chatResult)),
            Visibility(
              visible: generatedText == null && generatedImageUrl == null,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 22,
                ),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Here are a few commands",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            // suggestion lists
            Visibility(
              visible: generatedText == null && generatedImageUrl == null,
              child: const FeaturesBox(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechEnabled) {
            if (speechToText.isListening) {
              stopListening();
              chatResult = await openAIService.isArtPrompt(lastWords);
              if (chatResult.contains("https://")) {
                generatedImageUrl = "true";
                generatedText = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedText = "true";
                setState(() {});
                tts.speak(chatResult);
              }
            } else {
              startListening();
            }
          } else {
            _initSpeech();
          }
        },
        backgroundColor: const Color.fromARGB(255, 54, 177, 185),
        tooltip: 'microphone',
        child: Icon(speechToText.isNotListening ? Icons.mic : Icons.square),
      ),
    );
  }
}
