part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure }

// ignore: must_be_immutable
class ChatState extends Equatable {
  List<ChatModel> messages;
  final ChatStatus status;

  ChatState({required this.messages, this.status = ChatStatus.initial});

  ChatState copyWith({
    List<ChatModel>? messages,
    ChatStatus? status,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, messages];
}
