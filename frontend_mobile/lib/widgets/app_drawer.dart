import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: mediaQuery.padding.top + 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(mediaQuery.size.width * 0.8),
                    child: Image.network(
                      'https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png',
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Colors.white),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                'Flowers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Fertilizers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Deasease',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: mediaQuery.size.height * 0.35),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
