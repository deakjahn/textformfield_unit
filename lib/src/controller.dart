import 'package:flutter/material.dart';

import 'textformfield_unit.dart';

class TextFormUnitController<TUnit> extends TextEditingController {
  late void Function(double value) setValue;
  late void Function(TUnit? unit, {bool convert}) setUnit;
  late void Function(ValueWithUnit<TUnit> value) setValueUnit;

  TextFormUnitController({super.text});
}