import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:textformfield_unit/textformfield_unit.dart';

enum SizeUnits { Millimeter, Inch, LightNanosecond, Twip, Thou, Barleycorn, Foot, Yard, Chain, Furlong, Mile, League, Fathom, NauticalMile, Link, Rod }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextFormFieldUnit Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final unitNames = {
    SizeUnits.Millimeter: 'mm',
    SizeUnits.Inch: 'in',
    SizeUnits.LightNanosecond: 'light-ns',
    SizeUnits.Twip: 'twip',
    SizeUnits.Thou: 'th',
    SizeUnits.Barleycorn: 'Bc',
    SizeUnits.Foot: 'ft',
    SizeUnits.Yard: 'yd',
    SizeUnits.Chain: 'ch',
    SizeUnits.Furlong: 'fur',
    SizeUnits.Mile: 'mi',
    SizeUnits.League: 'lea',
    SizeUnits.Fathom: 'ftm',
    SizeUnits.NauticalMile: 'nmi',
    SizeUnits.Link: 'links',
    SizeUnits.Rod: 'rods',
  };
  final formKey = GlobalKey<FormState>();
  late TextFormUnitController controller;

  @override
  void initState() {
    super.initState();
    controller = TextFormUnitController<SizeUnits>(text: NumberFormat.decimalPattern().format(156.25));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  double _sizeConverter(SizeUnits fromUnit, SizeUnits toUnit, double value) {
    final valueMm = switch (fromUnit) {
      SizeUnits.Millimeter => value,
      SizeUnits.Inch => value * 25.4,
      SizeUnits.LightNanosecond => value * 299.792458,
      SizeUnits.Twip => value * 0.0176389,
      SizeUnits.Thou => value * 0.0254,
      SizeUnits.Barleycorn => value * 8.4667,
      SizeUnits.Foot => value * 0304.8,
      SizeUnits.Yard => value * 914.4,
      SizeUnits.Chain => value * 20116.8,
      SizeUnits.Furlong => value * 201168,
      SizeUnits.Mile => value * 1609344,
      SizeUnits.League => value * 4828032,
      SizeUnits.Fathom => value * 1852,
      SizeUnits.NauticalMile => value * 1852,
      SizeUnits.Link => value * 0201.168,
      SizeUnits.Rod => value * 5029.2,
    };
    return switch (toUnit) {
      SizeUnits.Millimeter => valueMm,
      SizeUnits.Inch => valueMm / 25.4,
      SizeUnits.LightNanosecond => valueMm / 299.792458,
      SizeUnits.Twip => valueMm / 0.0176389,
      SizeUnits.Thou => valueMm / 0.0254,
      SizeUnits.Barleycorn => valueMm / 8.4667,
      SizeUnits.Foot => valueMm / 0304.8,
      SizeUnits.Yard => valueMm / 914.4,
      SizeUnits.Chain => valueMm / 20116.8,
      SizeUnits.Furlong => valueMm / 201168,
      SizeUnits.Mile => valueMm / 1609344,
      SizeUnits.League => valueMm / 4828032,
      SizeUnits.Fathom => valueMm / 1852,
      SizeUnits.NauticalMile => valueMm / 1852,
      SizeUnits.Link => valueMm / 0201.168,
      SizeUnits.Rod => valueMm / 5029.2,
    };
  }

  @override
  Widget build(BuildContext context) {
    final allowed = switch (NumberFormat().symbols.DECIMAL_SEP) {
      '.' => RegExp(r'[\d.]'),
      ',' => RegExp(r'[\d,]'),
      _ => RegExp(r'\d'),
    };

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormUnitField<SizeUnits>(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(allowed)],
                      textInputAction: TextInputAction.next,
                      icon: const Icon(Icons.height),
                      labelText: 'Size',
                      units: unitNames,
                      initialUnit: SizeUnits.Millimeter,
                      unitIcon: const Icon(Icons.keyboard_arrow_down),
                      converter: _sizeConverter,
                      onSaved: (value) {
                        if (value != null) print('${value.value} ${unitNames[value.unit]}');
                      },
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                controller.setValue(256.25);
                controller.setUnit(SizeUnits.Barleycorn);
              },
              child: const Text('Change to barleycorns'),
            ),
            ElevatedButton(
              onPressed: () => controller.setUnit(SizeUnits.Barleycorn, convert: true),
              child: const Text('Convert to barleycorns'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}