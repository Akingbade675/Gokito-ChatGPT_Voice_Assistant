import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gokito/bloc/chat_bloc.dart';

class CustomTextField extends StatefulWidget {
  // final BuildContext context;
  const CustomTextField({
    super.key,
    // required this.context,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              controller: controller,
              maxLines: 10,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Send a message...",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                hintStyle: const TextStyle(fontFamily: "Inter"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                  gapPadding: 0,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                value.isNotEmpty ? null : null;
              },
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton.filled(
          onPressed: () {
            context.read<ChatBloc>().add(SendMsg(message: controller.text));
            controller.clear();
          },
          highlightColor: const Color.fromARGB(255, 54, 177, 185),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 54, 177, 185),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          icon: const Icon(Icons.send),
          padding: const EdgeInsets.all(14),
          splashColor: const Color.fromARGB(137, 54, 176, 185),
          iconSize: 22,
        )
      ],
    );
  }
}
