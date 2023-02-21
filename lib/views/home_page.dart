import 'dart:math';

import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/model/chat_gpt_request.dart';
import 'package:chat_gpt_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_gpt_bloc.dart';
import '../ui.model/chat.dart';

/// Created by Collins Ihezie
/// January 26th 2023

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _chatController = TextEditingController();
  bool typing = false;
  List<Chat> chatList = [];
  final _scrollController = ScrollController();
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text("ChatGPT-Native"),
        actions: [
          InkWell(
            onTap: (){
               setState(() {
                 chatList.clear();
               });
            },

            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Icon(Icons.clear_all)),
            ),
          )
        ],
        // centerTitle: true,
      ),
      body: BlocConsumer<ChatGptBloc, ChatGptObserverState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case ChatGptObserverStatus.success:
              for (var i in chatList) {
                i.isTyping = false;
              }
              chatList.addAll(state.chatGptResponse!.choices!
                  .map((e) => Chat(e.text!.replaceFirst("\n\n", ""), true, false, false)));

              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent + 2,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

              context.read<ChatGptBloc>().add(const ChatGptInitial());
              break;

            case ChatGptObserverStatus.initial:
              break;

            default:
          }

          return Container(
            margin: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                                  margin: EdgeInsets.only(
                                      left: !chatList[index].isChatGptResponse
                                          ? MediaQuery.of(context).size.width * 0.3
                                          : 0,
                                      top: 24,
                                      right: chatList[index].isChatGptResponse
                                          ? MediaQuery.of(context).size.width * 0.3
                                          : 0,
                                      bottom: 8),
                                  decoration: BoxDecoration(
                                      color: chatList[index].isChatGptResponse
                                          ? Colors.blue.shade300
                                          : Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(12.0),
                                          topRight: const Radius.circular(12.0),
                                          bottomLeft: chatList[index].isChatGptResponse
                                              ? Radius.zero
                                              : const Radius.circular(12.0),
                                          bottomRight:
                                          !chatList[index].isChatGptResponse
                                              ? Radius.zero
                                              : const Radius.circular(12.0))),
                                  child: chatResponse(chatList[index]),
                                )),
                            chatList[index].isTyping
                                ? AnimatedTextKit(
                              animatedTexts: [
                                FadeAnimatedText(
                                  'ChatGpt Typing...',
                                  textStyle:
                                  TextStyle(color: Colors.grey.shade400),
                                ),
                              ],
                            )
                                : Container(),
                          ],
                        );
                      },
                    )),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextFormField(
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                            controller: _chatController,
                            onChanged: (text) {
                              if (text.isNotEmpty) {
                                setState(() {
                                  typing = true;
                                });
                              } else {
                                setState(() {
                                  typing = false;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter message',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          )),
                          //
                          // AnimateIcon(
                          //   key: UniqueKey(),
                          //   onTap: () {},
                          //   iconType: IconType.continueAnimation,
                          //   height: 45,
                          //   width: 45,
                          //   color: Color.fromRGBO(
                          //       Random.secure().nextInt(255),
                          //       Random.secure().nextInt(255),
                          //       Random.secure().nextInt(255),
                          //       1),
                          //   animateIcon: AnimateIcons.volume,
                          // ),
                          InkWell(
                            onTap: typing
                                ? () {
                                    context.read<ChatGptBloc>().add(
                                        ChatGptRegisterSubscription(
                                            ChatGptRequest(
                                                model: "text-davinci-003",
                                                prompt: _chatController.text,
                                                max_tokens: 256,
                                                temperature: 0.7,
                                                top_p: 1,
                                                n: 1,
                                                stream: false,
                                                logprobs: null,
                                                stop: "[Human:, AI:]")));

                                    setState(() {
                                      chatList.add(Chat(_chatController.text,
                                          false, false, true));
                                      _chatController.clear();
                                      typing = false;
                                    });

                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      curve: Curves.easeOut,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    );
                                  }
                                : _voiceChat,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                typing
                                    ? Icons.send
                                    : _isListening == true
                                        ? Icons.stop_circle
                                        : Icons.keyboard_voice_outlined,
                                color: typing
                                    ? Colors.blue : _isListening == true ? Colors.redAccent
                                    : Colors.grey.shade400,
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget chatResponse(Chat chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: chat.isChatGptResponse
                ? AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        chat.message,
                        textStyle: const TextStyle(color: Colors.white),
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 0),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  )
                : Text(
                    chat.message,
                    style: const TextStyle(color: Colors.white),
                  )),
        chat.isChatGptResponse
            ? InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: chat.message))
                      .then((value) {
                    setState(() {
                      chat.isCopied = true;
                    });
                  });
                },
                child: Icon(
                  chat.isCopied ? Icons.check : Icons.copy,
                  size: 15,
                  color: Colors.white,
                ),
              )
            : Container()
      ],
    );
  }

  _voiceChat(){
    setState(() {
      _isListening = !_isListening;
    });

    if(_isListening){
      Helpers.enableSpeech();
    } else {
      _stopVoiceChat();
    }
  }

  _stopVoiceChat(){
    Helpers.stopSpeech((text) => {
      context.read<ChatGptBloc>().add(
          ChatGptRegisterSubscription(
              ChatGptRequest(
                  model: "text-davinci-003",
                  prompt: text,
                  max_tokens: 150,
                  temperature: 0.9,
                  top_p: 1,
                  n: 1,
                  stream: false,
                  logprobs: null,
                  stop: "[Human:, AI:]"))),
      chatList.add(Chat(text,
          false, false, true)),
    });
  }
}
