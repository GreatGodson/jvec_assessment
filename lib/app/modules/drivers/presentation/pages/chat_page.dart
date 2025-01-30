import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/framework/helpers/call_helper.dart';
import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final String number;
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  ChatScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat with Driver",
          style: TextStyle(
            fontSize: Spacings.spacing18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: Spacings.spacing14,
            ),
            child: InkWell(
              onTap: () {
                CallHelper.makePhoneCall(number);
              },
              child: Icon(
                Icons.phone_enabled,
                size: Spacings.spacing24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  reverse: true,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        chatController.messages.reversed.toList()[index];
                    return Align(
                      alignment: message.isRider
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.isRider
                              ? Colors.blue
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(
                              color: message.isRider
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () {
                      if (textController.text.trim().isNotEmpty) {
                        chatController.sendMessage(
                            textController.text.trim(), true);
                        textController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
