// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:gokito/constants.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future<String> isArtPrompt(String prompt) async {
    String result = 'An internal error occured';
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OPENAI_API_KEY",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content":
                  "Does this message want to generate an AI picture, image, art or anythoing similar? $prompt. Simply answer with a yes or no."
            }
          ],
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = (content.trim()).toLowerCase();
        if (content.contains("yes")) {
          result = await dallEAPI(prompt);
          return result;
        } else {
          result = await chatGPTAPI(prompt);
        }
      }

      return result;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OPENAI_API_KEY",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      print(res.body);

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)["choices"][0]["message"]["content"];
        content = content.trim();

        messages.add({
          "role": "assistant",
          "content": content,
        });

        return content;
      }

      return 'An internal error occured';
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OPENAI_API_KEY",
        },
        body: jsonEncode({
          "prompt": prompt,
          "n": 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)["data"][0]["url"];
        imageUrl = imageUrl.trim();

        messages.add({
          "role": "assistant",
          "content": imageUrl,
        });

        return imageUrl;
      }

      return 'An internal error occured';
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}