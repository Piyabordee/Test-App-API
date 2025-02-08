import 'package:flutter/material.dart';

class Video_View extends StatefulWidget {
  const Video_View({super.key});

  @override
  State<Video_View> createState() => _Video_ViewState();
}

class _Video_ViewState extends State<Video_View> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Video page", style: TextStyle(fontSize: 24),),);
  }
}