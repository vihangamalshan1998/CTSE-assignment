import 'dart:convert';
import 'dart:io';
import 'package:frontend_mobile/exceptions/Exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Fertilizer with ChangeNotifier {
  final String id;
  final String name;
  final String code;
  final String weight;
  final String description;

  Fertilizer(
    this.id,
    this.name,
    this.code,
    this.weight,
    this.description,
  );
}

class Fertilizers with ChangeNotifier {
  List<Fertilizer> fertilizers = [];
  Fertilizer fertilizer = Fertilizer('', '', '', '', '');

  List<Fertilizer> getFertilizers() {
    return fertilizers;
  }

  Fertilizer getFertilizer() {
    return fertilizer;
  }

  Future<void> fetchFertilizers() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8070/fertilizer/GetAllFertilizer'),
        // Uri.parse('http://10.0.2.2:8070/fertilizer/GetAllFertilizer'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body) as List<dynamic>;
          final List<Fertilizer> loadedFertilizers = [];
          extractedCode.forEach(
            (prodData) {
              loadedFertilizers.add(
                Fertilizer(
                  prodData['_id'],
                  prodData['fertilizer_Name'],
                  prodData['fertilizer_code'],
                  prodData['weight'],
                  prodData['description'],
                ),
              );
            },
          );
          fertilizers = loadedFertilizers;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<void> fetchFertilizer(id) async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8070/fertilizer/GetFertilizer/$id'),
        // Uri.parse('http://10.0.2.2:8070/fertilizer/GetFertilizer/$id'),
      );
      switch (response.statusCode) {
        case 200:
          final extractedCode = json.decode(response.body);
          final Fertilizer loadedFertilizer;
          loadedFertilizer = Fertilizer(
            extractedCode['_id'],
            extractedCode['fertilizer_Name'],
            extractedCode['fertilizer_code'],
            extractedCode['weight'],
            extractedCode['description'],
          );
          fertilizer = loadedFertilizer;
          notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> createFertilizer(
    name,
    code,
    weight,
    description,
  ) async {
    Map<String, dynamic> body = {
      "fertilizer_Name": name,
      "fertilizer_code": code,
      "weight": weight,
      "description": description,
    };
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8070/fertilizer/add'),
        // Uri.parse('http://10.0.2.2:8070/fertilizer/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> updateFertilizer(
    id,
    name,
    code,
    weight,
    description,
  ) async {
    Map<String, dynamic> body = {
      "fertilizer_Name": name,
      "fertilizer_code": code,
      "weight": weight,
      "description": description,
    };
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8070/fertilizer/UpdateData/$id'),
        // Uri.parse('http://10.0.2.2:8070/fertilizer/UpdateData/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(body),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> deleteFertilizer(id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8070/fertilizer/Delete/$id'),
        // Uri.parse('http://10.0.2.2:8070/fertilizer/Delete/$id'),
      );
      notifyListeners();
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body)['message'].toString();
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}
