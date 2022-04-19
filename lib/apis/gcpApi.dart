import 'dart:typed_data';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:url_launcher/url_launcher.dart';

class CloudApi {
  final auth.ServiceAccountCredentials _credentials;
  late auth.AutoRefreshingAuthClient _client;

  CloudApi(String json)
      : _credentials = auth.ServiceAccountCredentials.fromJson(json);

  void openDoc(String url) async {
    if (_client == null)
      _client =
          await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);
    var storage = Storage(_client, 'docxon');
    var bucket = storage.bucket('docxon-doc-repo');
    // bucket.read();
    //  bucket.read(objectName).pipe(streamConsumer)

    //  if (await canLaunch(url)) {
    //   await launch(url,
    //       forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
