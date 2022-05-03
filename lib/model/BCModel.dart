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

  dbInsertJournal(String body, int date, String title, String userID) async {
    return await firestoreInstance
        .collection('journal')
        .doc(date.toString())
        .set({'title': title, 'body': body, 'date': date, 'userId': '$_uid'});
  }

  dbRemoveJournal(String collection, String title, String userID) async {
    var journalInstance = await firestoreInstance
        .collection('journal')
        .where('userId', isEqualTo: _uid)
        .where('title', isEqualTo: title)
        .limit(1)
        .get();

    var docID = journalInstance.docs.first.id;
    return await firestoreInstance
        .collection(collection)
        .doc(docID)
        .delete();
  }

  Future dbInsertVideo(bool isFavorite, String name, String url) async {
    return await firestoreInstance
        .collection('video bookmarks')
        .doc(name)
        .set({'isFavorite': isFavorite, 'name': name, 'url': url});
  }

  Future dbRemoveVideo(String collection, String name) async {
    return await firestoreInstance
        .collection('video bookmarks')
        .doc(name)
        .delete();
  }

}
