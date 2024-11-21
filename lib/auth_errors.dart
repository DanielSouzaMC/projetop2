// auth_errors.dart
String handleAuthError(String errorCode) {
  switch (errorCode) {
    case 'auth/app-not-authorized':
      return 'O aplicativo não está autorizado a usar Firebase Authentication.';
    case 'auth/app-not-installed':
      return 'O aplicativo necessário não está instalado.';
    case 'auth/captcha-check-failed':
      return 'Falha na verificação do CAPTCHA.';
    case 'auth/code-expired':
      return 'O código de verificação expirou.';
    case 'auth/credential-already-in-use':
      return 'Essa credencial já está em uso por outra conta.';
    case 'auth/custom-token-mismatch':
      return 'O token personalizado é inválido.';
    case 'auth/email-already-in-use':
      return 'O e-mail informado já está em uso.';
    case 'auth/expired-action-code':
      return 'O código de ação expirou.';
    case 'auth/invalid-action-code':
      return 'O código de ação é inválido.';
    case 'auth/invalid-credential':
      return 'Credenciais inválidas. Verifique os dados informados.';
    case 'auth/invalid-email':
      return 'E-mail inválido. Insira um e-mail válido.';
    case 'auth/invalid-phone-number':
      return 'Número de telefone inválido.';
    case 'auth/invalid-verification-code':
      return 'Código de verificação inválido.';
    case 'auth/invalid-verification-id':
      return 'ID de verificação inválido.';
    case 'auth/missing-email':
      return 'E-mail ausente. Insira seu e-mail.';
    case 'auth/missing-phone-number':
      return 'Número de telefone ausente.';
    case 'auth/missing-password':
      return 'Insira sua senha.';
    case 'auth/network-request-failed':
      return 'Erro de conexão. Verifique sua internet.';
    case 'auth/no-signed-in-user':
      return 'Nenhum usuário conectado.';
    case 'auth/operation-not-allowed':
      return 'Operação não permitida. Entre em contato com o suporte.';
    case 'auth/phone-number-already-exists':
      return 'O número de telefone já está em uso.';
    case 'auth/provider-already-linked':
      return 'Esse provedor já está vinculado à conta.';
    case 'auth/quota-exceeded':
      return 'Limite de cota do Firebase Authentication excedido.';
    case 'auth/requires-recent-login':
      return 'Reautenticação necessária. Faça login novamente.';
    case 'auth/session-cookie-expired':
      return 'O cookie de sessão expirou.';
    case 'auth/session-cookie-revoked':
      return 'O cookie de sessão foi revogado.';
    case 'auth/too-many-requests':
      return 'Muitas tentativas. Tente novamente mais tarde.';
    case 'auth/unauthorized-continue-uri':
      return 'A URL de continuação não está autorizada.';
    case 'auth/unverified-email':
      return 'O e-mail ainda não foi verificado.';
    case 'auth/user-cancelled':
      return 'A ação foi cancelada pelo usuário.';
    case 'auth/user-disabled':
      return 'Conta desativada. Entre em contato com o suporte.';
    case 'auth/user-mismatch':
      return 'As credenciais não correspondem ao usuário.';
    case 'auth/user-not-found':
      return 'Usuário não encontrado. Verifique o e-mail.';
    case 'auth/weak-password':
      return 'Senha fraca. Escolha uma senha mais forte.';
    case 'auth/wrong-password':
      return 'Senha incorreta. Tente novamente.';
    case 'auth/unregistered':
      return 'Usuário não registrado.';
    case 'auth/invalid-continue-uri':
      return 'A URL de continuação fornecida é inválida.';
    default:
      return 'Erro desconhecido. Código: $errorCode';
  }
}
