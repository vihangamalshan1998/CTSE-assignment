import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Flower/ViewFlowers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// Add Flower
Future<Flowers> addFlower(
    String flowerName, String commonNames, String description) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8070/flowers/addFlower'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'flowerName': flowerName,
      'commonNames': commonNames,
      'description': description
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    Fluttertoast.showToast(
      msg: "Flower Added Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    return Flowers.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create flower.');
  }
}

//Flower class
class Flowers {
  final String flowerName;
  final String commonNames;
  final String description;

  const Flowers(
      {required this.flowerName,
      required this.commonNames,
      required this.description});

  factory Flowers.fromJson(Map<String, dynamic> json) {
    return Flowers(
      flowerName: json['flowerName'],
      commonNames: json['commonNames'],
      description: json['description'],
    );
  }
}

class AddFlower extends StatelessWidget {
  static const String routeName = '/addFlower';
  const AddFlower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add a Flower';
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ViewFlowers.routeName);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ],
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commonNames = TextEditingController();
  final TextEditingController _description = TextEditingController();
  late Flowers res;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height,
            decoration: const BoxDecoration(
              color: Color.fromARGB(172, 247, 225, 30),
              image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage("assets/images/x.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Image(
                    image: AssetImage("assets/images/mal.png"),
                    alignment: Alignment.topRight,
                    height: 200,
                    width: 250,
                  ),
                  Text("Add a Flower",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter the flower Name',
                      labelText: 'Enter the flower Name',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                  ),
                  TextFormField(
                    controller: _commonNames,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter the common names',
                      labelText: 'Enter the common names',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 15.0),
                  ),
                  TextFormField(
                    controller: _description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter the flower description',
                      labelText: 'Enter the flower description',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 15.0),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text("Add Flower"),
                        onPressed: () {
                          setState(() {
                            //Check empty fields
                            if (_commonNames.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Cannot leave empty fields')),
                              );
                            } else {
                              addFlower(_controller.text, _commonNames.text,
                                  _description.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewFlowers()));
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 244, 54, 143),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0)),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
