/// Block Color Picker

library block_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/utils.dart';

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, void Function() changeColor);

// ignore: must_be_immutable
class BlockPicker extends StatefulWidget {
   BlockPicker({Key? key,
    this.pickerColor,
    this.onColorChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  }) : super(key: key);

   Color? pickerColor;
  ValueChanged<Color>? onColorChanged;
   List<Color>? availableColors;
   PickerLayoutBuilder? layoutBuilder;
   PickerItemBuilder? itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: orientation == Orientation.portrait ? 8 : 6,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      children: colors.map((Color color) => child(color)).toList(),
    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _BlockPickerState();
}

class _BlockPickerState extends State<BlockPicker> {
  Color? _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => _currentColor = color);
    widget.onColorChanged!(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder!(
      context,
      widget.availableColors!,
      (Color color, [bool? _, Function? __]) => widget.itemBuilder!(
          color, _currentColor!.value == color.value, () => changeColor(color)),
    );
  }
}

// ignore: must_be_immutable
class MultipleChoiceBlockPicker extends StatefulWidget {
   MultipleChoiceBlockPicker({Key? key,
    this.pickerColors,
    this.onColorsChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = BlockPicker.defaultLayoutBuilder,
    this.itemBuilder = BlockPicker.defaultItemBuilder,
  }) : super(key: key);

   List<Color>? pickerColors;
   ValueChanged<List<Color>>? onColorsChanged;
   List<Color>? availableColors;
   PickerLayoutBuilder? layoutBuilder;
   PickerItemBuilder? itemBuilder;

  @override
  State<StatefulWidget> createState() => _MultipleChoiceBlockPickerState();
}

class _MultipleChoiceBlockPickerState extends State<MultipleChoiceBlockPicker> {
  List<Color>? _currentColors;

  @override
  void initState() {
    _currentColors = widget.pickerColors;
    super.initState();
  }

  void toggleColor(Color color) {
    setState(() {
      _currentColors!.contains(color)
          ? _currentColors!.remove(color)
          : _currentColors!.add(color);
    });
    widget.onColorsChanged!(_currentColors!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder!(
      context,
      widget.availableColors!,
      (Color color, [bool? _, Function? __]) => widget.itemBuilder!(
        color,
        _currentColors!.contains(color),
        () => toggleColor(color),
      ),
    );
  }
}
