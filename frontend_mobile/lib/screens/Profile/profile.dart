import 'dart:async';
import 'dart:convert' show jsonDecode, jsonEncode, utf8;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Login/login.dart';
import 'package:frontend_mobile/screens/Welcome/welcome.dart';
import 'package:http/http.dart' as http;
//user class
class User{
  final String userName;
  final String firstName;
  final String lastName;
  final String password;

  const User({required this.userName, required this.firstName, required  this.lastName, required this.password});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password']
    );
  }
}

//http request for get user details
Future<User> fetchUser(String uName) async{
  final response = await http
      .get(Uri.parse('http://localhost:8070/users/getUser/$uName'));

    if (response.statusCode == 200) {
      final String content =  utf8.decode(response.body.runes.toList());
      dynamic data = jsonDecode(content);
      return User.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg: "failed to fetch!",
          //toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw Exception('Failed to load user');
    }
}
class Profile extends StatefulWidget {
  static const String routeName='/profile';
  final String? uName;
  const Profile({ Key? key, required this.uName, }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Profile> {
  late Future<User> futureUser;
  bool res =false;
  Future updateUser(String userName, String firstName, String lastName, String password) async{
    final response = await http.put(
      Uri.parse('http://localhost:8070/users/update/$userName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName':lastName,
        'password':password
      }),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Details Successfully Updated!",
          //toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => Welcome(uName:userName)));
    } else {
      throw Exception('Failed to add this user.');
    }
  }
  Future deleteUser(String userName) async{
    final response = await http.delete(
      Uri.parse('http://localhost:8070/users/delete/$userName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      }),
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Account Successfully Deleted!",
          //toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pushNamed(Login.routeName);
    } else {
      throw Exception('Failed to add this user.');
    }
  }
  void logOut(){
      Navigator.of(context).pushNamed(Login.routeName);
  }
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser(widget.uName ?? '');
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _controllerFirstName = TextEditingController();
    final TextEditingController _controllerLastName = TextEditingController();
    final TextEditingController _controllerUserName = TextEditingController();
    final TextEditingController _controllerPassword = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Stack(
            children: <Widget> [
              const Align(
                alignment: Alignment.topLeft,
                child:Text("Profile Details")
              ),
              Align(
                alignment: Alignment.topRight,
                child:ElevatedButton(
                  onPressed: logOut,
                  child: const Icon(Icons.logout),
                ), 
              )
              
            ],
          )
        ),

        body: Center(
          child: FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {//Text(snapshot.data!.userName);
                _controllerUserName.text = snapshot.data!.userName;
                _controllerFirstName.text = snapshot.data!.firstName;
                _controllerLastName.text = snapshot.data!.lastName;
                _controllerPassword.text = snapshot.data!.password;
                // ignore: unnecessary_new
                return Column(
                  children:  <Widget>[
                    Positioned(
                      top: 5,
                      left: 0,
                      child: Image.asset(
                        "assets/images/profilePic.png",
                        height: 200,
                      ),
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
                        hintText: 'User Name : ',  
                        labelText: 'User Name : ',  
                        icon: const Icon(Icons.supervised_user_circle_rounded)
                      ), 
                    ),
              
                    SizedBox(height: size.height * 0.03),
                    
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
                        icon: const Icon(Icons.supervised_user_circle_rounded)
                      ), 
                    ),
              
                    SizedBox(height: size.height * 0.03),

                    TextFormField(
                      controller: _controllerLastName,
                      decoration: InputDecoration( 
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        hintText: 'Last Name : ',  
                        labelText: 'Last Name : ',  
                        icon: const Icon(Icons.supervised_user_circle_rounded)
                      ), 
                    ),
              
                    SizedBox(height: size.height * 0.03),

                    Align(
                      alignment: Alignment.bottomRight,
                      child:FloatingActionButton(
                        onPressed: ()=> updateUser(_controllerUserName.text,_controllerFirstName.text, _controllerLastName.text, _controllerPassword.text),
                        child: const Icon(Icons.update),
                      )
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:ElevatedButton(
                        onPressed: ()=> deleteUser(_controllerUserName.text),
                        style: ElevatedButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                        child: const Text('Deactivate Account',style: TextStyle(
                          color: Colors.red
                        ),),
                      ), 
                    ),
                  ]
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}