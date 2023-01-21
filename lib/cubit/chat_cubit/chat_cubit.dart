import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../service/auth_service.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void loginChat() async {
    // emit(ChatLoading());
    final email = AuthService.currentUser!.email;
    print("zego email = $email");

    String name = AuthService.isMember ? "member" : "vedor";
    print("zego name = $name");

    await ZIMKit().connectUser(id: email!, name: name);

    // emit(ChatSuccessLogin());
  }
}
