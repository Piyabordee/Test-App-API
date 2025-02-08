import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:testapi/components/web_api/cat_api.dart';

class View_V extends StatefulWidget {
  const View_V({super.key});

  @override
  State<View_V> createState() => _View_VState();
}

class _View_VState extends State<View_V> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: Icon(IconlyLight.arrow_left_square)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cat_Api(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity, // กำหนดความกว้างเต็ม
                      height: 200,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn2.thedogapi.com/images/SJIUQl9NX_1280.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Cat & Dog",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black.withAlpha(70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildColoredBox(Colors.green),
                  _buildColoredBox(Colors.blue),
                  _buildColoredBox(Colors.yellow),
                  _buildColoredBox(Colors.purple),
                  _buildColoredBox(Colors.orange),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColoredBox(Color color) {
    return Container(
      color: color,
      height: 200,
      width: double.infinity,
      margin: EdgeInsets.all(8),
    );
  }
}
