part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChat extends ChatEvent {
  @override
  List<Object> get props => [];
}

class ChatUpdated extends ChatEvent {
  final List<Chat> chats;

  ChatUpdated(this.chats);
  @override
  List<Object> get props => [chats];
}

class DeleteChat extends ChatEvent {
  final Chat chat;

  DeleteChat(this.chat);
  @override
  List<Object> get props => [chat];
}

class AddChat extends ChatEvent {
  final Chat chat;

  AddChat(this.chat);
  @override
  List<Object> get props => [chat];
}
