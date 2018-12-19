import 'package:flutter_milai/models/user_model.dart';
import 'package:flutter_milai/global.dart';

export 'package:flutter_milai/models/user_model.dart';
export 'package:flutter_milai/models/user_center_model.dart';

class UserChangedEvent {
}

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

    //广播用户信息更改
    Global.eventBus.fire(new UserChangedEvent());
  }

  //用户资料更新
  void update({bool fire = true}) async {
    await _saveToLocal();

    if (fire) {
      Global.eventBus.fire(new UserChangedEvent());
    }
  }

  //用户推出
  void logout() async {
    _userModel = null;

    await _deleteLocal(); //删除本地缓存

    Global.eventBus.fire(new UserChangedEvent());
  }

  _loadFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(kUserKey) ?? "";
    if (isNotEmpty(userJson)) {
      _userModel = UserModel.fromJson(json.decode(userJson));
    }

    //广播用户信息更改
    Global.eventBus.fire(new UserChangedEvent());
  }

  _saveToLocal() async {
    if (_userModel != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserKey, json.encode(_userModel));
    }
  }

  _deleteLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(kUserKey);
  }
}
