import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:ltr/constants/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltr/models/folder/folder.dart';

class FolderTree extends StatefulWidget {
  final Function(String name) onFolderCreationAtRoot;
  final TreeController<Folder> treeController;

  const FolderTree(
      {required this.onFolderCreationAtRoot,
      required this.treeController,
      super.key});

  @override
  State<FolderTree> createState() => _FolderTreeState();
}

class _FolderTreeState extends State<FolderTree> {
  // @override
  // void didUpdateWidget(covariant FolderTree oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.treeController != widget.treeController) {
  //     widget.treeController.dispose();
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   widget.treeController.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  void dispose() {
    widget.treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: spacing2x),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // we handle folder creation here
                    widget.onFolderCreationAtRoot("Giraffe");
                  },
                  icon: const Icon(Icons.create_new_folder_outlined),
                  tooltip: "Create a virtual folder",
                ),
                const SizedBox(width: spacing1x),
                IconButton(
                  onPressed: () {
                    // we handle file creation here
                  },
                  // color need to be changed
                  icon: SvgPicture.asset(
                    'assets/add_file.svg',
                    semanticsLabel: 'Add file icon',
                  ),
                  tooltip: "Create a virtual file",
                ),
              ],
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: AnimatedTreeView<Folder>(
                treeController: widget.treeController,
                nodeBuilder: (BuildContext context, TreeEntry<Folder> entry) {
                  return TreeIndentation(
                    entry: entry,
                    child: Row(
                      children: [
                        if (entry.hasChildren)
                          ExpandIcon(
                            key: GlobalObjectKey(entry.node),
                            isExpanded: entry.isExpanded,
                            onPressed: (_) => widget.treeController
                                .toggleExpansion(entry.node),
                          )
                        else
                          const SizedBox(
                            height: 40,
                            width: 8,
                          ),
                        Flexible(
                            child: InkWell(
                          child: Text(entry.node.name),
                          onTap: () =>
                              widget.treeController.toggleExpansion(entry.node),
                        ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
