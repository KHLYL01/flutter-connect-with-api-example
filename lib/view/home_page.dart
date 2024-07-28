import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_api/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text('Home Page',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.goToApi();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text('Click me', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
