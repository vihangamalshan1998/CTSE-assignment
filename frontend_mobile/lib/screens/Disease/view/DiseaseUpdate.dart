// Update screen
import 'package:flutter/material.dart';
import 'package:frontend_mobile/screens/Disease/modle/Disease.dart';
import 'package:frontend_mobile/screens/Disease/service/DiseaseService.dart';
import 'package:frontend_mobile/screens/Disease/view/DiseaseView.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseUpdate extends StatefulWidget {
  DiseaseUpdate(this.disease, {Key? key}) : super(key: key);

  final Disease disease;

  @override
  State<DiseaseUpdate> createState() => _DiseaseUpdateState();
}

class _DiseaseUpdateState extends State<DiseaseUpdate> {
  final TextEditingController _diseaseName = TextEditingController();

  final TextEditingController _antidote = TextEditingController();

  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    _diseaseName.text = widget.disease.diseaseName;
    _antidote.text = widget.disease.antidote;
    _description.text = widget.disease.description;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _antidote.dispose();
    _description.dispose();
    _description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.disease.diseaseName),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                      ),
                      const Image(
                        image: AssetImage("assets/images/d2.png"),
                        alignment: Alignment.topRight,
                        height: 200,
                        width: 250,
                      ),
                      Text("Update Disease Data",
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          )),
                      Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                      ),
                      TextFormField(
                        controller: _diseaseName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(172, 242, 247, 204),
                          filled: true,
                          labelText: "Enter the disease Name",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 7, 0, 0)),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 7, 7)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                      ),
                      TextFormField(
                        controller: _antidote,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(172, 242, 247, 204),
                          filled: true,
                          labelText: "Enter the Disease antidote",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 7, 0, 0)),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 7, 7)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 20.0),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: _description,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(172, 242, 247, 204),
                          filled: true,
                          labelText: "Enter the Disease description",
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 7, 0, 0)),
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 7, 7)),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            child: const Text("Update Disease"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DiseaseView()));
                              DiseaseService().updateDisease(
                                  widget.disease.id,
                                  _diseaseName.text,
                                  _antidote.text,
                                  _description.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DiseaseView()));
                            },
                            style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 228, 198, 27),
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 50.0)),
                          )),
                    ]),
              ))),
    );
  }
}
