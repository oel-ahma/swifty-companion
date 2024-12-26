import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth42Service {
  String? clientId = dotenv.env['CLIENT_ID'];
  String? clientSecret = dotenv.env['CLIENT_SECRET'];
  String? redirectUri = dotenv.env['REDIRECT_URI'];
  final String authorizationEndpoint =
      'https://api.intra.42.fr/oauth/authorize';
  final String tokenEndpoint = 'https://api.intra.42.fr/oauth/token';

  final storage = FlutterSecureStorage();

  Future<String?> authenticate() async {
    print("Authentication started...");
    final url = Uri.parse('$authorizationEndpoint'
        '?client_id=$clientId'
        '&redirect_uri=$redirectUri'
        '&response_type=code'
        '&scope=public');
    print("URL ${url}");
    var result;
    try {
      result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'che.ma',
      );
    } catch (e) {
      print('exception: $e');
    }
    print('Authenticate Result : $result');
    final code = Uri.parse(result).queryParameters['code'];
    print('Code is $code');
    if (code != null) {
      return await _getToken(code);
    }
    return null;
  }

  Future<String?> _getToken(String code) async {
    final response = await http.post(
      Uri.parse(tokenEndpoint),
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'redirect_uri': redirectUri,
        'grant_type': 'authorization_code',
      },
    );

    print('response status code ${response.statusCode}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String accessToken = data['access_token'];
      await storage.write(key: 'access_token', value: accessToken);

      return accessToken;
    }
    return null;
  }

  Future<String?> getStoredAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'access_token');
    Navigator.pushReplacementNamed(context, "/signin");
  }
}
