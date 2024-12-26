import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/oauth/oauth42_service.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final Auth42Service _authService = Auth42Service();
  String? error;

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() {
      error = null;
    });
    String? accessToken = await _authService.authenticate();
    if (accessToken != null) {
      Navigator.pushNamed(context, '/');
    } else {
      setState(() {
        error = 'Sign in failed: network error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async => _handleSignIn(context),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  maximumSize: Size.fromHeight(80),
                  shadowColor: Colors.white12,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  side: const BorderSide(
                    width: 0.5,
                    color: Colors.white12,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LOGIN',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            // height: ,
                            color: Colors.white)),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('with',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.white))
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/42_logo_api.svg',
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 35,
                    )
                  ],
                ),
              ),
              if (error != null)
                Center(
                    child: Text(
                  error as String,
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ))
            ],
          )),
    );
  }
}
