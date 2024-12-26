import 'package:flutter/material.dart';
import 'package:swifty_companion/config/theme.dart';
import 'package:swifty_companion/models/users_list_item.dart';

class UserCard extends StatelessWidget {
  final UsersListItem user;

  const UserCard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/profil', arguments: user.id),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 40, backgroundImage: NetworkImage(user.image.link)),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${user.displayName}',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    child: Text('${user.email}',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                        )),
                  ),
                  Container(
                    child: Text('${user.login}',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
