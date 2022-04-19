import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import '../httpBaseInstances/dio_instance.dart';
import 'dart:typed_data';
import 'package:gcloud/storage.dart';
import 'package:googleapis/people/v1.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import '../model/UploadedDocuments.dart';
import 'dart:convert';
import 'package:http/http.dart';
// import 'package:flutter_application_1/components/';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/Document.dart';
import "package:http/http.dart" as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';

class PersonalDocumentUtil extends StatefulWidget {
  final UploadedDocuments doc;

  PersonalDocumentUtil(this.doc);
  @override
  _PersonalDocumentUtil createState() => _PersonalDocumentUtil();
}

class _PersonalDocumentUtil extends State<PersonalDocumentUtil> {
  dynamic image = Uint8List(0);

  get dir => null;

  get fileName => null;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Back',
            style: TextStyle(
                color: Color.fromARGB(255, 245, 242, 242),
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontFamily: 'Open Sans',
                fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 27, 27, 27),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.doc.documentType,
                style: TextStyle(
                  color: Color.fromARGB(255, 245, 242, 242),
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Click to view your documment ',
                style: TextStyle(
                  color: Color.fromARGB(255, 245, 242, 242),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Color.fromARGB(255, 252, 249, 249),
                child: new Icon(
                  Icons.file_copy,
                  color: Color.fromARGB(255, 22, 22, 22),
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening the Document')),
                  );
                  _launchURL(widget.doc.documentURL);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _launchURL(link) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    var credentials = new auth.ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "docxon",
      "private_key_id": "3682fb3b7b1c5d016a23b8091ef45b9605979674",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCPyQL4uxbrivJi\n+S/dVthS79B8yTf9JZuZYkkgDBOMrm8EsORxXJhzV5zEZlkXhVJJ4Z65+XpIbS6E\n0bk5lAeO83IhsscgIXacXO0gPpl04LWJ+dsn72BhovsZmaqoWl0VzzZKR4/0ioKG\nivMVeKJchD+qzHGXr30QopJrvIubu1kJlC8paats49yVVjK1CJGWNCIMRof4QP48\nxHbkr0DHXwzWRidjVVCR5NlzZMrJkhp03XVB3NxX9j9LYIktZSc3tJaC/Z2VkzjD\n1GqM4P9O6l9u3nzgOWN34inWwDFB4lDt6t692Z+APLnViiTGDlsTIZ+kZ4IILyfA\ndS6h01ITAgMBAAECggEAET2+w/mXKX5bSz/rG+Tmgqdr/hKYypugWVeeQiAAlh1y\nhYL6mZdLVoVacHh/VWEwuVg7ErzWC2pAKkAFsGBOObd6Z40K8JDiqqQ/8N5gw1GQ\noy9ZNqQvD/YdmvfArXhMcimLLoP/QIj9VsnBlUEGYwaepcnnExPBcOW1ngKZUP6L\njyVs0aeCrnJS2+8xwK/Xo6VIQI+vUL8IcbLREQJOQefXgWRK57Ybmi3KbDw0axDL\nQMwViz9i5cGwlAwp0IYjjqVObi4YIVj50NkJSXKdigxJAGrwbuRJ7dx+8DM+B+nm\nXy1zvfRQYo8BNfttkHWuDJ0uC9vI7rp5Fx/n8h5r4QKBgQDAdsog9Z7jY+rbDwfU\np8PPtHI6bZb+k7zxtzXoyn6FasTFMtlirBfwfjlJ8Kmk/VGPWnW5IUxSPQlFX/Js\nV/ZIEt6OMe4cDVYPZdHeruhskhVD8AvhT2AtkhGQ2cA+BthYhoaO6Id6xdtII6gB\nVkfgiXXQ2b3HCCJhyFxGirZ78wKBgQC/QFsRzKUpRsDVqy49vXhY8CRzeXxY45Fh\n9iXhEDGR93/MXMo8cw6u82QA8KvpzMyLoz8uxK+MGp0F+zztVN9nSWxvLSkqeWWh\n1vhcpf3y3Vllz7YXkpWF5mMqF7CrHj5sy8wiga3/TVoKYUC0oeLFUrlSWW8EyOry\n56FRLiX5YQKBgQCa1TXJDDBVuIUw08e18X0atI0MqitGBK6FOqHY9EaSqJFCH6U4\ntz/PDoyiCkU/4Tbi/6AjXkFbC5VQxV5ugNk1pFB8znhDAwuP+Za78bQz29XVwOCd\n0tCJ+K+++x6oB7O2jArmHvUW9ONzBpRa9wF+BrfMW89LtiSKy7hIW8FwtwKBgQCY\npjBKO7JUCMIfiTsmUlV9f2dIt921QSYoL4S6Z+d43zglEKbmqts8bs4SJgbBXRKi\nHdFvbdPEGvXb8VUHBWgvE561+jDSUwT4sRGZOXBBacVSCwEHPZuUvXfHABOl8UTY\nJ64umJ0dmkrU4Bz6UAAliUqb3QBMrGVDLfhHSHNM4QKBgFaqUHofExJXQuSN//2a\nHJAjFx+hoB8LD0JhkngkrRi6rFCkLY3ALmKFPHAQiAp8d8ib61GWdL2ufQ8WG0SF\nQNyDi6qZjIB2ZnPhYq+JPR230Pq6/CcSI++kdpasHjiyYZ/F2sEV1r1ANxPXI+mj\nyFFZdIbWMt6sEwEERWIQt1jo\n-----END PRIVATE KEY-----\n",
      "client_email": "docxon@appspot.gserviceaccount.com",
      "client_id": "108723900914703843085",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/docxon%40appspot.gserviceaccount.com"
    });
    var client =
        await auth.clientViaServiceAccount(credentials, Storage.SCOPES);

    var httpsUri = Uri.parse(link);
    var me = await client.get(httpsUri);
    String contentType = me.headers['content-type'] as String;
    final splitted = contentType.split('/');
    final exten = splitted[splitted.length - 1];
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    File filee = File(path.join(documentDirectory.path, '$fileName.$exten'));
    filee.writeAsBytes(me.bodyBytes);
    await OpenFile.open(filee.path);
  }

  _openFile(File file) async {
    OpenFile.open(file.path);
  }
}
