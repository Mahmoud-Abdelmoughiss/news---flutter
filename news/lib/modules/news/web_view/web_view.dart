import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewPage extends StatelessWidget {
  final String url;
  WebViewPage({@required this.url});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" الخبر فــى صـفــحـة ويـــب"),
        ),
        body: WebView(
          initialUrl: url,
          zoomEnabled: true,
        ),
      ),
    );
  }
}
