import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:webview_flutter/webview_flutter.dart';

//void main() => runApp(const MaterialApp(home: WebViewExample()));

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';
var WebLink;

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color.fromARGB(255, 15, 15, 248),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color.fromARGB(255, 35, 221, 97),
};

class SegmentedControlApp extends StatelessWidget {
  const SegmentedControlApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: SegmentedControlExample(),
    );
  }
}

class SegmentedControlExample extends StatefulWidget {
  const SegmentedControlExample({Key? key, this.cookieManager})
      : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<SegmentedControlExample> createState() =>
      _SegmentedControlExampleState();
}

class _SegmentedControlExampleState extends State<SegmentedControlExample> {
  Sky _selectedSegment = Sky.midnight;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: skyColors[_selectedSegment],
        navigationBar: CupertinoNavigationBar(
          // This Cupertino segmented control has the enum "Sky" as the type.
          middle: CupertinoSlidingSegmentedControl<Sky>(
            backgroundColor: CupertinoColors.systemGrey2,
            thumbColor: skyColors[_selectedSegment]!,
            // This represents the currently selected segmented control.
            groupValue: _selectedSegment,
            // Callback that sets the selected segmented control.
            onValueChanged: (Sky? value) {
              if (value != null) {
                setState(() {
                  _selectedSegment = value;
                });
              }
            },
            children: <Sky, Widget>{
              Sky.midnight: CustomCard(
                onTap: () {
                  WebLink =
                      'https://twitter.com/search?q=Blood%20donation%20Uganda%20&src=typed_query';
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Twitter',
                    style: TextStyle(color: Color.fromARGB(255, 205, 24, 24)),
                  ),
                ),
              ),
              Sky.viridian: CustomCard(
                onTap: () {
                  WebLink =
                      'https://redcrossug.org/index.php/publications/news-events';
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'FaceBook',
                    style: TextStyle(color: Color.fromARGB(255, 219, 23, 23)),
                  ),
                ),
              ),
              Sky.cerulean: CustomCard(
                onTap: () {
                  WebLink = 'https://www.ubts.go.ug/news-and-campaigns.html';
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'NEWS',
                    style: TextStyle(color: Color.fromARGB(255, 227, 15, 15)),
                  ),
                ),
              ),
            },
          ),
        ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 143, 135),
          // appBar: AppBar(
          //   shadowColor: Colors.transparent,
          //   foregroundColor: Colors.transparent,
          //   // ignore: deprecated_member_use
          //   backwardsCompatibility: true,
          //   backgroundColor: Colors.transparent,
          //   bottomOpacity: 0.0,
          //   title: Center(child: const Text('Twitter Feeds.')),
          //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          //   actions: const <Widget>[
          //     // NavigationControls(_controller.future),
          //     // SampleMenu(_controller.future, widget.cookieManager),
          //   ],
          // ),
          body: WebView(
            //_selectedSegment.name
            initialUrl:
                '${WebLink}', //'https://twitter.com/search?q=Blood%20donation%20Uganda%20&src=typed_query'
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
            backgroundColor: const Color(0x00000000),
          ),
          //floatingActionButton: favoriteButton(),
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
