import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show NumberFormat;

import 'controller.dart';

typedef TextFormUnitFieldConverter<T> = double Function(T fromUnit, T toUnit, double fromValue);

class TextFormUnitField<TUnit> extends StatefulWidget {
  // Text field
  final TextEditingController controller;
  final String? initialValue;
  final FocusNode? textFocusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Widget? icon;
  final TextStyle? textStyle;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool textAutofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final String? labelText;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<ValueWithUnit<TUnit>>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<ValueWithUnit<TUnit>>? onFieldSubmitted;
  final FormFieldSetter<ValueWithUnit<TUnit>>? onSaved;
  final FormFieldValidator<ValueWithUnit<TUnit>>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final UndoHistoryController? undoController;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool? cursorOpacityAnimates;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final DragStartBehavior dragStartBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Clip clipBehavior;
  final bool scribbleEnabled;
  final bool canRequestFocus;

  // Unit dropdown
  final Map<TUnit, String> units;
  final TUnit initialUnit;
  final Widget? unitHint;
  final Widget? disabledHint;
  final DropdownButtonBuilder? selectedItemBuilder;
  final int elevation;
  final TextStyle? unitStyle;
  final Widget? unitIcon;
  final Color? unitIconDisabledColor;
  final Color? unitIconEnabledColor;
  final double unitIconSize;
  final bool isExpanded;
  final double? itemHeight;
  final Color? unitFocusColor;
  final FocusNode? unitFocusNode;
  final bool unitAutofocus;
  final Color? dropdownColor;
  final EdgeInsetsGeometry? padding;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final BorderRadius? borderRadius;

  // Operation
  final double Function(TUnit fromUnit, TUnit toUnit, double fromValue) converter;

  const TextFormUnitField({
    super.key,
    required this.controller,
    this.initialValue,
    this.textFocusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.textStyle,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textAutofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.labelText,
    this.icon,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    required this.units,
    required this.initialUnit,
    this.selectedItemBuilder,
    this.unitHint,
    this.disabledHint,
    this.elevation = 8,
    this.unitStyle,
    this.unitIcon,
    this.unitIconDisabledColor,
    this.unitIconEnabledColor,
    this.unitIconSize = 24.0,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.unitFocusColor,
    this.unitFocusNode,
    this.unitAutofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.borderRadius,
    this.padding,
    required this.converter,
  });

  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  State<TextFormUnitField<TUnit>> createState() => _TextFormUnitFieldState<TUnit>();
}

class _TextFormUnitFieldState<TUnit> extends State<TextFormUnitField<TUnit>> {
  TUnit? unitValue;

  @override
  void initState() {
    super.initState();

    unitValue = widget.initialUnit;
    if (widget.controller is TextFormUnitController) {
      final _controller = widget.controller as TextFormUnitController<TUnit>;
      _controller.setValue = doSetValue;
      _controller.setUnit = doSetUnit;
      _controller.setValueUnit = doSetValueUnit;
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        focusNode: widget.textFocusNode,
        decoration: InputDecoration(
          labelText: widget.labelText,
          icon: widget.icon,
          enabled: widget.enabled ?? true,
          suffix: DropdownButtonHideUnderline(
            child: DropdownButton<TUnit>(
              items: [
                for (final unit in widget.units.entries)
                  DropdownMenuItem<TUnit>(
                    value: unit.key,
                    alignment: AlignmentDirectional.center,
                    child: Text(unit.value),
                  )
              ],
              value: unitValue,
              selectedItemBuilder: widget.selectedItemBuilder,
              hint: widget.unitHint,
              disabledHint: widget.disabledHint,
              onChanged: onUnitChanged,
              elevation: widget.elevation,
              style: widget.unitStyle,
              icon: widget.unitIcon,
              iconDisabledColor: widget.unitIconDisabledColor,
              iconEnabledColor: widget.unitIconEnabledColor,
              iconSize: widget.unitIconSize,
              isDense: true,
              isExpanded: widget.isExpanded,
              itemHeight: widget.itemHeight,
              focusColor: widget.unitFocusColor,
              focusNode: widget.unitFocusNode,
              autofocus: widget.unitAutofocus,
              dropdownColor: widget.dropdownColor,
              menuMaxHeight: widget.menuMaxHeight,
              enableFeedback: widget.enableFeedback,
              alignment: AlignmentDirectional.centerEnd,
              borderRadius: widget.borderRadius,
              padding: widget.padding,
            ),
          ),
        ),
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        style: widget.textStyle,
        strutStyle: widget.strutStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        autofocus: widget.textAutofocus,
        readOnly: widget.readOnly,
        showCursor: widget.showCursor,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLength: widget.maxLength,
        onChanged: (value) => widget.onChanged?.call(_parse(value)),
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(_parse(value)),
        onSaved: (value) => widget.onSaved?.call(_parse(value)),
        validator: (value) => widget.validator?.call(_parse(value)),
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectionControls: widget.selectionControls,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        autovalidateMode: widget.autovalidateMode,
        scrollController: widget.scrollController,
        restorationId: widget.restorationId,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        mouseCursor: widget.mouseCursor,
        contextMenuBuilder: widget.contextMenuBuilder,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        magnifierConfiguration: widget.magnifierConfiguration,
        undoController: widget.undoController,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        dragStartBehavior: widget.dragStartBehavior,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        clipBehavior: widget.clipBehavior,
        stylusHandwritingEnabled: widget.scribbleEnabled,
        canRequestFocus: widget.canRequestFocus,
      );

  ValueWithUnit<TUnit> _parse(String? value) {
    try {
      return (value != null) //
          ? ValueWithUnit<TUnit>(_parseDoubleLocale(value), unitValue)
          : ValueWithUnit<TUnit>(0, null);
    } on FormatException catch (_) {
      return ValueWithUnit<TUnit>(0, null);
    }
  }

  double _parseDoubleLocale(String s, [double value = 0]) {
    try {
      return NumberFormat().parse(s).toDouble();
    } on FormatException catch (_) {
      return value;
    }
  }

  void onUnitChanged(TUnit? unit) {
    if (unitValue != null && unit != null) {
      final currentValue = _parseDoubleLocale(widget.controller.text);
      final newValue = widget.converter.call(unitValue as TUnit, unit, currentValue);
      setState(() {
        widget.controller.text = NumberFormat.decimalPattern().format(newValue);
        unitValue = unit;
      });
    }
  }

  void doSetValue(double value) {
    widget.controller.text = NumberFormat.decimalPattern().format(value);
  }

  void doSetUnit(TUnit? unit, {bool convert = false}) {
    if (convert)
      onUnitChanged(unit);
    else
      setState(() => unitValue = unit);
  }

  void doSetValueUnit(ValueWithUnit<TUnit> value) {
    doSetValue(value.value);
    doSetUnit(value.unit);
  }
}

class ValueWithUnit<T> {
  final double value;
  final T? unit;

  ValueWithUnit(this.value, this.unit);
}