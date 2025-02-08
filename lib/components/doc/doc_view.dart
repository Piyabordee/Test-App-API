import 'package:flutter/material.dart';

class Doc_View extends StatefulWidget {
  const Doc_View({super.key});

  @override
  State<Doc_View> createState() => _Doc_ViewState();
}

class _Doc_ViewState extends State<Doc_View> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Doc page", style: TextStyle(fontSize: 24),),);
  }
}