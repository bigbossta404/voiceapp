class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "wrong-password":
        var error = AuthResultStatus.wrongPassword;
        status = generateExceptionMessage(error);
        break;
      case "invalid-email":
        var error = AuthResultStatus.invalidEmail;
        status = generateExceptionMessage(error);
        break;
      case "user-disabled":
        var error = AuthResultStatus.userDisabled;
        status = generateExceptionMessage(error);
        break;
      case "user-not-found":
        var error = AuthResultStatus.userNotFound;
        status = generateExceptionMessage(error);
        break;
      case "too-many-requests":
        var error = AuthResultStatus.tooManyRequests;
        status = generateExceptionMessage(error);
        break;
      case "operation-not-allowed":
        var error = AuthResultStatus.operationNotAllowed;
        status = generateExceptionMessage(error);
        break;
      case "email-already-in-use":
        var error = AuthResultStatus.emailAlreadyExists;
        status = generateExceptionMessage(error);
        break;
      case "invalid-credential":
        var error = AuthResultStatus.invalidCredential;
        status = generateExceptionMessage(error);
        break;
      default:
        var error = AuthResultStatus.undefined;
        status = generateExceptionMessage(error);
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.invalidCredential:
        errorMessage = "Your credentials are invalid. Please check your email and password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  invalidCredential,
  undefined,
}
