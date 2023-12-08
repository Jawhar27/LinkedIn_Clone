class PasswordValidationResult {
  final bool isValid;
  final String error;

  PasswordValidationResult({required this.isValid, this.error = ""});
}