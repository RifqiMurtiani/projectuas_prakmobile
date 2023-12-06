import 'package:dio/dio.dart';
import 'package:modul7/model/reqresuser.dart';

Future<ReqresUser> getReqresUser(String id) async {
  Response response = await Dio().get('https://reqres.in/api/users/' + id);
  // final data = response.data;
  // print(data);
  return ReqresUser.fromJson(response.data);
}