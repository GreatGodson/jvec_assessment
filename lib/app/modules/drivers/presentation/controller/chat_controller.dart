import 'dart:math';

import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;

  final List<String> driverResponses = [
    "Got it! On my way. 🚗",
    "I'll be there in 5 minutes.",
    "Traffic is a bit heavy, but I'm coming.",
    "Please confirm your location.",
    "I'm outside, please come out. 🚖",
    "How long will you take?",
    "Let me know if you need anything.",
  ];

  void sendMessage(String text, bool isRider) {
    messages.add(MessageModel(text: text, isRider: isRider));

    if (isRider) {
      _simulateDriverResponse();
    }
  }

  void _simulateDriverResponse() {
    Future.delayed(Duration(seconds: Random().nextInt(3) + 1), () {
      final randomResponse =
          driverResponses[Random().nextInt(driverResponses.length)];
      messages.add(MessageModel(text: randomResponse, isRider: false));
    });
  }
}

class MessageModel {
  final String text;
  final bool isRider;

  MessageModel({required this.text, required this.isRider});
}
