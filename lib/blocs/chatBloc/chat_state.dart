part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadInProgress extends ChatState {}

class ChatLoadSuccess extends ChatState {
  final List<Chat> chats;

  ChatLoadSuccess({@required this.chats}) : assert(chats != null);
  @override
  List<Object> get props => [chats];

  @override
  String toString() => 'ChatLoadSuccess(requests: $chats)';
}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState({@required this.message}) : assert(message != null);
  @override
  List<Object> get props => [message];
}
