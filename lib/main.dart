import 'package:example/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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

  return runApp(MaterialApp(
    title: 'POS',
    navigatorKey: Get.navigatorKey,
    debugShowCheckedModeBanner: false,
    theme: getGojekTheme(),
    home: const LoginView(),
  ));
}


//PahlawanKeluarga91@gmail.com
//KerenAbis787