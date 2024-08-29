import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/services.dart';

class NewUniversityScreen extends StatefulWidget {
  final String university;

  const NewUniversityScreen({Key? key, required this.university})
      : super(key: key);

  @override
  _NewUniversityScreenState createState() => _NewUniversityScreenState();
}

class _NewUniversityScreenState extends State<NewUniversityScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true;
  bool _canGoBack = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(36.0),
          child: AppBar(
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 25.0,
                color: Colors.white,
              ),
              onPressed: () async {
                if (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      widget.university.replaceFirst('http://', 'https://'))),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsBackForwardNavigationGestures: true,
                ),
              ),
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;
                if (uri.scheme == "https") {
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
              onLoadStop: (controller, url) async {
                setState(() {
                  _isLoading = false;
                });
                _canGoBack = await controller.canGoBack();
              },
            ),
            if (_isLoading)
              Container(
                color: const Color.fromARGB(255, 71, 18, 80),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
