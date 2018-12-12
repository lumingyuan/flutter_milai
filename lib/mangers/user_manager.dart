class UserManager {
  bool isLogin = false;

  static UserManager _instance;
  static UserManager shareInstance() {
    if (_instance == null) {
      _instance = new UserManager();
    }
    return _instance;
  }

}
