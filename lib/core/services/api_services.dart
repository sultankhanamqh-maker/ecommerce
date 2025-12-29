import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/exception/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  dynamic getApi({required String url}) async {
    try {
      var res = await http.get(Uri.parse(url));
      return reResponse(res);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      print(e);
    }
  }

  postApi({required String url, Map<String, dynamic>? mBody}) async {
    Uri uri = Uri.parse(url);

    try {
      var res = await http.post(
        uri,
        body: mBody != null ? jsonEncode(mBody) : null,
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
