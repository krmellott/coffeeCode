import 'package:firebase_auth/firebase_auth.dart';

import '../model/BCModel.dart';

class StressFreeController {
  final modelReference = new BrunchClubModel();
  final String _userID = FirebaseAuth.instance.currentUser!.uid;
}
