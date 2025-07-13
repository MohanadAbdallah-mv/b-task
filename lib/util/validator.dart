class Validator {
  static validateEmpty(
    String value,
    String textField,
  ) {
    if (value.trim().isEmpty) {
      return "${"Enter"} $textField ${"above."}";
    }
    return null;
  }
}
