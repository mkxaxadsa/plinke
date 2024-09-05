import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  bool _isTrackingRedirect = false;
  String? _lastUrl;

  @override
  void initState() {
    super.initState();
    _unlockOrientation();
  }

  void _unlockOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  bool _shouldOpenInExternalScreen(String url) {
    print(url);
    return url.contains('payment') ||
        url.contains('checkout') ||
        url == 'https://posido505.com/preloader.html';
  }

  void _openInExternalScreen(String url) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExternalLinkScreen(url: url),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25.0, color: Colors.white),
          onPressed: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.university)),
            initialOptions: InAppWebViewGroupOptions(
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
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                _isLoading = true;
              });

              if (url.toString() == 'https://posido505.com/preloader.html') {
                _isTrackingRedirect = true;
                _lastUrl = url.toString();
              }
            },
            onLoadStop: (controller, url) async {
              setState(() {
                _isLoading = false;
              });

              if (_isTrackingRedirect) {
                if (_lastUrl != url.toString()) {
                  print('Redirected to: $url');
                  _isTrackingRedirect = false;
                }
                _lastUrl = url.toString();
              }

              String jsCode = """
                var allLinks = document.getElementsByTagName('a');
                if (allLinks) {
                  for (var i = 0; i < allLinks.length; i++) {
                    var link = allLinks[i];
                    var target = link.getAttribute('target');
                    if (target && target == '_blank') {
                      link.setAttribute('target', '_self');
                    }
                  }
                }
              """;
              await controller.evaluateJavascript(source: jsCode);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              print('Navigation request: $uri');

              if (_shouldOpenInExternalScreen(uri.toString())) {
                _openInExternalScreen(uri.toString());
                return NavigationActionPolicy.CANCEL;
              }

              return NavigationActionPolicy.ALLOW;
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
    );
  }
}

class ExternalLinkScreen extends StatelessWidget {
  final String url;

  const ExternalLinkScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('External Link'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
      ),
    );
  }
}
