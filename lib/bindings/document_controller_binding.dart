import '../controllers/document_controller.dart';
import 'package:get/get.dart';

class DocumentControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DocumentController());
  }
}
