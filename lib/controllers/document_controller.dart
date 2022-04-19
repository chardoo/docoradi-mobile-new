import '../model/Document.dart';
import '../model/ViewLater.dart';
import '../apis/gcpApi.dart';
import '../apis/httpService.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  HttpService httpService = HttpService();
  final Rx<ViewLaterModel> _vieelead = Rx(ViewLaterModel());

  dynamic get vieelead {
    return _vieelead;
  }

  void getDataforViewLater() async {
    try {
      final List<Documents> data = await httpService.getDocuments();
      // final List<Documents> data = [];
      vieelead.addRecent(data);
      for (var prop in data) {
        if (prop.isLater == true) {
          vieelead.add(prop);
        }
      }

      // print(vieelead.recentsdoc);
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getDataforViewLater();
    super.onInit();
  }

  void viewlater(Documents doc) {
    vieelead.add(doc);
    // setState(() {
    //   vieelead.docs;
    // });
    httpService.setAsViewLater(doc.objectID);
  }

  void RemoveFromviewlater(Documents doc) {
    vieelead.romoveFromList(doc);
    // setState(() {
    //   vieelead.docs;
    // });
    httpService.removeAsViewLater(doc.objectID);
  }

  void markAsView(Documents doc) {
    // print('view later');
    // print(doc);
    vieelead.add(doc);
    httpService.markAsViewed(doc.objectID);
  }
}
