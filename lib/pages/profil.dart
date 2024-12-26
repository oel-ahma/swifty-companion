import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swifty_companion/oauth/oauth42_service.dart';
import 'package:swifty_companion/src/widgets/project_list.dart';
import 'package:swifty_companion/src/widgets/skill_list.dart';
import 'package:swifty_companion/src/widgets/user_header.dart';
import 'package:swifty_companion/models/user.dart';
import 'package:http/http.dart' as http;

final Auth42Service _authService = Auth42Service();

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late User user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      verifyTokenAndGetUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      UserHeader(user: user),
                      SizedBox(height: 16),
                      if (user.projects.isNotEmpty)
                        ProjectList(projects: user.projects),
                      if (user.projects.isNotEmpty) SizedBox(height: 16),
                      if (user.skills.isNotEmpty)
                        SkillList(skills: user.skills),
                      if (user.skills.isNotEmpty) SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> verifyTokenAndGetUser() async {
    try {
      final token = await _authService.getStoredAccessToken();

      if (token == null || token.isEmpty) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
          return;
        }
      }
      await getUser();
    } catch (e) {
      print('Error verifying token: $e');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });
    final int userId = ModalRoute.of(context)!.settings.arguments as int;
    try {
      final String? token = await _authService.getStoredAccessToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse('https://api.intra.42.fr/v2/users/$userId'),
            headers: {'Authorization': 'Bearer $token'});
        setState(() {
          user = User.fromJson(jsonDecode(response.body));
        });
      } else {
        Navigator.pushNamed(context, '/signin');
      }
    } catch (e) {
      print("Error $e");
      Navigator.pushNamed(context, '/signin');
      //handleError
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
