import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:ltr/widgets/flowy.dart';
import 'package:ltr/widgets/folder_tree.dart';
import 'package:ltr/services/hive_service.dart';
import 'package:ltr/models/folder/folder.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  late final EditorScrollController editorScrollController;
  late final EditorState editorState;
  late final String subjectName;
  late final int subjectIndex;
  late final int bgColor;
  late final int textColor;

  List<Folder> _folders = [];

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    subjectName = arguments?['subjectName'];
    subjectIndex = arguments?['index'];
    bgColor = arguments?['bgColor'];
    textColor = arguments?['textColor'];

    // load all the folders for this subject
    _loadFolders(subjectIndex);
  }

  void _loadFolders(int subjectIndex) {
    setState(() {
      _folders = HiveService().getFolders(subjectIndex);
    });
  }

  void _onFolderCreationAtRoot(String name) async {
    HiveService hiveService = HiveService();
    final subject = hiveService.getOneSubject(subjectIndex);

    if (subject != null) {
      await hiveService.addFolder(
        name: name,
        subject: subject,
      );
      _loadFolders(subjectIndex);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final List<Folder> roots = _folders;

    final treeController = TreeController<Folder>(
      roots: roots,
      childrenProvider: (Folder node) => node.children,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: FolderTree(
                onFolderCreationAtRoot: _onFolderCreationAtRoot,
                treeController: treeController,
              )),
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
