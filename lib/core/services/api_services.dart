import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/core/exception/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  dynamic getApi({
    required String url,
    Map<String, String>? mHeader,
    bool isLoginRegister = false,
  }) async {
    if (!isLoginRegister) {
      mHeader ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(AppConstants.tokenLoginKey) ?? "";
      mHeader["Authorization"] = "Bearer $token";
    }
    try {
      var res = await http.get(Uri.parse(url), headers: mHeader);

      return reResponse(res);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? mBody,
    Map<String, String>? mHeader,
    bool isLoginRegister = false,
  }) async {
    Uri uri = Uri.parse(url);
    if (!isLoginRegister) {
      mHeader ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(AppConstants.tokenLoginKey) ?? "";
      mHeader["Authorization"] = "Bearer $token";
    }

    try {
      var res = await http.post(
        uri,
        body: mBody != null ? jsonEncode(mBody) : null,
        headers: mHeader
      );
      return reResponse(res);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      print(e);
    }
  }

  dynamic reResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var data = jsonDecode(response.body);
          return data;
        }
      case 400:
        {
          throw BadRequestException(
            msg: "With Status Code ${response.statusCode}",
          );
        }
      case 401:
        {
          throw UnauthorizedException(
            msg: "With Status Code ${response.statusCode}",
          );
        }
      case 404:
        {
          throw NotFoundException(
            msg: "With Status Code  ${response.statusCode}",
          );
        }
      case 500:
      default:
        {
          throw ServerException(msg: "With Status Code ${response.statusCode}");
        }
    }
  }
}
