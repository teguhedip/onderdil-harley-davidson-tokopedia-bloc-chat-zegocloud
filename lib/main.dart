import 'package:example/core.dart';
import 'package:example/cubit/chat_cubit/chat_cubit.dart';
import 'package:example/cubit/history_cubit/history_cubit.dart';
import 'package:example/cubit/product_list_cubit/product_list_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() async {
  await initialize();
  // windows, android, ios
  if (!kIsWeb) {
    var path = await getTemporaryDirectory();
    Hive.init(path.path);
  }

  mainStorage = await Hive.openBox('mainStorage');

  // TG Start

  await LocalProductService.load();
  await LocalHistoryService.load();
  // TG End

  ZIMKit().init(
    appID: 916208712, // your appid
    appSign:
        'f9dd916816d222d159b7f1a3a106e8429678ebf9804a895a8ec1e0e0f10ba72e', // your appSign
  );

  return runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProductListCubit(),
      ),
      BlocProvider(
        create: (context) => HistoryCubit(),
      ),
      BlocProvider(
        create: (context) => ChatCubit()..loginChat(),
      ),
    ],
    child: MaterialApp(
      title: 'POS',
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: getGojekTheme(),
      home: const LoginView(),
    ),
  ));
}


//PahlawanKeluarga91@gmail.com
//KerenAbis787