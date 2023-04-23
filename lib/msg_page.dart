import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gokito/widgets/chatmessage_container.dart';
import 'package:gokito/widgets/features_box.dart';

import 'bloc/chat_bloc.dart';
import 'widgets/custom_textfield.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text(
          "InterGPT",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 8),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.status == ChatStatus.initial) {
                    return const SingleChildScrollView(child: FeaturesBox());
                  } else if (state.status == ChatStatus.loading ||
                      state.status == ChatStatus.success) {
                    ScrollController scrollController = ScrollController();
                    if (scrollController.hasClients) {
                      final position =
                          scrollController.position.maxScrollExtent;
                      scrollController.jumpTo(position);
                    }
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        return ChatItem(
                          message: state.messages[index].message,
                          isMe: state.messages[index].isMe,
                        );
                      },
                    );
                  }
                  return const Center(child: Text("Error Occurred"));
                },
              ),
            ),
            const CustomTextField(),
          ],
        ),
      ),
    );
  }
}
