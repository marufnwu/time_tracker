abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator extends StringValidator{
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

}

class EmailAndPasswordValidator{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();

}