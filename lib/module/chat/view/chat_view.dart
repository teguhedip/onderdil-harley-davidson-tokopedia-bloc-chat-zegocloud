import 'package:example/cubit/chat_cubit/chat_cubit.dart';
import 'package:example/shared/widget/home_page_popup_chat/home_page_popup.dart';
import 'package:flutter/material.dart';
import 'package:example/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../controller/chat_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  Widget build(context, ChatController controller) {
    controller.view = this;

    final chatCubit = BlocProvider.of<ChatCubit>(context);
    print("zego dari chat view");
    chatCubit.loginChat();

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjChat"),
        actions: const [HomePagePopup()],
      ),
      body: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                );
              },
            ),
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Column(
      //       children: const [
      //         Text(
      //           "Ini chat dr tg",
      //           style: TextStyle(
      //             fontSize: 20.0,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  @override
  State<ChatView> createState() => ChatController();
}
