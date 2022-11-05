//Fetch flower details
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend_mobile/screens/Disease/modle/Disease.dart';
import 'package:http/http.dart' as http;

class DiseaseService {
  // static const baseUrl = "http://10.0.2.2:8070/diseases/api/v1/";
  static const baseUrl = "http://127.0.0.1:8070/diseases/api/v1/";

  Future<List<Disease>> getAllDisease() async {
    final response = await http.get(Uri.parse(baseUrl + "findAllDiseases"));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Disease>((json) => Disease.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  //delete Disease
  Future<http.Response> deleteDisease(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(baseUrl + 'delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Disease Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color.fromARGB(255, 253, 3, 3),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return response;
  }

  Future<Disease> addDisease(
      String diseaseName, String antidote, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'add-disease'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'diseaseName': diseaseName,
        'antidote': antidote,
        'description': description
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      Fluttertoast.showToast(
        msg: "Disease Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color.fromARGB(255, 92, 244, 54),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return Disease.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Disease.');
    }
  }

  Future<Disease> updateDisease(String id, String diseaseName, String antidote,
      String description) async {
    final response = await http.put(
      Uri.parse(baseUrl + 'update-disease/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'diseaseName': diseaseName,
        'antidote': antidote,
        'description': description
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      Fluttertoast.showToast(
        msg: "Disease Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color.fromARGB(255, 108, 244, 54),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return Disease.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update Disease.');
    }
  }
}
