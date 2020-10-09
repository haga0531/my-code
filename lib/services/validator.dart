class Validator {
  static String emailValidate(String value) {
    if (value.isEmpty) {
      return 'メールアドレスが空欄です';
    } else {
      return null;
    }
  }

  static String passwordValidate(String value) {
    if (value.isEmpty) {
      return 'パスワードが空欄です';
    } else if (value.length < 6) {
      return 'パスワードは6文字以上で作成してください';
    } else {
      return null;
    }
  }
}
