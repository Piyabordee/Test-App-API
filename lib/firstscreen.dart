import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testapi/main_menu.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();

    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      _showToast('Mobile Data available');
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      _showToast("Wi-fi is available");
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      _showToast('Ethernet connection available');
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      _showToast('Vpn connection available');
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      _showToast('Bluetooth connection available');
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      _showToast('Other connection available');
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        _showAlertDialog(context, "Error", "No available network");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.lightGreen, Colors.white],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.6, 0.5),
            tileMode: TileMode.mirror),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            './android/assets/image/app.png',
            height: 250,
          ),
          SizedBox(
            height: 50,
          ),
          SpinKitWaveSpinner(
            color: Colors.green,
            size: 50.0,
          ),
        ],
      ),
    );
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 12.0);
    _timer();
  }

  void _timer() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Main_Menu())));
  }

  void _showAlertDialog(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontFamily: "Alike",
                  fontWeight: FontWeight.w500),
            ),
            content: Text(msg),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.lightGreen)),
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(
                    "OK",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Alike",
                        fontWeight: FontWeight.w500),
                  ))
            ],
          );
        });
  }
}
