import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Disease/modle/Disease.dart';
import 'package:frontend_mobile/screens/Disease/service/DiseaseService.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseView.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseAdd extends StatelessWidget {
  static const String routeName = '/addDisease';
  const DiseaseAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Create a Disease';
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
                Navigator.of(context).pushNamed(DiseaseView.routeName);
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
  final TextEditingController _diseaseName = TextEditingController();
  final TextEditingController _antidote = TextEditingController();
  final TextEditingController _description = TextEditingController();
  late Disease res;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                // Here the height of the container is 45% of our total height
                height: size.height,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(172, 242, 247, 204),
                ),
              ),
              SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Image(
                            image: AssetImage("assets/images/d2.png"),
                            alignment: Alignment.topRight,
                            height: 200,
                            width: 250,
                          ),
                          Text("Create a Disease",
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              )),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 150.0, top: 20.0),
                          ),
                          TextFormField(
                            controller: _diseaseName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter the disease Name',
                              labelText: 'Enter the disease Name',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 7, 0, 0)),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 7, 7)),
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 150.0, top: 20.0),
                          ),
                          TextFormField(
                            controller: _antidote,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 7, 0, 0)),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 7, 7)),
                              hintText: 'Enter the antidote',
                              labelText: 'Enter the antidote',
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 150.0, top: 15.0),
                          ),
                          TextFormField(
                            controller: _description,
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter the Disease description',
                              labelText: 'Enter the Disease description',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 7, 0, 0)),
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 7, 7)),
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 150.0, top: 15.0),
                          ),
                          Container(
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: const Text("Create Disease"),
                                onPressed: () {
                                  setState(() {
                                    //Check empty fields
                                    if (_diseaseName.text.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: " Form fields cannot be empty ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1000,
                                        backgroundColor: const Color.fromARGB(
                                            255, 240, 110, 10),
                                        textColor:
                                            const Color.fromARGB(255, 7, 7, 7),
                                        fontSize: 16.0,
                                      );
                                    } else {
                                      DiseaseService().addDisease(
                                          _diseaseName.text,
                                          _antidote.text,
                                          _description.text);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DiseaseView()));
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 247, 231, 19),
                                    onPrimary:
                                        const Color.fromARGB(255, 8, 8, 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 50.0)),
                              )),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
