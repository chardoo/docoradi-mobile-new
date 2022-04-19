// import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';



class Uploads {
  String documentType = "";
  String description = "";
  String file = "";
  String filename = "";
  String mime = "";
  String userId = "";
  Uploads(
      this.documentType, this.description, this.file, this.filename, this.mime, this.userId);

  Uploads.empty() {
    documentType = "";
    description = "";
    filename = "";
    file = "";
    mime = "";
    userId = "";
  }

  //deserialization
  factory Uploads.fromJson(Map<String, dynamic> json) {
    return Uploads(
      json["documentType"] as String,
      json["description"] as String,
      json["file"] as String,
      json["filename"] as String,
      json["mime"] as String,
      json["userId"] as String,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "properties": {
        "fields": [
          {
            "name": "documentType",
            "value": documentType,
          },
          {
            "name": "description",
            "value": description,
          }
        ],
        "type": {"name": documentType, "namespace": 'dxdt'},
      },
      "account": {"id": userId, "type": "userId"},
      "document": {"filename": filename, "mime": mime, "file": file},
    };
    return map;
  }
}
