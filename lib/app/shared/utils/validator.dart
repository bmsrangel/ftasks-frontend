class Validator {
  static String nameValidation(String name) {
    if (name.isEmpty) {
      return 'Nome é obrigatório';
    } else {
      return null;
    }
  }

  static String emailValidation(String email) {
    if (email.isEmpty) {
      return 'E-mail é obrigatório';
    } else if (!email.contains('@')) {
      return 'Formato de e-mail inválido';
    } else {
      return null;
    }
  }

  static String passwordValidation(String password) {
    if (password.isEmpty) {
      return 'A senha é obrigatória';
    } else if (password.length < 6) {
      return 'A senha precisa de no mínimo 6 caracteres';
    } else {
      return null;
    }
  }

  static String confirmPasswordValidation(
    String password,
    String passwordConfirmation,
  ) {
    if (passwordConfirmation.isEmpty) {
      return 'A senha é obrigatória';
    } else if (passwordConfirmation.length < 6) {
      return 'A senha precisa de no mínimo 6 caracteres';
    } else if (password != passwordConfirmation) {
      return 'As senhas não coincidem';
    } else {
      return null;
    }
  }
}
