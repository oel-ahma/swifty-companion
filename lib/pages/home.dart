import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swifty_companion/config/theme.dart';
import 'package:swifty_companion/utils/debouncer.dart';
import 'package:swifty_companion/oauth/oauth42_service.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/src/widgets/user_card.dart';
import 'package:swifty_companion/models/users_list_item.dart';

final Auth42Service _authService = Auth42Service();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Debouncer _debouncer = Debouncer(milliseconds: 200);
  List<Widget> users = [];
  bool isLoading = false;
  String formLogin = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('swifty-companion'),
          // backgroundColor: const Color(0x1AFFFFFF),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              tooltip: "Logout",
              onPressed: () {
                _authService.logout(context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: TextField(
                  onChanged: (query) =>
                      _debouncer.run(() async => await getList(query)),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter a 42 login',
                  ),
                ),
              ),
            ),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : SingleChildScrollView(
                    child: users.length > 0
                        ? Column(
                            children: users,
                          )
                        : Center(
                            child: Text(error),
                          ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> getList(String? login) async {
    final String? token = await _authService.getStoredAccessToken();

    if (token != null) {
      setState(() {
        isLoading = true;
        error = '';
      });
      try {
        var response = await http.get(
            Uri.parse(
                'https://api.intra.42.fr/v2/users?filter[login]=${login}'),
            headers: {'Authorization': 'Bearer $token'});
        setState(() {
          users = _parse(response);
          if (users.isEmpty) {
            error = 'login not found';
          }
        });
      } catch (e) {
        // print(e);
        setState(() {
          if (formLogin.isNotEmpty) {
            error = 'unexpected error';
          }
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Navigator.pushNamed(context, '/signin');
    }
  }

  List<Widget> _parse(http.Response response) {
    List<dynamic> usersResponse = jsonDecode(response.body)
        .map((dynamic item) => UsersListItem.fromJson(item))
        .toList();
    return usersResponse
        .map((dynamic user) =>
            Column(children: [UserCard(user: user), const SizedBox(height: 8)]))
        .toList();
  }
}
