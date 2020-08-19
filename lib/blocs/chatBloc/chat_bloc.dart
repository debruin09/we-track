import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:we_track/models/chat.dart';
import 'package:we_track/repositories/firestore_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.databaseRepository) : super(ChatInitial());

  final FirestoreService databaseRepository;
  StreamSubscription _chatSubscription;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is LoadChat) {
      yield* _mapLoadChatToState();
    } else if (event is ChatUpdated) {
      yield* _mapChatUpdateToState(event);
    } else if (event is AddChat) {
      yield* _mapAddChatToState(event);
    }
  }

  Stream<ChatState> _mapChatUpdateToState(ChatUpdated event) async* {
    try {
      yield ChatLoadSuccess(chats: event.chats);
    } catch (e) {
      yield ChatErrorState(message: e.toString());
    }
  }

  Stream<ChatState> _mapLoadChatToState() async* {
    _chatSubscription?.cancel();
    _chatSubscription = databaseRepository.chats().listen(
      (chats) {
        add(ChatUpdated(chats));
      },
    );
  }

  Stream<ChatState> _mapAddChatToState(AddChat event) async* {
    databaseRepository.newChat(event.chat);
  }
}
