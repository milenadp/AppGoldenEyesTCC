import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormarter {
  static final cpf = _cpf();
  static final cnpj = _cnpj();
  static final rg = _rg();
  static final phone = _phone();
  static final cep = _cep();
  static final birth = _birth();
  static final preco = _preco();
}

class _cep extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '#####-###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _birth extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _phone extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '(##) #-####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _rg extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '##.###.###-#',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _cpf extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _cnpj extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '##.###.###/####-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class _preco extends FieldFormated {
  @override
  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        filter: {"#": RegExp(r'[0-9],[,],[.]')},
        type: MaskAutoCompletionType.lazy);
  }
}

class FieldFormated {
  String maskText(String value) {
    MaskTextInputFormatter mask = input_mask() as MaskTextInputFormatter;
    return mask.maskText(value);
  }

  String clear_mask(String value) {
    MaskTextInputFormatter mask = input_mask() as MaskTextInputFormatter;
    return mask.unmaskText(value);
  }

  TextInputFormatter input_mask() {
    return MaskTextInputFormatter(
        mask: '###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}
