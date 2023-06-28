import 'package:form_field_validator/form_field_validator.dart';

RequiredValidator requiredValidator([String errorText = 'Required field']) {
  return RequiredValidator(errorText: errorText);
}

LengthRangeValidator lengthValidator(int length, String errorText) {
  return LengthRangeValidator(min: length, max: length, errorText: errorText);
}

final emailValidator = EmailValidator(errorText: 'Please enter a valid email');