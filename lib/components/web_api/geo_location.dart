import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';

class Geo_Location extends StatefulWidget {
  const Geo_Location({super.key});

  @override
  State<Geo_Location> createState() => _Geo_LocationState();
}

class _Geo_LocationState extends State<Geo_Location> {
  String _currentLocation = ''; // ตัวแปรเก็บตำแหน่งปัจจุบัน
  String lat = ''; // ตัวแปรเก็บละติจูด
  String long = ''; // ตัวแปรเก็บลองจิจูด

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
        lat = "ละติจูด: ${position.latitude}"; // กำหนดค่าละติจูด
        long = "ลองติจูล: ${position.longitude}"; // กำหนดค่าลองจิจูด
      },
    );
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
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  lat,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  long,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
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
