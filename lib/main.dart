import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_sample/HomeView.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => HomeView()),
    ],
  ));
}
