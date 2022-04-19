import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import '../model/Document.dart';
import '../model/UploadedDocuments.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final String personaPostsURL =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/personalUploads";
  final String postsURL =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/initialDocuments";
  final String searchURL =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/search";
  final String postsURL1 =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/viewLater";
  final String postsURL2 =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/removeFromViewedList";
  final String postsURL3 =
      "https://docoradi-app-phrl5joxbq-uc.a.run.app/service/documents/markAsViewed";

  Future<List<Documents>> getDocuments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final res = await post(Uri.parse(postsURL),
    //     body: {'userId': prefs.getString('userId')});

    final res = await post(Uri.parse(postsURL),
        body: {'userId': prefs.getString('userId')});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Documents> documents = body
          .map(
            (dynamic item) => Documents.fromMap(item),
          )
          .toList();
      // print("heelo sup");
      // print(documents);
      return documents;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<UploadedDocuments>> getPersonalDocuments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //     body: {'userId': prefs.getString('userId')});

    final res1 = await post(Uri.parse(personaPostsURL),
        body: {'userId': prefs.getString('userId')});
    if (res1.statusCode == 200) {
      List<dynamic> body = jsonDecode(res1.body);

      List<UploadedDocuments> documents = body
          .map(
            (dynamic item) => UploadedDocuments.fromMap(item),
          )
          .toList();
      return documents;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Documents>> searchDocuments(String searchIndex) async {
    SharedPreferences preffdfs = await SharedPreferences.getInstance();
    // final res = await post(Uri.parse(postsURL),
    //     body: {'userId': prefs.getString('userId')});

    final searchresults = await post(Uri.parse(searchURL), body: {
      'userId': preffdfs.getString('userId'),
      'searchIndex': searchIndex
    });

    if (searchresults.statusCode == 200) {
      List<dynamic> body = jsonDecode(searchresults.body);

      List<Documents> documents = body
          .map(
            (dynamic item) => Documents.fromMap(item),
          )
          .toList();
      return documents;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<String> setAsViewLater(String documentId) async {
    print("about to make request");
    print(documentId);
    final res =
        await post(Uri.parse(postsURL1), body: {'objectID': documentId});
    print(res);
    if (res.statusCode == 200) {
      return 'ok';
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<String> removeAsViewLater(String documentId) async {
    final res =
        await post(Uri.parse(postsURL2), body: {'objectID': documentId});

    if (res.statusCode == 200) {
      return 'ok';
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<String> markAsViewed(String documentId) async {
    final res =
        await post(Uri.parse(postsURL3), body: {'objectID': documentId});

    if (res.statusCode == 200) {
      return 'ok';
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
