import 'package:dio/dio.dart';

/*If you're running the server locally and using the Android emulator, 
then your server endpoint should be 10.0.2.2:8000 instead of localhost:8000 as 
AVD uses 10.0.2.2 as an alias to your host loopback interface (i.e) localhost*/

var localOptions = BaseOptions(
    baseUrl: 'https://docoradi-app-phrl5joxbq-uc.a.run.app',
    connectTimeout: 60 * 1000, // 60 seconds
    receiveTimeout: 60 * 1000 // 60 seconds
    );

// var localOptions2 = BaseOptions(
//     baseUrl: 'https://docxon-service-app-phrl5joxbq-uc.a.run.app',
//     connectTimeout: 60 * 1000, // 60 seconds
//     receiveTimeout: 60 * 1000 // 60 seconds
//     );

//switch to either local or remote depending on where
//you're retrieving your data from
Dio dio = Dio(localOptions);
// Dio dio2 = Dio(localOptions2);
