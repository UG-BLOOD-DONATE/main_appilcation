import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('report');

  Future<void> updateUserRepost(
    String glucose,
    String cholesterol,
    String bilirubin,
    String bloodtype,
    String rbc,
    String mvc,
    String Platelets,
    String hospital,
  ) async {
    return await brewCollection.doc(uid).set({
      'bloodtype': bloodtype,
      'glucose': glucose,
      'cholesterol': cholesterol,
      'bilirubin': bilirubin,
      'RBC': rbc,
      'MVC': mvc,
      'Platelets': Platelets,
      'hospital': hospital,
    });
  }
}
