import '../services/api_service.dart';

class AuthRepository{

  final ApiService apiService;


  AuthRepository(this.apiService);


  Future<String> login(String username, String password) async {
    final response = await apiService.loginApi(username, password);

    final status = response['status'];

    if (status == true || status == "success") {
      return response['message'] ?? "Login successful";
    } else {
      throw Exception(response['message'] ?? "Login failed");
    }
  }
}