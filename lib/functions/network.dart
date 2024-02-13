import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<Map> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://api.openweathermap.org/data/2.5/air_pollution?lat=21.006254713797045&lon=105.84309604779587&appid=ff677b8db486de02b5effc8891a86899'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final Map parsed = jsonDecode(response.body);
    return parsed;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Map<String, dynamic>>> fetchTask() async {
  final tasksRef = FirebaseFirestore.instance.collection('tasks');
  final snapshot = await tasksRef.get();
  final tasks = snapshot.docs.map((doc) => doc.data()).toList();
  return tasks;
}
