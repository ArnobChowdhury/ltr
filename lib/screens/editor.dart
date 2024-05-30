import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:ltr/widgets/flowy.dart';
import 'package:ltr/widgets/folder_tree.dart';

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
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final subjectName = arguments?['subjectName'];
    final bgColor = arguments?['bgColor'];
    final textColor = arguments?['textColor'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName ?? 'LTR Editor',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Color(textColor)),
        ),
        backgroundColor: Color(bgColor),
        iconTheme: IconThemeData(
          color: Color(textColor), // Change your desired color here
        ),
      ),
      body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 300,
          color: Colors.grey[200],
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: FolderTree()),
            ],
          ),
        ),
        Expanded(
          child: DesktopEditor(
            editorState: editorState,
            textDirection: TextDirection.ltr,
          ),
        ),
      ]),
    );
  }
}
