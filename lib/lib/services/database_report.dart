import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  DataBaseService({required this.uid});

  // collection reference
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('report');
  final CollectionReference myhistory =
      FirebaseFirestore.instance.collection('histroy');
  final CollectionReference myDoc =
      FirebaseFirestore.instance.collection('Doc_hospital');

  Future<void> updateUserRepost(
    String glucose,
    String cholesterol,
    String bilirubin,
    String bloodtype,
    String rbc,
    String mvc,
    String platelets,
    String hospital,
  ) async {
    return await myCollection.doc(uid).set({
      'bloodtype': bloodtype,
      'glucose': glucose,
      'cholesterol': cholesterol,
      'bilirubin': bilirubin,
      'RBC': rbc,
      'MVC': mvc,
      'Platelets': platelets,
      'hospital': hospital,
    });
  }

  Future<void> updateDoctorHosiptal(
    String hospital,
    String location,
  ) async {
    return await myDoc.doc(uid).set({
      'hospital': hospital,
      'location': location,
    });
  }

  Future<void> updateDonorHistory(
    String totalVolumnDonated,
    String monthSinceLdonation,
    String monthSinceFdonation,
    String donorNo,
    //String blood_donated,
    String madeDonation,
    String noOfDtns,
  ) async {
    return await myhistory.doc(uid).set({
      'total_volumn_donated': totalVolumnDonated,
      'no_of_dtns': noOfDtns,
      'month_since_Ldonation': monthSinceLdonation,
      'month_since_Fdonation': monthSinceFdonation,
      'Donor_no': donorNo,
      //'blood_donated': blood_donated,
      'made_donation': madeDonation,
    });
  }
}
