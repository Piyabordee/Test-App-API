import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web_View extends StatefulWidget {
  final String web;
  const Web_View({super.key, required this.web});

  @override
  State<Web_View> createState() => _Web_ViewState();
}

class _Web_ViewState extends State<Web_View> {
  late final WebViewController _controller;
  bool isLoading = true; //สถานะการโหลด
  bool isError = false; //สถานะเกิดข้อผิดพลาด

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          //เริ่มโหลดหน้าเว็บ
          onPageStarted: (String url) {
            setState(() {
              isLoading = true; //เริ่มโหลดเว็บ
              isError = false; //ข้อผิดพลาด
            });
          },
          //โหลดหน้าเว็บเสร็จ
          onPageFinished: (String url) {
            setState(() {
              isLoading = false; //โหลดเว็บเสร็จ
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isError = true; //เกิดข้อผิดพลาด
            });
          },
          // คือ callback ที่ใช้ใน navigation ของ WebView
          onNavigationRequest: (NavigationRequest request) {
            if (_checkAppExternal(request.url)) {
              //เช็คว่าเป็น url ภายนอกหรือไม่ == true
              launchSocialApp(request.url); //เปิด url ภายนอก
              return NavigationDecision.prevent; //ไม่ให้เปิด url ภายนอก
            }
            return NavigationDecision.navigate; //ให้เปิด url ภายใน == false
          },
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36') // Set user agent.
      ..loadRequest(
        Uri.parse(widget.web),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(IconlyLight.arrow_left_square),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller), //เรียกใช้งาน WebViewWidget
          if (isLoading) //ถ้า isLoading เป็นจริง
            Center(
              child: CircularProgressIndicator(
                //แสดงการโหลด
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              ),
            ),
        ],
      ),
    );
  }

  bool _checkAppExternal(String url) {
    return url
            .contains("line.me") || //ตรวจสอบว่าเป็น url มีคำว่า line.me หรือไม่
        url.contains(
            "facebook.com") || //ตรวจสอบว่าเป็น url มีคำว่า facebook.com หรือไม่
        url.contains(
            "youtube.com") || //ตรวจสอบว่าเป็น url มีคำว่า youtube.com หรือไม่
        url.contains(
            "tiktok.com"); //ตรวจสอบว่าเป็น url มีคำว่า tiktok.com หรือไม่
  }

  //ฟังก์ชันเปิด url ภายนอก
  Future<void> launchSocialApp(String url) async {
    final Uri uri = Uri.parse(url); //แปลง string เป็น วัตถุ uri

    // เปิด url ภายนอก
    if (!await launchUrl(uri)) {
      debugPrint("ไม่สามารถเปิด url: $url"); //แสดงข้อความว่าไม่สามารถเปิด url
    }
  }
}
