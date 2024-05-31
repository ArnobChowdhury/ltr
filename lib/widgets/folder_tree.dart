import 'package:flutter/material.dart';
import 'package:ltr/constants/style.dart';
import 'package:flutter_svg/svg.dart';

class FolderTree extends StatelessWidget {
  const FolderTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: spacing2x),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                // we handle folder creation here
              },
              icon: const Icon(Icons.create_new_folder_outlined),
              tooltip: "Create a virtual file",
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
        ));
  }
}
