import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Welcome/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:frontend_mobile/screens/SignUp/signup.dart';
import 'background.dart';

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

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void userLogin(String userName, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8070/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': _controllerUserName.text,
        'password': _controllerPassword.text
      }),
    );
    final String content = utf8.decode(response.body.runes.toList());
    dynamic data = jsonDecode(content);
    if (data.isNotEmpty) {
      Fluttertoast.showToast(
          msg: ("${User.fromJson(data[0]).userName} login successfully!"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Welcome(uName: User.fromJson(data[0]).userName)));
    } else {
      Fluttertoast.showToast(
          msg: ("${_controllerUserName.text} login faild!"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            SvgPicture.asset(
              "assets/images/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              controller: _controllerUserName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'Username',
                  labelText: 'Username',
                  icon: const Icon(Icons.verified_user)),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              autofocus: false,
              obscureText: true,
              // validator: (value)=>value.isEmpty?'Please enter password':null,
              controller: _controllerPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'Password',
                  labelText: 'Password',
                  icon: const Icon(Icons.lock)),
            ),
            // IconButton(
            //   onPressed: (){
            //     Navigator.of(context).pushNamed(Signup.routeName);
            //   },
            //   icon: const Icon(
            //     Icons.app_registration_rounded,
            //     ),
            // ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userLogin(_controllerUserName.text, _controllerPassword.text);
                });
                // Navigator.of(context).pushNamed(Signup.routeName);
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Signup.routeName),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 166, 124, 235),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                'Create New Account',
                style: TextStyle(color: Colors.white),
              ),
            )
          ])),
    );
  }
}
