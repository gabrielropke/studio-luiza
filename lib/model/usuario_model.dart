class Usuario {
  String? _idUsuario;
  String? _email;
  String? _senha;

  Usuario();

  String get idUsuario => _idUsuario!;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get email => _email!;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha!;

  set senha(String value) {
    _senha = value;
  }
}
