import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClient {
  final String baseUrl;
  final http.Client httpClient;
  final FlutterSecureStorage storage;

  AuthClient({required this.baseUrl, http.Client? client})
    : httpClient = client ?? http.Client(),
      storage = FlutterSecureStorage();

  Future<int> login(String email, String password) async {
    Future.wait([
      storage.write(key: 'email', value: email),
      storage.write(key: 'password', value: password),
    ]);

    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) return response.statusCode;

    final data = jsonDecode(response.body);
    await storage.write(key: 'jwt', value: data['token']);
    return 200;
  }

  Future<int> signup(String email, String password) async {
    Future.wait([
      storage.write(key: 'email', value: email),
      storage.write(key: 'password', value: password),
    ]);

    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response.statusCode;
  }

  Future<void> validateEmail(String email) async {
    await httpClient.post(
      Uri.parse('$baseUrl/auth/validate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  Future<String?> getJwt() async {
    return await storage.read(key: 'jwt');
  }

  Future<bool> verifyEmail(String email, String code) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/auth/validate/$code'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    final data = jsonDecode(response.body);

    await storage.write(key: 'jwt', value: data['token']);

    return response.statusCode == 200;
  }

  Future<({String email, String password})> getUser() async {
    final password = await storage.read(key: 'password');
    final email = await storage.read(key: 'email');
    if (email == null || password == null) throw Exception();
    return (email: email, password: password);
  }

  Future<void> logout(String token) async {
    await storage.delete(key: 'jwt');
  }

  Future<dynamic> getGenericUrl(String url) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/$url'));

    return jsonDecode(response.body);
  }
}
