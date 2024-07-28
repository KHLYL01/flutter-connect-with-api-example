import 'package:get/get.dart';
import 'package:get_api/view/api_page.dart';

class HomeController extends GetxController {
  void goToApi() {
    Get.to(const ApiPage());
  }
}
