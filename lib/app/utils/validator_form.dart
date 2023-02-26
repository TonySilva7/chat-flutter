class ValidatorForm {
  static final Map<String, String> _regex = {
    'name': r'^[a-zA-Z ]+$',
    'email': r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    'password': r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%\^&\*])(?=.{8,})[A-Za-z\d!@#\$%\^&\*]+$',
  };

  static String? validateName(String value) {
    String name = value.trim();
    if (value.length > 3 && RegExp(_regex['name']!).hasMatch(name)) {
      return null;
    }
    return 'Nome nulo ou inválido';
  }

  static String? validateEmail(String value) {
    String email = value.trim();
    if (value.isNotEmpty && RegExp(_regex['email']!).hasMatch(email)) {
      return null;
    }
    return 'Email nulo ou inválido';
  }

  static String? validatePassword(String value) {
    String pass = value.trim();
    if (value.isNotEmpty && RegExp(_regex['password']!).hasMatch(pass)) {
      return null;
    }
    return 'Senha nula ou inválida';
  }
}
