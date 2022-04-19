import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_application_1/components/';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import '../../model/Uploads.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';
// import '../../httpBaseInstances/dio_instance.dart';
import 'dart:typed_data';
import '../screens/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UploadsUtil extends StatefulWidget {
  @override
  _UploadsUtils createState() => _UploadsUtils();
}

class _UploadsUtils extends State<UploadsUtil> {
  final _formKey = GlobalKey<FormState>();
  final uploadsModel = Uploads('', '', '', '', '','');

  late String fileName;
  late String path;
  late Map<String, String> paths;
  late List<String> extensions;
  late bool isLoadingPath = false;
  late bool isMultiPick = false;
  late FileType fileType;
  // Dio dio1 = new Dio();
// void _openFileExplorer() async {
//     setState(() => isLoadingPath = true);
//     try {
     
//         path = await FilePicker.getFilePath(type: fileType? fileType: FileType.any, allowedExtensions: extensions);
//         paths = null;
     
//     }
//     on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     }
//     if (!mounted) return;
//     setState(() {
//       isLoadingPath = false;
//       fileName = path != null ? path.split('/').last : paths != null
//             ? paths.keys.toString() : '...';
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Back'),
          backgroundColor: Color.fromARGB(255, 24, 21, 22),
        ),
        body: Column(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload Documents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 245, 241, 242),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Raleway'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF8A3324), width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF8A3324), width: 2)),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 250, 250, 250),
                                  focusColor: Color(0xFF800020),
                                  hintText: 'Document Type',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 173, 167, 169),
                                  )),
                              onChanged: (value) {
                                uploadsModel.documentType = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the the type of document';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF8A3324), width: 2)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Color(0xFF8A3324), width: 2)),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 250, 250, 250),
                                  focusColor: Color(0xFF800020),
                                  hintText: 'Description',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 173, 167, 169),
                                  )),
                              onChanged: (value) {
                                // RegistrationModel.lastName = value;
                                uploadsModel.description = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'short note about the document';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  // print('results');
                                  // print(result);
                                  uploadsModel.filename =
                                      result.files.first.name as String;
                                  String filePath =
                                      result.files.first.path as String;
                                  uploadsModel.mime =
                                      lookupMimeType(filePath) as String;

                                 
                        SharedPreferences preffdfs = await SharedPreferences.getInstance();
                           uploadsModel.userId = preffdfs.getString('userId') as String;





                                  File file = File(filePath);
                                  // String mime
                                  //  Stream<String> lines = file
                                  //       .openRead()
                                  //       .transform(utf8.decoder);

                                  Uint8List fileInByte =
                                      await file.readAsBytes();
                                  uploadsModel.file = base64.encode(fileInByte);
                                }
                              },
                              child: Text(
                                'Select file',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Color(0xFF800020),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xFF800020),
                                  child: Center(
                                    child: MaterialButton(
                                        minWidth: 23,
                                        child: Text(
                                          'Upload',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Uplaoding a document Acount')),
                                            );

                                            print(uploadsModel.mime);
                                            uploadDocuments();
                                            // register();
                                          }
                                        }),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ));
  }

  Future<dynamic> uploadDocuments() async {
    // debugPrint("login users hit");
    try {
      var localOptions2 = BaseOptions(
        baseUrl: 'https://docxon-service-app-phrl5joxbq-uc.a.run.app',
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000,
        headers: {
          HttpHeaders.acceptHeader: "accept: application/json",
        }, // 60 seconds
      );
      Dio dio2 = Dio(localOptions2);
      print("sending data");
      // final String postsURL =
      //     "https://docxon-service-app-phrl5joxbq-uc.a.run.app/service/docxon/";
      print(uploadsModel.toJson());
      final response = await dio2.post("/service/docxon/personal",
          data: uploadsModel.toJson());

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }

      // if (response?.status = "Ok") {
      //   print("the document sent succefully");
      // } else {
      //   throw Exception();
      // }
    } on SocketException catch (e) {
      debugPrint("eSocket = " + e.toString());
      throw Exception(e);
    } catch (e) {
      debugPrint("e = " + e.toString());
      throw Exception(e);
    }
  }
}
