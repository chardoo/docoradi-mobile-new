// import 'dart:io';
// import 'package:DocXonApp/model/registration.dart';
// import 'package:flutter/material.dart';
// import '../../httpBaseInstances/dio_instance.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:dio/dio.dart';
// import '../model/Login.dart';
// import '../model/Registration.dart';

// Dio dio2 = Dio();

// class ApiWidget extends InheritedElement {
//   Registration registration = Registration.empty();

//   ApiWidget({Key? key, required Widget child}) : super(key: key, child: child);

//   static ApiWidget of(BuildContext context) {
//     return (context.dependOnInheritedWidgetOfExactType<ApiWidget>()
//         as ApiWidget);
//   }

//   Future<dynamic> loginUser(Login login) async {
//     try {
//       ///flutter/login testing endpoint
//       ///advent_user/login prod_endpoint
//       final response =
//           await dio.post("/advent_user/login", data: json.encode(login));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> decoded = response.data;
//         return decoded;
//       } else {
//         throw Exception();
//       }
//     } on SocketException catch (e) {
//       debugPrint("eSocket = " + e.toString());
//       throw Exception(e);
//     } catch (e) {
//       debugPrint("e = " + e.toString());
//       throw Exception(e);
//     }
//   }

//   Future<dynamic> signupPaypal(SignUpPaypal signUpPaypal) async {
//     bool isValidTransaction = signUpPaypal.hasTransactionId;
//     //  debugPrint("signup paypal users hit");
//     if (isValidTransaction) {
//       try {
//         ///signup/signupPaypal testing endpoint
//         ////advent_user/signup_with_paypal prod endpoint
//         final response = await dio.post("/advent_user/signup_with_paypal",
//             data: json.encode(signUpPaypal));

//         if (response.statusCode == 200) {
//           Map<String, dynamic> decoded = response.data;
//           _signupPaypal = SignUpPaypal.fromJson(decoded);
//           return _signupPaypal;
//         } else {
//           throw Exception("Unsuccessful signup");
//         }
//       } catch (e) {
//         throw Exception();
//       }
//     } else {
//       return Exception("Error happend");
//     }
//   }
// }
