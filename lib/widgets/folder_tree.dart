import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:ltr/constants/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltr/models/folder/folder.dart';

class FolderTree extends StatelessWidget {
  final Function(String name) onFolderCreationAtRoot;
  final TreeController<Folder> treeController;

  const FolderTree(
      {required this.onFolderCreationAtRoot,
      required this.treeController,
      super.key});

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
                    onFolderCreationAtRoot("Giraffe");
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
                treeController: treeController,
                nodeBuilder: (BuildContext context, TreeEntry<Folder> entry) {
                  return InkWell(
                    onTap: () => treeController.toggleExpansion(entry.node),
                    child: TreeIndentation(
                      guide: const IndentGuide.connectingLines(indent: 48),
                      entry: entry,
                      child: Text(entry.node.name),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
