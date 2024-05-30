import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:ltr/widgets/flowy.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  late final EditorScrollController editorScrollController;
  late final EditorState editorState;

  @override
  void initState() {
    super.initState();

    final json = {
      "document": {
        "type": "page",
        "children": [
          {
            "type": "heading",
            "data": {
              "level": 2,
              "delta": [
                {"insert": "👋 "},
                {
                  "insert": "Welcome to",
                  "attributes": {"bold": true}
                },
                {"insert": " "},
                {
                  "insert": "LTR Editor",
                  "attributes": {"italic": false, "bold": true}
                }
              ],
              "align": "center"
            }
          },
          {
            "type": "paragraph",
            "data": {"delta": []}
          }
        ]
      }
    };

    editorState = EditorState(document: Document.fromJson(json));
    editorScrollController = EditorScrollController(
      editorState: editorState,
      shrinkWrap: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        leadingWidth: 150,
      ),
      body: SafeArea(
          child: DesktopEditor(
        editorState: editorState,
        textDirection: TextDirection.ltr,
      )),
    );
  }
}
