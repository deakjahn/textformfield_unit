import 'package:flutter/material.dart';

class TextFormUnitController<TUnit> extends TextEditingController {
  late void Function(double value) setValue;
  late void Function(TUnit unit, {bool convert}) setUnit;

  TextFormUnitController({super.text});
}