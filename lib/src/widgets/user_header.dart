import 'package:swifty_companion/models/user.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final User user;
  const UserHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.imageLink),
            radius: 90,
          ),
          SizedBox(height: 16), // Spacing between avatar and name
          Text(
            user.fullName,
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          SizedBox(height: 16), // Spacing between name and details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User Information Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.login,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8), // Spacing between entries
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16), // Spacing between user info and points
              // Points Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correction Points:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.correctionPoint.toString(),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8), // Spacing between entries
                    Text(
                      'Level:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user.level.toString(),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
