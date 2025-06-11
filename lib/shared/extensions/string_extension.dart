part of 'context_extension.dart';

extension StringExtension on String {
  bool get isValidEmail {
    if (isEmpty) return false;
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    if (isEmpty) return false;
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    if (isEmpty) return false;
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidUrl {
    if (isEmpty) return false;
    final uri = Uri.tryParse(this);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      return false;
    }

    final hostRegExp = RegExp(
      r"^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$|^(\d{1,3}\.){3}\d{1,3}$",
    );
    return hostRegExp.hasMatch(uri.host);
  }

  Widget textWithStrip({TextStyle? style, int maxLines = 1}) {
    return Text(
      this,
      maxLines: maxLines,
      style:
          style?.copyWith(decoration: TextDecoration.lineThrough) ??
          const TextStyle(decoration: TextDecoration.lineThrough),
    );
  }

  Widget obsecureText({TextStyle? style, int maxLines = 1}) {
    String obscuredText = '*' * length;
    return Text(obscuredText, maxLines: maxLines, style: style);
  }
}
