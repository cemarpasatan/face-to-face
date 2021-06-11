import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  bool _editAge = false;
  bool _editProfileInfos = false;
  bool get editProfileInfos => _editProfileInfos;
  set editProfileInfos(value) {
    _editProfileInfos = value;
    notifyListeners();
  }

  bool get editAge => _editAge;
  set editAge(value) {
    _editAge = value;
    notifyListeners();
  }
}
