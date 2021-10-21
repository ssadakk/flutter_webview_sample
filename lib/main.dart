import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_sample/HomeView.dart';

InAppLocalhostServer localhostServer = new InAppLocalhostServer();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await localhostServer.start();

  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => HomeView()),
    ],
  ));
}
