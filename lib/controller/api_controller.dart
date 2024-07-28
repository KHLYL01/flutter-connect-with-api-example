import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_api/model/api_model.dart';
import 'package:get_api/view/api_page.dart';
import 'package:get_api/view/component.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  List<ApiModel> list = [];

  Future<List<ApiModel>> getAll() async {
    var response = await http.get(Uri.parse('http://10.0.2.2:8080/api/posts'));
    if (response.statusCode == 200) {
      log('${response.statusCode}');
      var body = jsonDecode(response.body);
      list =
          body.map((val) => ApiModel.fromJson(val)).cast<ApiModel>().toList();
      return list;
    }
    // return {'id': '1', 'title': 'error', 'body': 'fuck you'};
    return [ApiModel(id: 1, title: 'error', body: 'fuck you')];
  }

  Future<ApiModel> getById(int id) async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8080/api/posts/$id'));
    if (response.statusCode == 200) {
      log('${response.statusCode}');
      var body = jsonDecode(response.body);
      ApiModel apiModel = ApiModel.fromJson(body);
      return apiModel;
    }
    // return {'id': '1', 'title': 'error', 'body': 'fuck you'};
    return ApiModel(id: 1, title: 'error', body: 'zeze');
  }

  Future<void> create(Map<String, dynamic> body) async {
    var response = await http.post(Uri.parse('http://10.0.2.2:8080/api/posts'),
        body: body);
    if (response.statusCode == 200) {
      log('${response.statusCode}');
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: 'post added successfully',
          duration: Duration(seconds: 2),
          barBlur: 1,
          backgroundColor: Colors.green,
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'failure',
          message: 'error zeze',
          duration: Duration(seconds: 2),
          barBlur: 1,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> delete(int id) async {
    var response =
        await http.delete(Uri.parse('http://10.0.2.2:8080/api/posts/$id'));

    if (response.statusCode == 200) {
      log('${response.statusCode}');
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Success',
          message: 'post deleted successfully',
          duration: Duration(seconds: 2),
          barBlur: 1,
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(
          const Duration(seconds: 2), () => Get.off(const ApiPage()));
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'failure',
          message: 'error zeze',
          duration: Duration(seconds: 2),
          barBlur: 1,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void goToComponent(int index) {
    Get.to(Components(index));
  }
}
