import 'package:flutter/material.dart';
import 'package:swifty_companion/oauth/oauth42_service.dart';
import 'package:swifty_companion/src/widgets/login_button.dart';

final Auth42Service _authService = Auth42Service();

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String error = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      verifyTokenAndGetUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white10,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 120,
                child: LoginButton(),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Text(
                'swifty_companion - oel-ahma',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            )
          ],
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
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }
}
