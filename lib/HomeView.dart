import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends GetView {
  // late WebViewController webViewController;
  late InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  final textEditController = TextEditingController();

  void openAlbum(){
    print('openAlbum()');
  }
  void openAlbumOnly(){
    print('openAlbumOnly()');
  }
  void openActivityOnly(){
    print('openActivityOnly()');
  }
  void openActivity(){
    print('openActivity()');
  }
  void studyComplete(){
    print('studyComplete()');
  }
  void runScreenshot(){
    print('runScreenshot()');
  }
  void closeWindowWithStudyPlayer(){
    print('closeWindowWithStudyPlayer()');
  }
  void startWifiManager(){
    print('startWifiManager()');
  }
  void searchWord(String jsonString){
    print('searchWord(), jsonString: ${jsonString}');
  }
  void showReward(String jsonString){
    print('showReward(), , jsonString: ${jsonString}');
  }
  void showDialog(String title, String text){
    print('showDialog()');
    print('title : ${title}');
    print('title : ${text}');
  }
  void showToast(String msg){
    print('showToast(), msg : ${msg}');
  }
  void changeClass(){
    print('changeClass()');
  }
  void setTitle(String strTitle){
    print('setTitle(), strTitle : ${strTitle}');
  }
  void callFinish(){
    print('callFinish()');
  }
  void hideKey(){
    print('hideKey()');
  }
  void showKey(){
    print('showKey()');
  }
  void callNext(){
    print('callNext()');
  }
  void callVideoPlayer(String url){
    print('callVideoPlayer(), url : ${url}');
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    if (Platform.isAndroid) {
      // WebView.platform = SurfaceAndroidWebView();
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    textEditController.value = TextEditingValue(text: "https://google.com");
    // textEditController.value = TextEditingValue(text: "http://127.0.0.1:8080/assets/handwriting/hwr_web_demo.html");

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
                  onPressed: () {
                    webViewController.loadUrl(
                        urlRequest: URLRequest(
                            url: Uri.parse(textEditController.text)));
                  },
                  child: Text("Go!")),
            ],
          ),
          Expanded(
            flex: 90,
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(textEditController.text),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    webViewController.addJavaScriptHandler(handlerName: 'openAlbum', callback: (args){
                      print('openAlbum(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'openAlbumOnly', callback: (args){
                      print('openAlbumOnly(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'openActivityOnly', callback: (args){
                      print('openActivityOnly(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'openActivirty', callback: (args){
                      print('openActivirty(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'StudyComplete', callback: (args){
                      print('StudyComplete(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'runScreeshot', callback: (args){
                      print('runScreeshot(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'closeWindowWithStudyPlayer', callback: (args){
                      print('closeWindowWithStudyPlayer(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'startWifiManager', callback: (args){
                      print('startWifiManager(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'closeWindow', callback: (args){
                      print('closeWindow(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'searchWord', callback: (args){
                      print('searchWord(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'showReward', callback: (args){
                      print('showReward(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'showDialog', callback: (args){
                      print('showDialog(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'showToast', callback: (args){
                      print('showToast(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'changeClass', callback: (args){
                      print('changeClass(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'setTitle', callback: (args){
                      print('setTitle(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'callFinish', callback: (args){
                      print('callFinish(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'hideKey', callback: (args){
                      print('hideKey(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'showKey', callback: (args){
                      print('showKey(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'callNext', callback: (args){
                      print('callNext(), args : ${args}');
                    });
                    webViewController.addJavaScriptHandler(handlerName: 'callVideoPlayer', callback: (args){
                      print('callVideoPlayer(), args : ${args}');
                    });
                  },
                  initialOptions: options,
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  // shouldOverrideUrlLoading: (controller, navigationAction) async {
                  //   var uri = navigationAction.request.url!;
                  //
                  //   if (![ "http", "https", "file", "chrome",
                  //     "data", "javascript", "about"].contains(uri.scheme)) {
                  //     if (await canLaunch(uri.toString())) {
                  //       // Launch the App
                  //       await launch(
                  //         uri.toString(),
                  //       );
                  //       // and cancel the request
                  //       return NavigationActionPolicy.CANCEL;
                  //     }
                  //   }
                  //
                  //   return NavigationActionPolicy.ALLOW;
                  // },
                ),
                // WebView(
                //   // initialUrl: widget.url,
                //   initialUrl: textEditController.text,
                //   javascriptMode: JavascriptMode.unrestricted,
                //   javascriptChannels: Set.from([
                //     JavascriptChannel(name: 'messageHandler', onMessageReceived: (JavascriptMessage message) {
                //       print(message);
                //     })
                //   ]),
                //   onWebViewCreated: (webController) {
                //     webViewController = webController;
                //
                //   },
                //   onPageFinished: (url) async {
                //     var title = await webViewController.getTitle();
                //     if (title != null && title.isEmpty) {
                //       webViewController.reload();
                //     }
                //   },
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
