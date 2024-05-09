class UserData {
  static final UserData _singleton = UserData._internal();
  String? email;

  factory UserData() {
    return _singleton;
  }

  UserData._internal();
}
