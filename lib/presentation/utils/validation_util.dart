import 'package:linkedin_clone/presentation/utils/response_util.dart';

bool isValidEmail(String? email) {
  final emailRegex = RegExp(
      r"^(?!\.)[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
  if (email == null || email.isEmpty) {
    return false;
  }

  final match = emailRegex.firstMatch(email);
  if (match == null) {
    return false;
  }

  final domain = email.substring(match.start + 1);

  if (!domain.contains('.')) {
    return false;
  }

  final tld = domain.substring(domain.lastIndexOf('.') + 1);
  final validTLDs = ['com', 'net', 'org', 'lk'];
  if (!validTLDs.contains(tld.toLowerCase())) {
    return false;
  }

  return true;
}

bool isValidPhone(String input) =>
    RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
        .hasMatch(input);

PasswordValidationResult validatePassword(String password) {
  if (password.isEmpty) {
    return PasswordValidationResult(
        isValid: false, error: "Password cannot be empty");
  }

  if (password.length < 6) {
    return PasswordValidationResult(
        isValid: false, error: "Password must be at least 6 characters long");
  }

  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return PasswordValidationResult(
      isValid: false,
      error: "Password must contain at least one uppercase letter",
    );
  }

  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return PasswordValidationResult(
      isValid: false,
      error: "Password must contain at least one lowercase letter",
    );
  }

  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return PasswordValidationResult(
      isValid: false,
      error: "Password must contain at least one digit",
    );
  }

  return PasswordValidationResult(
    isValid: true,
  );
}
