import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addData(Map<String, dynamic> data) async {
    await _db.collection('heart_risk_data').add(data);
  }
}
