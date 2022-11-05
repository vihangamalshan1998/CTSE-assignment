import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Flower/AddFlower.dart';
import 'package:frontend_mobile/screens/Welcome/welcome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Fertilizer/fertilizers_screen.dart';

List<Flowers> postFromJson(String str) =>
    List<Flowers>.from(json.decode(str).map((x) => Flowers.fromMap(x)));

// Flower class
class Flowers {
  Flowers({
    required this.flowerName,
    required this.commonNames,
    required this.description,
  });

  String flowerName;
  String commonNames;
  String description;

  factory Flowers.fromMap(Map<String, dynamic> json) => Flowers(
        flowerName: json["flowerName"],
        commonNames: json["commonNames"],
        description: json["description"],
      );
}

//Fetch flower details
Future<List<Flowers>> fetchFlowers() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8070/flowers/allFlowers'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Flowers>((json) => Flowers.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

//delete flowers
Future<http.Response> deleteFlower(String flowerName) async {
  final http.Response response = await http.delete(
    Uri.parse('http://127.0.0.1:8070/flowers/deleteName/$flowerName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}

class ViewFlowers extends StatefulWidget {
  static const String routeName = '/viewFlowers';
  const ViewFlowers({Key? key}) : super(key: key);

  @override
  State<ViewFlowers> createState() => _ViewState();
}

class _ViewState extends State<ViewFlowers> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context).pushNamed(Welcome.routeName);
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FertilizersScreen(),
          ),
        );
        //route --> Jonty
      } else if (_selectedIndex == 3) {
        //route --> Janith
      }
    });
  }

  late Future<List<Flowers>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchFlowers();
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'All Flowers';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('All Flowers'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddFlower.routeName);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Flowers>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                // ignore: avoid_unnecessary_containers
                itemBuilder: (_, index) => Container(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 222, 248, 187),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.asset(
                              'assets/images/one.jpg',
                              fit: BoxFit.cover,
                              height: 700,
                            ),
                          ),
                        ),
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${snapshot.data![index].flowerName}",
                          // ignore: prefer_const_constructors
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // ignore: unnecessary_string_interpolations
                        Text(
                          "${snapshot.data![index].commonNames}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 22, 22, 22),
                          ),
                        ),
                        // ignore: unnecessary_string_interpolations
                        Text("${snapshot.data![index].description}",
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 138, 137, 135),
                            )),
                        Container(
                          padding:
                              const EdgeInsets.only(left: 150.0, top: 20.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Update screen
                            ElevatedButton(
                              child: const Text('View Data'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DetailScreen(),
                                    // Pass the arguments as part of the RouteSettings. The
                                    // DetailScreen reads the arguments from these settings.
                                    settings: RouteSettings(
                                      arguments: snapshot.data![index],
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 230, 196, 49),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0)),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 150.0, top: 20.0),
                            ),

                            // Delete button
                            ElevatedButton(
                              child: const Text('Delete Data'),
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewFlowers()));
                                  futurePost = deleteFlower(
                                          snapshot.data![index].flowerName)
                                      as Future<List<Flowers>>;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 240, 97, 97),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Flowers',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Fertilizers',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Disease',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

// Update screen
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final flowers = ModalRoute.of(context)!.settings.arguments as Flowers;
    final TextEditingController _controller = TextEditingController();
    final TextEditingController _commonNames = TextEditingController();
    final TextEditingController _description = TextEditingController();
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(flowers.flowerName),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                  ),
                  const Image(
                    image: AssetImage("assets/images/update.png"),
                    alignment: Alignment.topRight,
                    height: 200,
                    width: 250,
                  ),
                  Text("Update Flower",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 30,
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
                      fillColor: const Color.fromARGB(255, 159, 223, 207),
                      filled: true,
                      labelText: flowers.flowerName,
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
                      fillColor: const Color.fromARGB(255, 159, 223, 207),
                      filled: true,
                      labelText: flowers.commonNames,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                  ),
                  TextFormField(
                    controller: _description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      fillColor: const Color.fromARGB(255, 159, 223, 207),
                      filled: true,
                      labelText: flowers.description,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text("Update Flower"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewFlowers()));
                          updateFlower(flowers.flowerName, _commonNames.text,
                              _description.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewFlowers()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 228, 198, 27),
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 50.0)),
                      )),
                ])));
  }
}

Future<Flowers> updateFlower(
    String flowerName, String commonNames, String description) async {
  final response = await http.put(
    Uri.parse('http://127.0.0.1:8070/flowers/updateFlower/$flowerName'),
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
      msg: "Flower Updated Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    return Flowers.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create flower.');
  }
}
