// import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:frontend_mobile/providers/fertilizer_provider.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseAdd.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseView.dart';
import 'package:frontend_mobile/screens/Flower/AddFlower.dart';
import 'package:frontend_mobile/screens/Flower/ViewFlowers.dart';
import 'package:frontend_mobile/screens/Fertilizer/fertilizers_screen.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:frontend_mobile/screens/SignUp/signup.dart';
import 'package:frontend_mobile/screens/Welcome/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Fertilizers()),
        ChangeNotifierProvider.value(value: Fertilizer('', '', '', '', '')),
      ],
      child: MaterialApp(
        title: 'My Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: Login.routeName,
        routes: {
          AddFlower.routeName: (context) => const AddFlower(),
          Login.routeName: (context) => const Login(),
          Signup.routeName: (context) => const Signup(),
          Welcome.routeName: (context) => const Welcome(),
          ViewFlowers.routeName: (context) => const ViewFlowers(),
          DiseaseView.routeName: (context) => const DiseaseView(),
          DiseaseAdd.routeName: (context) => const DiseaseAdd()
        },
      ),
    );
  }
}
