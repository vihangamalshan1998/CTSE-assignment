import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mobile/screens/Login/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

//user class
class User {
  final String userName;
  final String firstName;
  final String lastName;
  final String password;

  const User(
      {required this.userName,
      required this.firstName,
      required this.lastName,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['userName'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        password: json['password']);
  }
}

//http request
Future<User> addNewUser(
    String userName, String firstName, String lastName, String password) async {
  if (userName.isNotEmpty &&
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      password.isNotEmpty) {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8070/users/addUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "User Successfully Added!",
          //toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add this user.');
    }
  } else {
    throw Exception('Failed to add this user.');
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _controllerFirstName = TextEditingController();
    final TextEditingController _controllerLastName = TextEditingController();
    final TextEditingController _controllerUserName = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();
    return Background(
      child: SingleChildScrollView(
          child: Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
            SvgPicture.asset(
              "assets/images/login.svg",
              height: size.height * 0.2,
            ),
            TextFormField(
              controller: _controllerFirstName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'First Name : ',
                  labelText: 'First Name : ',
                  icon: const Icon(Icons.supervised_user_circle_rounded)),
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              autofocus: false,
              controller: _controllerLastName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'Last Name : ',
                  labelText: 'Last Name : ',
                  icon: const Icon(Icons.supervised_user_circle_rounded)),
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              autofocus: false,
              controller: _controllerUserName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'User Name : ',
                  labelText: 'User Name : ',
                  icon: const Icon(Icons.key)),
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              autofocus: false,
              obscureText: true,
              controller: _controllerPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'Password : ',
                  labelText: 'Password : ',
                  icon: const Icon(Icons.lock)),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addNewUser(
                      _controllerUserName.text,
                      _controllerFirstName.text,
                      _controllerLastName.text,
                      _controllerPassword.text);
                });
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('Register'),
            ),
          ]))),
    );
  }
}
