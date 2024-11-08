# TextFormField with units

[![pub package](https://img.shields.io/pub/v/textformfield_unit.svg)](https://pub.dev/packages/textformfield_unit)

A `TextFormField` widget that has a dropdown list for units and provides conversion.

## Usage

You can use it almost like the original `TextFormField` form field, with a few additions.

First, it has a generic type, the type of the unit you want to use. Let's suppose we need the following three length units:

```dart
enum SizeUnits { Millimeter, Inch, LightNanosecond }
```

We prepare a map with the user readable names:

```dart
static final unitNames = {
  SizeUnits.Millimeter: 'mm',
  SizeUnits.Inch: '"',
  SizeUnits.LightNanosecond: 'light-ns',
};
```

And a function that can receive a value in one unit and has to convert it to another one:

```dart
  double _sizeConverter(SizeUnits fromUnit, SizeUnits toUnit, double value) {
    final valueMm = switch (fromUnit) {
      SizeUnits.Millimeter => value,
      SizeUnits.Inch => value * 25.4,
      SizeUnits.LightNanosecond => value * 299.792458,
    };
    return switch (toUnit) {
      SizeUnits.Millimeter => valueMm,
      SizeUnits.Inch => valueMm / 25.4,
      SizeUnits.LightNanosecond => valueMm / 299.792458,
    };
  }
```

We pass these – and any other usual `TextFormField` stuff you need – to the field. 

```dart
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
```

When it calls back for validation or saving, it passes a `ValueWithUnit<T>` value where `T` is our unit type.

# Support

If you like this package, please consider supporting it.

<a href="https://www.buymeacoffee.com/deakjahn" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Book" height="60" width="217"></a>