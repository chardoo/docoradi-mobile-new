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
