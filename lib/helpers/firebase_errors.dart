String getErrorString(String code){

  switch (code) {
    case 'invalid-email':
      return 'Seu e-mail é inválido.';
    case 'wrong-password':
      return 'Sua senha está incorreta.';
    case 'user-not-found':
      return 'Não há usuário com este e-mail.';
    case 'user-disabled':
      return 'Este usuário foi desabilitado.';
    case 'email-already-in-use':
      return 'Já existe um usuário com este e-mail.';
    case 'operation-not-allowed':
      return 'Operação não permitida.';
    case 'weak-password':
      return 'Indique uma senha mais forte.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}