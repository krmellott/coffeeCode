import 'package:firebase_auth/firebase_auth.dart';

import '../model/BCModel.dart';

class StressFreeController {
  final modelReference = new BrunchClubModel();
  final String _userID = FirebaseAuth.instance.currentUser!.uid;

  insertJournalData(String title, int date, String body) {
    modelReference.dbInsertJournal(title, date, body, _userID);
  }

  removeJournalData(String collection, String title) {
    modelReference.dbRemoveJournal(collection, title, _userID);
  }

  editJournalData(String title, int date, String body) {
    modelReference.dbEditJournal(title, date, body, _userID);
  }

  insertVideo(String title, bool isFavorite, String url) {
    modelReference.dbInsertVideo(isFavorite, title, url);
  }

  removeVideo(String collection, String title) {
    modelReference.dbRemoveVideo(collection, title);
  }

}
