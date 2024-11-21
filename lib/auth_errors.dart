// auth_errors.dart
String handleAuthError(String errorCode) {
  switch (errorCode) {
    case 'app-not-authorized':
      return 'O aplicativo não está autorizado a usar Firebase Authentication.';
    case 'app-not-installed':
      return 'O aplicativo necessário não está instalado.';
    case 'captcha-check-failed':
      return 'Falha na verificação do CAPTCHA.';
    case 'code-expired':
      return 'O código de verificação expirou.';
    case 'credential-already-in-use':
      return 'Essa credencial já está em uso por outra conta.';
    case 'custom-token-mismatch':
      return 'O token personalizado é inválido.';
    case 'email-already-in-use':
      return 'O e-mail informado já está em uso.';
    case 'expired-action-code':
      return 'O código de ação expirou.';
    case 'invalid-action-code':
      return 'O código de ação é inválido.';
    case 'invalid-credential':
      return 'Credenciais inválidas. Verifique os dados informados.';
    case 'invalid-email':
      return 'E-mail inválido. Insira um e-mail válido.';
    case 'invalid-phone-number':
      return 'Número de telefone inválido.';
    case 'invalid-verification-code':
      return 'Código de verificação inválido.';
    case 'invalid-verification-id':
      return 'ID de verificação inválido.';
    case 'missing-email':
      return 'E-mail ausente. Insira seu e-mail.';
    case 'missing-phone-number':
      return 'Número de telefone ausente.';
    case 'missing-password':
      return 'Insira sua senha.';
    case 'network-request-failed':
      return 'Erro de conexão. Verifique sua internet.';
    case 'no-signed-in-user':
      return 'Nenhum usuário conectado.';
    case 'operation-not-allowed':
      return 'Operação não permitida. Entre em contato com o suporte.';
    case 'phone-number-already-exists':
      return 'O número de telefone já está em uso.';
    case 'provider-already-linked':
      return 'Esse provedor já está vinculado à conta.';
    case 'quota-exceeded':
      return 'Limite de cota do Firebase Authentication excedido.';
    case 'requires-recent-login':
      return 'Reautenticação necessária. Faça login novamente.';
    case 'session-cookie-expired':
      return 'O cookie de sessão expirou.';
    case 'session-cookie-revoked':
      return 'O cookie de sessão foi revogado.';
    case 'too-many-requests':
      return 'Muitas tentativas. Tente novamente mais tarde.';
    case 'unauthorized-continue-uri':
      return 'A URL de continuação não está autorizada.';
    case 'unverified-email':
      return 'O e-mail ainda não foi verificado.';
    case 'user-cancelled':
      return 'A ação foi cancelada pelo usuário.';
    case 'user-disabled':
      return 'Conta desativada. Entre em contato com o suporte.';
    case 'user-mismatch':
      return 'As credenciais não correspondem ao usuário.';
    case 'user-not-found':
      return 'Usuário não encontrado. Verifique o e-mail.';
    case 'weak-password':
      return 'Senha fraca. Escolha uma senha mais forte.';
    case 'wrong-password':
      return 'Senha incorreta. Tente novamente.';
    case 'unregistered':
      return 'Usuário não registrado.';
    case 'invalid-continue-uri':
      return 'A URL de continuação fornecida é inválida.';
      case 'missing-password':
      return 'Digite sua senha';
    default:
      return 'Erro desconhecido. Código: $errorCode';
  }
}
