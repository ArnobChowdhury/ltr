import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:ltr/constants/style.dart';
import 'package:ltr/utils/helper.dart';

class AddSubjectDialog extends StatefulWidget {
  final String? subjectName;
  final String? subjectColor;
  final int? index;
  final Function({required String name, required String color, int? index})
      onSave;

  const AddSubjectDialog(
      {required this.onSave,
      this.subjectName,
      this.subjectColor,
      this.index,
      super.key});

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

  late TextEditingController _subjectNameController;
  Color _selectedColor = blue; // Default color

  @override
  void initState() {
    super.initState();
    _subjectNameController = TextEditingController(text: widget.subjectName);
    if (widget.subjectColor != null) {
      _selectedColor = Color(
          hexToInt(widget.subjectColor != null ? widget.subjectColor! : ''));
    }
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(spacing3x),
        child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject name',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: spacing3x),
                TextField(
                  controller: _subjectNameController,
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
            if (_subjectNameController.text.isEmpty) {
              // show error message
              return;
            }
            widget.onSave(
                name: _subjectNameController.text,
                color: _selectedColor.hex,
                index: widget.index);

            if (!mounted) return; // If not mounted, return immediately
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
