// data_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchData() async {
  final tasksRef = FirebaseFirestore.instance.collection('tasks');
  final snapshot = await tasksRef.get();
  final tasks = snapshot.docs.map((doc) => doc.data()).toList();
  return tasks;
}
