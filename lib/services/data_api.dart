import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uploaduser/models/data.dart';

class PhotosApi {
  late Response response;
  Dio dio = new Dio();

  getPhotos(
    int page,
  ) async {
    response = await dio.get("https://dummyapi.io/data/v1/user?limit=$page",
        options: Options(headers: {'app-id': '6149ac924e29ce2338d6f836'}));
    //print(response.data);
    return response.data;
  }
}

Future userInformation(id) async {
  var headers = {
    'app-id': '6149ac924e29ce2338d6f836',
    // 'Accept': 'application/json',
    // "Content-Type": 'application/x-www-form-urlencoded'
  };
  var url = Uri.parse("https://dummyapi.io/data/v1/user/$id");

  var data = await http.get(url, headers: headers);

  if (data.statusCode == 200) {
    var utfDecode = utf8.decode(data.bodyBytes);
    var response = json.decode(utfDecode);
    print(response);
    return response;
  } else {
    // print(data.statusCode.toString());
  }
}

Future login(username, password) async {
  Map<String, String> body = {
    'username': username,
    'password': password,
  };
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  };
  var url = Uri.parse('https://reqres.in/api/login');
  var data = await http.post(url, body: body, headers: headers);
  if (data.statusCode == 200 || data.statusCode == 201) {
    var utfDecode = utf8.decode(data.bodyBytes);
    var response = json.decode(utfDecode);
    return response;
  } else {
    print(data.body);
  }
}

class DataApi {
  static DataApi? _instance;

  DataApi._();

  static DataApi? get instance {
    if (_instance == null) {
      _instance = DataApi._();
    }
    return _instance;
  }

  Future<List<userDetails>> getAllUser(id) async {
    var url =
        Uri.parse('https://dummyapi.io/data/v1/user/6149ac924e29ce2338d6f836');
    final getUser = await http.get(url, headers: {
      "app-id": "6149ac924e29ce2338d6f836",
      // 'Content-type': 'application/json',
      // 'Accept': 'application/json',
    });
    final List responseBody = jsonDecode(getUser.body);
    print(responseBody);
    return responseBody.map((e) => userDetails.fromJson(e)).toList();
  }
}
