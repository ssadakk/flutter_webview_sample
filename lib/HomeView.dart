import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends GetView {
  late WebViewController webViewController;
  final textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    textEditController.value = TextEditingValue(text: "https://google.com");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditController,
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Url',
                )),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: (){
                    webViewController.loadUrl(textEditController.text);
                  }, child: Text("Go!")),
            ],
          ),
          Expanded(
            flex: 90,
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: WebView(
                  // initialUrl: widget.url,
                  initialUrl: textEditController.text,
                  onWebViewCreated: (webController) {
                    webViewController = webController;
                  },
                  onPageFinished: (url) async {
                    var title = await webViewController.getTitle();
                    if (title != null && title.isEmpty) {
                      webViewController.reload();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
