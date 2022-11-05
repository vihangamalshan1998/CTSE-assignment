import 'package:flutter/material.dart';
import 'components/body.dart';
class Login extends StatelessWidget {
  static const String routeName='/login';
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      
    );
  }
}