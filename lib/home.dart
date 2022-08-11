import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController controller ;
  var loadingPercentage = 0;


  @override                                                     
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async {
      if(await controller.canGoBack()){
        controller.goBack();
        return false;
      }else{
        return true;
      }
    },

    child: Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()async{
            controller.reload();
          },
          child: Stack(
            children: [
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://topflexi.com',
                onWebViewCreated: (WebViewController controller){
                  this.controller = controller;
                },
                onPageStarted: (url) {
                  setState(() {
                    loadingPercentage = 0;
                  });
                },
                onProgress: (progress) {
                  setState(() {
                    loadingPercentage = progress;
                  });
                },
                onPageFinished: (url) {
                  setState(() {
                    loadingPercentage = 100;
                  });
                },
              ),
              if (loadingPercentage < 100)
                LinearProgressIndicator(
                  value: loadingPercentage / 100.0,
                ),
              ],
          ),
        )
      )
    ));
  }
}
