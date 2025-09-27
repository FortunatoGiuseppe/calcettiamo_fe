import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  //final String baseUrl = "http://localhost:8080/api";
  final String baseUrl = "http://172.20.10.2:8080/api";

  Future<String> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body; // es: token o messaggio
    } else {
      throw Exception("Errore: ${response.body}");
    }
  }

  Future<String> register(
    String email,
    String name,
    String surname,
    String password,
    String role,
  ) async {
    final url = Uri.parse("$baseUrl/register");
    final body = jsonEncode({
      "email": email,
      "name": name,
      "surname": surname,
      "password": password,
      "role": role,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Errore: ${response.body}");
    }
  }
}
