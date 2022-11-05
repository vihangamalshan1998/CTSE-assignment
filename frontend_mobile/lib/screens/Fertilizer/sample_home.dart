import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Fertilizer/fertilizers_screen.dart';

class SampleHomeScreen extends StatelessWidget {
  const SampleHomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/sampleHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FertilizersScreen(),
                  ),
                );
              },
              child: const Text('Fertilizer Screen'),
            )
          ],
        ),
      ),
    );
  }
}
