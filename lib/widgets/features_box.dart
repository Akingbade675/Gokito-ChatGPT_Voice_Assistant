import 'package:flutter/material.dart';
import '../feature_box.dart';

class FeaturesBox extends StatelessWidget {
  const FeaturesBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(
            top: 10,
            left: 22,
          ),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Capabilities",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
        const FeatureBox(
          color: Color.fromARGB(255, 54, 177, 185),
          headerText: "ChatGPT",
          descriptionText:
              "A smarter way to stay organized and informed with ChatGPT",
        ),
        const FeatureBox(
          color: Color.fromARGB(255, 9, 147, 211),
          headerText: "Dall-E",
          descriptionText:
              "Get inspired and stay creative with your personal assistant powered by Dall-E",
        ),
        const FeatureBox(
          color: Color.fromARGB(255, 126, 239, 243),
          headerText: "Smart Voice Assistant",
          descriptionText:
              "Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT",
        ),
      ],
    );
  }
}
