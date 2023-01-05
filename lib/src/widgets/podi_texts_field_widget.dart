import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class PodiTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter> inputFormatters;
  final double radius;
  final double height;
  final double? width;
  final String? label;
  final String? helper;
  final String? initialValue;
  final String? hint;
  final IconData? suffixIcon;
  final IconData? preffixIcon;
  final Widget? suffixWidget;
  final Widget? preffixWidget;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final bool isDate;
  final bool isHour;
  final bool isObligatory;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  const PodiTextFormField({
    this.radius = 4,
    this.height = 40,
    this.width,
    this.initialValue,
    this.label,
    this.helper,
    this.validator,
    this.controller,
    this.hint,
    this.enabled = true,
    this.readOnly = false,
    this.isObligatory = false,
    this.isDate = false,
    this.isHour = false,
    this.inputFormatters = const [],
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.suffixIcon,
    this.suffixWidget,
    this.preffixIcon,
    this.preffixWidget,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  State<PodiTextFormField> createState() => _PodiTextFormFieldState();
}

class _PodiTextFormFieldState extends State<PodiTextFormField> {
  late double _radius;
  late double _height;
  late double? _width;
  late String? _label;
  late String? _helper;
  late String? _initialValue;
  late String? _hint;
  late bool _enabled;
  late bool _readOnly;
  late bool _isObligatory;
  late bool _isDate;
  late bool _isHour;
  late IconData? _suffixIcon;
  late IconData? _preffixIcon;
  late Widget? _suffixWidget;
  late Widget? _preffixWidget;
  late FocusNode? _focusNode;

  late TextEditingController? _controller;
  late List<TextInputFormatter> _inputFormatters;

  late String? Function(String?)? _validator;
  late void Function(String?)? _onSaved;
  late void Function(String)? _onChanged;
  late void Function()? _onTap;

  final _dateController = MaskedTextController(
    cursorBehavior: CursorBehaviour.end,
    mask: "30/10/0000",
    translator: {
      "3": RegExp(r'[0-3]'),
      "1": RegExp(r'[0-1]'),
      "0": RegExp(r'[0-9]')
    },
  );

  final _hourController = MaskedTextController(
    cursorBehavior: CursorBehaviour.end,
    mask: "00:00",
  );

  @override
  void initState() {
    super.initState();
    _radius = widget.radius;
    _height = widget.height;
    _width = widget.width;
    _label = widget.label;
    _helper = widget.helper;
    _hint = widget.hint;
    _initialValue = widget.initialValue;
    _validator = widget.validator;
    _controller = widget.controller;
    _enabled = widget.enabled;
    _isObligatory = widget.isObligatory;
    _isDate = widget.isDate;
    _isHour = widget.isHour;
    _inputFormatters = widget.inputFormatters;
    _onSaved = widget.onSaved;
    _onChanged = widget.onChanged;
    _suffixIcon = widget.suffixIcon;
    _preffixIcon = widget.preffixIcon;
    _suffixWidget = widget.suffixWidget;
    _preffixWidget = widget.preffixWidget;
    _onTap = widget.onTap;
    _focusNode = widget.focusNode;
    _readOnly = widget.readOnly;
    if (_isDate && !isNull(_initialValue)) {
      _dateController.text = _initialValue ?? "";
    }
    if (_isHour && !isNull(_initialValue)) {
      _hourController.text = _initialValue ?? "";
    }
  }

  bool isError = false;

  @override
  void dispose() {
    _dateController.dispose();
    _hourController.dispose();
    _controller = null;
    super.dispose();
  }

  String? validateDate(String? value) {
    if (!isNull(value)) {
      try {
        if (value!.length < 10) return 'Insira uma data válida.';
        if (!isValidDate(value)) return "Data inválida!";
      } catch (_) {
        return "Data inválida!";
      }
    }
    return null;
  }

  String? validateHour(String? value) {
    if (!isNull(value)) {
      if (value!.length < 5) return "Valor inválido.";
      if (value.length >= 5) {
        final split = value.split(":");
        final hour = int.tryParse(split[0]);
        final minute = int.tryParse(split[1]);
        if (hour! > 24 || hour < 0 || minute! > 59 || minute < 0) {
          return "Formato de hora inválido";
        }
      }
    }
    return null;
  }

  Widget get _textFormField {
    Widget? _buildLabel() {
      if (isNull(_label)) {
        return null;
      }
      return Text.rich(
        TextSpan(
          text: _label,
          style: PodiTexts.label3.weightMedium,
          children: <InlineSpan>[
            if (_isObligatory) ...[
              TextSpan(
                text: ' *',
                style:
                    PodiTexts.label3.weightMedium.withColor(PodiColors.danger),
              ),
            ],
          ],
        ),
      );
    }

    Widget? _buildPreffix() {
      if (_preffixWidget != null) {
        return _preffixWidget;
      }
      if (_preffixIcon != null) {
        return Icon(_preffixIcon, size: 16, color: PodiColors.neutrals[300]);
      }
      return null;
    }

    Widget? _buildSuffix() {
      if (_suffixWidget != null) {
        return _suffixWidget;
      }
      if (_suffixIcon != null) {
        return Icon(_suffixIcon, size: 16, color: PodiColors.neutrals[700]);
      }
      return null;
    }

    return TextFormField(
      focusNode: _focusNode,
      initialValue:
          !(_isDate || _isHour || _controller != null) ? _initialValue : null,
      controller: (_isDate)
          ? _dateController
          : (_isHour)
              ? _hourController
              : _controller,
      validator: (value) {
        setState(() => isError = true);
        if (_isObligatory) {
          if (isNull(value)) {
            return "Campo obrigatório.";
          }
        }
        if (_isDate) {
          return validateDate(value);
        }
        if (_isHour) {
          return validateHour(value);
        }
        return _validator?.call(value);
        setState(() => isError = false);
        return null;
      },
      onChanged: _onChanged,
      onSaved: _onSaved,
      onTap: _onTap,
      inputFormatters: [
        if (_isDate || _isHour) ...[FilteringTextInputFormatter.digitsOnly],
        ..._inputFormatters,
      ],
      style: _enabled
          ? PodiTexts.body2.weightMedium
          : PodiTexts.body2.weightSemibold.withColor(PodiColors.neutrals[500]!),
      enabled: _enabled,
      readOnly: !(_enabled) || _readOnly,
      decoration: InputDecorationWidget.simple(
        hint: _hint ?? "",
        radius: _radius,
        backgroundColor: _enabled ? PodiColors.white : PodiColors.neutrals[50],
        borderColor: PodiColors.dark[100],
        prefix: _buildPreffix(),
        suffix: _buildSuffix(),
      ).copyWith(
        hintStyle:
            PodiTexts.body2.weightMedium.withColor(PodiColors.neutrals[500]!),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PodiColors.neutrals[200]!),
          borderRadius: BorderRadius.circular(_radius),
        ),
        contentPadding: const EdgeInsets.only(left: 12),
        label: _buildLabel(),
        helperText: _helper,
        helperStyle: PodiTexts.label3,
        errorStyle: PodiTexts.label3.withColor(PodiColors.danger),
      ),
    );
  }

  Widget _buildBox(Widget child) {
    return SizedBox(
      height: (isError || !isNull(_helper))
          ? _height + getTextSize(' ', PodiTexts.label3).height + 8
          : _height,
      width: _width,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBox(_textFormField);
  }
}
