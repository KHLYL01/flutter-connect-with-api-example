import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_api/controller/api_controller.dart';

class ApiPage extends StatelessWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiController controller = Get.put(ApiController());
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
        backgroundColor: Colors.white.withOpacity(0.1),
        title: const Text(
          'My Api',
          style: TextStyle(
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
      body: FutureBuilder(
        future: controller.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.goToComponent(snapshot.data![index].id);
                      },
                      child: ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].body),
                        leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text('${snapshot.data![index].id}')),
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                      indent: MediaQuery.of(context).size.width / 6,
                      thickness: 0.3,
                    ),
                itemCount: snapshot.data!.length);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
