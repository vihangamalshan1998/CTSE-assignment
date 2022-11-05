import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseView.dart';
import 'package:frontend_mobile/screens/Flower/ViewFlowers.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:frontend_mobile/screens/Profile/profile.dart';

import '../Fertilizer/fertilizers_screen.dart';

class Welcome extends StatefulWidget {
  static const String routeName = '/welcome';
  final String? uName;
  const Welcome({Key? key, this.uName}) : super(key: key);
  @override
  State<Welcome> createState() => WelcomeBody();
}

class WelcomeBody extends State<Welcome> {
  // bottom nav bar
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.of(context).pushNamed(ViewFlowers.routeName);
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FertilizersScreen(),
          ),
        );
        //route --> Jonty
      } else if (_selectedIndex == 3) {
        Navigator.of(context).pushNamed(DiseaseView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Stack(
        children: <Widget>[
          const Align(alignment: Alignment.topLeft, child: Text("Dashboard")),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              uName: widget.uName,
                            ))),
                icon: const Icon(Icons.account_circle_outlined,
                    color: Colors.white),
              ))
        ],
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            const Align(
              child: Text(
                'Flowers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Align(
                child: Image.asset(
              'assets/images/flower1.jpg',
              height: 150,
              width: 250,
            )),
            SizedBox(height: size.height * 0.03),
            const Align(
              child: Text(
                'Will be able to find 1000 of flowers here.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            const Align(
              child: Text(
                'Fertilizers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Align(
                child: Image.asset(
              'assets/images/fertilizing-flowers.jpg',
              height: 150,
              width: 250,
            )),
            SizedBox(height: size.height * 0.03),
            const Align(
              child: Text(
                'Will be able to find 1000 of fertilizers here.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            const Align(
              child: Text(
                'Diseases',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Align(
                child: Image.asset(
              'assets/images/Diseases.jpg',
              height: 150,
              width: 250,
            )),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Click to learn about diseases here.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist_rounded),
            label: 'Flowers',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_rounded),
            label: 'Fertilizers',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus),
            label: 'Disease',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
