import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthClient {
  final String baseUrl;
  final http.Client httpClient;

  AuthClient({required this.baseUrl, http.Client? client})
    : httpClient = client ?? http.Client();

  Future<String?> login(String email, String password) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    return data['token'];
  }

  Future<void> logout(String token) async {
    await httpClient.post(
      Uri.parse("$baseUrl/auth/logout"),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
