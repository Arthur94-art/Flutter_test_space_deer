import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatter {
  static MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
      mask: '+38 0## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
