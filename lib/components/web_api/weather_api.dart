import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;

class WeatherApi extends StatefulWidget {
  const WeatherApi({super.key});

  @override
  State<WeatherApi> createState() => _WeatherApiState();
}

class _WeatherApiState extends State<WeatherApi> {
  List<dynamic> _hourlyTemperature =
      []; // สร้างตัวแปร _hourlyTemperature แบบ List ที่เป็น dynamic
  bool _isLoading =
      true; // สร้างตัวแปร _isLoading แบบ boolean และกำหนดค่าเริ่มต้นเป็น true
  String _ErrorMessage = ""; // สร้างตัวแปร _ErrorMessage แบบ String

  String _currentLocation = ''; // ตัวแปรเก็บตำแหน่งปัจจุบัน
  double lat = 0.0; // ตัวแปรเก็บละติจูด
  double long = 0.0; // ตัวแปรเก็บลองจิจูด

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // ฟั่งชั่นเรียกใช้ตำแหน่งปัจจุบัน
  }

  // ฟั่งชั่นเรียกใช้ตำแหน่งปัจจุบัน
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled; // ตัวแปรเก็บสถานะการเปิดใช้งานตำแหน่งปัจจุบัน
    LocationPermission
        permission; // ตัวแปรเก็บสถานะการอนุญาติใช้งานตำแหน่งปัจจุบัน

    // ตรวจสอบสถานะการเปิดใช้งานตำแหน่งปัจจุบัน
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ถ้าตำแหน่งปัจจุบันปิดอยู่
      setState(
        () {
          _currentLocation = 'Location services ปิดอยู่กรุณาเปิดใช้งาน';
          _showAlertDialog(context, "ข้อผิดพลาด", _currentLocation);
        },
      );
      return;
    }

    // ตรวจสอบสถานะการอนุญาติใช้งานตำแหน่งปัจจุบัน
    permission = await Geolocator
        .checkPermission(); // ตรวจสอบสถานะการอนุญาติใช้งานตำแหน่งปัจจุบัน
    if (permission == LocationPermission.denied) {
      //
      permission = await Geolocator
          .requestPermission(); // ขออนุญาติใช้งานตำแหน่งปัจจุบัน
      if (permission == LocationPermission.denied) {
        // ถ้าไม่อนุญาติใช้งานตำแหน่งปัจจุบัน
        setState(
          () {
            _currentLocation =
                'Permission ปิดอยู่กรุณาเปิดใช้งาน'; // กำหนดข้อความให้กับตัวแปร _currentLocation
            _showAlertDialog(context, "ข้อผิดพลาด", _currentLocation);
          },
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ถ้าไม่อนุญาติใช้งานตำแหน่งปัจจบันตลอดไป
      setState(
        () {
          _currentLocation =
              'สิทธิ์ถูกปฏิเสธถาวร'; // กำหนดข้อความให้กับตัวแปร _currentLocation
          _showAlertDialog(context, "ข้อผิดพลาด", _currentLocation);
        },
      );
      return;
    }

    // ดึงตำแหน่งปัจจุบัน
    Position position = await Geolocator.getCurrentPosition(
        // ดึงตำแหน่งปัจจุบัน
        desiredAccuracy: LocationAccuracy.high); // ความแม่นยำของตำแหน่งปัจจุบัน

    setState(
      () {
        // lat = "ละติจูด: ${position.latitude}"; // กำหนดค่าละติจูด
        // long = "ลองติจูล: ${position.longitude}"; // กำหนดค่าลองจิจูด
        lat = position.latitude; // กำหนดค่าละติจูด
        long = position.longitude; // กำหนดค่าลองจิจูด
      },
    );
    _fetchWeatherData(lat, long);
  }

  Future<void> _fetchWeatherData(double lat, double long) async {
    // ส่วนของการเรียกใช้งาน API ของ OpenWeatherMap
    var client = http.Client(); // สร้างตัวแปร client แบบ http.Client

    try {
      final response = await client.get(
        Uri.parse(
            "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&hourly=temperature_2m"), //  ส่งค่าขอ api ของ OpenWeatherMap
      );
      if (response.statusCode == 200) {
        final data = json.decode(response
            .body); // แปลงข้อมูล response.body ให้เป็น json และเก็บไว้ใน data

        setState(
          () {
            _hourlyTemperature = data['hourly'][
                'temperature_2m']; // กำหนดค่า _hourlyTemperature ให้เป็น data['hourly']['temperature_2m']
            _isLoading = false; // กำหนดค่า _isLoading เป็น false
            // print(_hourlyTemperature);
          },
        );
      } else {
        setState(
          () {
            _ErrorMessage =
                "Error: ${response.statusCode}"; // ถ้าไม่ใช่ 200 ให้เก็บข้อความ Error: ${response.statusCode} ไว้ใน _ErrorMessage
            _showAlertDialog(context, "ข้อผิดพลาด", _ErrorMessage);
          },
        );
      }
    } catch (e) {
      setState(
        () {
          _showAlertDialog(
              context, "ข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับ API ได้");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40, // กำหนดความสูงของ AppBar
        leading: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(IconlyLight.arrow_left_square),
        ),
      ),
      body: _isLoading // ถ้า _isLoading เป็น true
      // การสร้างแบบลดรูป Conditional Expression (? :): ถ้าเงื่อนไขเป็นจริง ให้ทำงานที่เข้าไปหลัง ? ถ้าเงื่อนไขเป็นเท็จ ให้ทำงานที่เข้าไปหลัง :
          ? Center(
              // ถ้า _isLoading เป็น true ให้แสดง CircularProgressIndicator
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              ),
            )
          : _hourlyTemperature
                  .isNotEmpty // ถ้า _hourlyTemperature ไม่เป็นค่าว่าง
              ? Column(
                  children: [
                    Card(
                      elevation: 8,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    Colors.lightGreen.withOpacity(0.1), // สีเงา
                                offset: Offset(0, 4), // ตำแหน่งเงา
                                blurRadius: 12, // ความเข้มของเงา
                                spreadRadius: 2), // การกระจายของเงา
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${_hourlyTemperature[0]}C", // แสดงค่าอุณหภูมิในช่วงเวลา 1 ชั่วโมง
                                style: TextStyle(
                                    fontSize: 70,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "อุณหภูมิในช่วงเวลา 1 ชั่วโมง",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  // ถ้า _hourlyTemperature เป็นค่าว่าง
                  child: Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
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
          content: Text(message),
          actions: <Widget>[
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      "ตกลง",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Alike",
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
