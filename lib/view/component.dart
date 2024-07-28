import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_api/controller/api_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Components extends GetView<ApiController> {
  const Components(this.id, {Key? key}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.1),
        title: Text(
          controller.list[id].title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: controller.getById(id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('id: ${snapshot.data!.id}'),
                            const SizedBox(height: 16),
                            Text('title: ${snapshot.data!.title}'),
                            const SizedBox(height: 16),
                            Text('body:${snapshot.data!.body} '),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            InkWell(
                onTap: () {
                  controller.delete(id);
                },
                child:
                    const Icon(Icons.delete, size: 100, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
