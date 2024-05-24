import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:hive/hive.dart';
import 'package:ltr/constants/style.dart';

class AddSubjectDialog extends StatefulWidget {
  final Function onAdd;

  const AddSubjectDialog({required this.onAdd, super.key});

  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  static const Color blue = Color(0xFF2767A1);
  static const Color paste = Color(0xFF037B79);
  static const Color green = Color(0xFF5D9476);
  static const Color pink = Color(0xFFAE4A5C);
  static const Color orange = Color(0xFFF77C43);
  static const Color yellow = Color(0xFFF2C749);
  static const Color yellowGreen = Color(0xFFADAE80);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(blue): 'Blue',
    ColorTools.createPrimarySwatch(paste): 'Paste',
    ColorTools.createPrimarySwatch(green): 'Green',
    ColorTools.createPrimarySwatch(pink): 'Pink',
    ColorTools.createPrimarySwatch(orange): 'Orange',
    ColorTools.createPrimarySwatch(yellow): 'Yellow',
    ColorTools.createPrimarySwatch(yellowGreen): 'YellowGreen',
  };

  Color _selectedColor = blue; // Default color
  String _subjectName = '';

  @override
  Widget build(BuildContext context) {
    final subjects = Hive.box('subjects');

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(spacing3x),
        child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add a subject',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: spacing3x),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _subjectName = value;
                    });
                  },
                ),
                const SizedBox(height: spacing4x),
                // color picker
                Text('Pick a color',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: spacing3x),
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                    ColorPickerType.custom: true,
                  },
                  customColorSwatchesAndNames: colorsNameMap,
                  color: _selectedColor,
                  padding: const EdgeInsets.all(0.0),
                  spacing: spacing1x,
                  runSpacing: spacing1x,
                  enableShadesSelection: false,
                  borderRadius: 20,
                  width: 20.0,
                  height: 20.0,
                  onColorChanged: (color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                ),
              ],
            )),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_subjectName.isEmpty) {
              return;
            }
            List<dynamic> existingSubjects =
                subjects.get('subs', defaultValue: []);
            existingSubjects
                .add({"name": _subjectName, "color": _selectedColor.hex});
            await subjects.put('subs', existingSubjects);

            widget.onAdd();

            if (!mounted) return; // If not mounted, return immediately
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
