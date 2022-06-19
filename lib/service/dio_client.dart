import 'package:dio/dio.dart';
import 'package:dio_networking/model/user.dart';
import 'package:flutter/cupertino.dart';

class DioClient {

  final Dio _dio = Dio();
  final _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      debugPrint('User Info: ${userData.data}');
      User user = User.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response!.statusCode}');
       // debugPrint('DATA: ${e.response!.data}');
        debugPrint('HEADERS: ${e.response!.headers}');
      } else {
        // Error due to setting up or sending the request
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }

      return null;
    }

    return user;
  }
}
