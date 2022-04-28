import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrunchClubModel {
  final firestoreInstance = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid.toString();

//   Stream<QuerySnapshot> orderedUserData(String orderPreference) {
//     return firestoreInstance
//         .collection('UserData')
//         .orderBy(orderPreference)
// //        .where('userId', isEqualTo: _uid)
//         .snapshots();
//   }

  Stream<QuerySnapshot> orderedUserDataWithSort(
      String orderPreference, bool sort) {
    return firestoreInstance
        .collection('UserData')
        .orderBy(orderPreference, descending: sort)
//        .where('userId', isEqualTo: _uid)
        .snapshots();
  }

  Stream<QuerySnapshot> orderedCoffeeTypeWithSort(
      String field, String fieldParameter, bool sort) {
    return firestoreInstance
        .collection('UserData')
        .where('$field', isEqualTo: '$fieldParameter')
//        .where('userId', isEqualTo: _uid)
        .snapshots();
  }
}
