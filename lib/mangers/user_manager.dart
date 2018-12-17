import 'package:flutter_milai/models/user_model.dart';
import 'package:flutter_milai/global.dart';

export 'package:flutter_milai/models/user_model.dart';

class UserManager {
  final String kUserKey = 'key_user';

  static UserManager _instance;
  static UserManager shareInstance() {
    if (_instance == null) {
      _instance = new UserManager();
    }
    return _instance;
  }

  UserModel _userModel;

  UserManager() {
    _loadFromLocal();
  }

  bool get isLogin => this._userModel != null;
  UserModel get userModel => this._userModel;
  set userModel(UserModel model) {
    _userModel = model;
    _saveToLocal();
  }

  _loadFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(kUserKey) ?? "";
    if (isNotEmpty(userJson)) {
      _userModel = UserModel.fromJson(json.decode(userJson));
    }
  }

  _saveToLocal() async {
    if (_userModel != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserKey, json.encode(_userModel));
    }
  }
}
