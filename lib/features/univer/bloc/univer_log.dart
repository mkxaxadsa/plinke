import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewUniversityScreen extends StatefulWidget {
  final String university;

  const NewUniversityScreen({required this.university});

  @override
  _NewUniversityScreenState createState() => _NewUniversityScreenState();
}

class _NewUniversityScreenState extends State<NewUniversityScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true; // State to track loading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.university)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            initialOptions: InAppWebViewGroupOptions(
              ios: IOSInAppWebViewOptions(
                allowsBackForwardNavigationGestures: true,
              ),
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              if (uri.scheme == "http" || uri.scheme == "https") {
                return NavigationActionPolicy.ALLOW;
              } else {
                return NavigationActionPolicy.CANCEL;
              }
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.purple,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
