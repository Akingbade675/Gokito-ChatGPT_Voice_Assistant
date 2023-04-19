import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gokito/chat_model.dart';
import 'package:gokito/service.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(messages: const [])) {
    on<SendMsg>(_getResponse);
  }

  void _getResponse(SendMsg event, Emitter<ChatState> emit) async {
    ChatModel newMessage = emitMessage(message: event.message, isMe: true);
    emit(state.copyWith(
      messages: List.from(state.messages)..add(newMessage),
      status: ChatStatus.loading,
    ));

    try {
      final response = await OpenAIService().isArtPrompt(event.message);
      newMessage = emitMessage(message: response);

      final updatedMessage = List.from(state.messages)..add(newMessage);
      emit(state.copyWith(
        messages: updatedMessage.cast<ChatModel>(),
        status: ChatStatus.success,
      ));
    } on Exception catch (_) {
      emit(state.copyWith(
        status: ChatStatus.failure,
      ));
    }
  }

  ChatModel emitMessage({message, isMe = false}) {
    ChatModel newMessage = ChatModel(
      message: message,
      time: DateTime.now().toString(),
      isMe: isMe,
    );
    return newMessage;
  }
}
