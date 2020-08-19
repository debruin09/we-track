import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_track/blocs/chatBloc/chat_bloc.dart';
import 'package:we_track/injection.dart';
import 'package:we_track/models/chat.dart';
import 'package:we_track/models/user.dart';
import 'package:we_track/shared/themes.dart/themes.dart';
import 'package:we_track/shared/widgets/message.dart';
import 'package:we_track/shared/widgets/send_button.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatBloc _chatBloc;
  @override
  void initState() {
    super.initState();
    _chatBloc = locator.get<ChatBloc>();
    _chatBloc.add(LoadChat());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    ScrollController scrollController = ScrollController();

    Future<void> callback() async {
      if (messageController.text.length > 0) {
        _chatBloc.add(AddChat(Chat(
          from: widget.user.username,
          text: messageController.text,
          me: widget.user.username,
        )));

        messageController.clear();
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white, fontFamily: "EraserDust-p70d"),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                    bloc: _chatBloc,
                    builder: (context, state) {
                      if (state is ChatInitial) {
                        return Center(
                          child: Container(
                            child: Text("No Messages"),
                          ),
                        );
                      } else if (state is ChatLoadInProgress) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ChatLoadSuccess) {
                        List<Widget> messagesWidget = state.chats
                            .map((chat) => Message(
                                  userType: widget.user.type,
                                  from: chat.from,
                                  text: chat.text,
                                  me: widget.user.username == chat.from,
                                ))
                            .toList();

                        return ListView(
                          controller: scrollController,
                          children: <Widget>[...messagesWidget],
                        );
                      }
                      return Container();
                    }),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) => callback(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: Colors.white,
                          hintText: "Enter a Message...",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                        controller: messageController,
                      ),
                    ),
                    SendButton(
                      text: "Send",
                      callback: callback,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
