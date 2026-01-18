import 'package:dio/dio.dart';

class ApiService{

  final Dio dio = Dio();
  static String baseUrl = "https://af.indevconsultancy.in/";
  static String login_url ="mobilelogin";

  Future<Map<String, dynamic>> loginApi(
      String username, String password) async{
    final response = await dio.post(baseUrl + login_url,
    data: {
      "username": username,
      "password": password,
    });
print('username $username');
print('response $response');
return response.data;

}
}