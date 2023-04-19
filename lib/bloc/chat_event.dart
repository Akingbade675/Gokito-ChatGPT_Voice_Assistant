part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {}

class SendMsg extends ChatEvent {
  final String message;
  SendMsg({required this.message});

  @override
  List<Object?> get props => [message];
}
