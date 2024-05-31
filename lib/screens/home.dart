import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltr/constants/style.dart';
import 'package:ltr/widgets/add_subject.dart';
import 'package:ltr/services/hive_service.dart';
import 'package:ltr/models/subject/subject.dart';
import 'package:ltr/utils/helper.dart';
import 'package:ltr/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Box subjectsBox = Hive.box('subjects');
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _loadSubjects() {
    setState(() {
      _subjects = HiveService().getSubjects();
    });
  }

  void _onSaveSubject(
      {required String name, required String color, int? index}) async {
    if (index == null) {
      await HiveService().addSubject(name, color);
    } else {
      await HiveService().updateSubject(
        index,
        name,
        color,
      );
    }
    _loadSubjects();
  }

  void _onSubjectMenuItemClick(String? selectedValue, int index) async {
    if (selectedValue == 'Delete') {
      await HiveService().deleteSubject(index);
      _loadSubjects();
    }
    if (selectedValue == 'Edit') {
      if (!mounted) return; // If not mounted, return immediately
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddSubjectDialog(
              onSave: _onSaveSubject,
              index: index,
              subjectName: _subjects[index].name,
              subjectColor: _subjects[index].color,
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Subject> indexedSubjects = _subjects.asMap();

    return Scaffold(
      // todo app bar to be replaced by Custom app bar
      appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
          leadingWidth: 150,
          leading: Padding(
              padding: const EdgeInsets.all(spacing1x),
              child: SvgPicture.asset(
                'assets/logo.svg',
                semanticsLabel: 'LTR Logo',
              ))),
      body: SingleChildScrollView(
        child: Align(
          // alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(spacing2x),
            child: SizedBox(
              width: 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          bottom: spacing2x, top: spacing3x),
                      child: Text('Subjects',
                          style: Theme.of(context).textTheme.headlineLarge)),
                  Wrap(
                    spacing: spacing2x,
                    runSpacing: spacing2x,
                    children: [
                      ...indexedSubjects.entries.map<Widget>((entry) {
                        int index = entry.key;
                        Subject subject = entry.value;

                        String bgHexString = subject.color;
                        String textHexString = bgToTextColor(subject.color);
                        int bgColorValue = hexToInt(bgHexString);
                        int textColorValue = hexToInt(textHexString);

                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.editor,
                                      arguments: {
                                        'subjectName': subject.name,
                                        'bgColor': bgColorValue,
                                        'textColor': textColorValue,
                                        'index': index
                                      });
                                },
                                style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all<
                                        Color>(Color(bgColorValue)),
                                    minimumSize: WidgetStateProperty.all<Size>(
                                        const Size(
                                            200, 150)), // Set the minimum size
                                    shape:
                                        WidgetStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                child: Text(subject.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Color(textColorValue)))),
                            Padding(
                              padding: const EdgeInsets.only(right: spacing1x),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      iconEnabledColor: Colors.white,
                                      icon: const Icon(Icons.more_vert,
                                          size: spacing2x),
                                      onChanged: (selectedValue) =>
                                          _onSubjectMenuItemClick(
                                              selectedValue, index),
                                      items: const [
                                    DropdownMenuItem(
                                      value: 'Edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, size: spacing2x),
                                          SizedBox(width: spacing2x),
                                          Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, size: spacing2x),
                                          SizedBox(width: spacing2x),
                                          Text('Delete'),
                                        ],
                                      ),
                                    ),
                                  ])),
                            )
                          ],
                        );
                      }),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddSubjectDialog(
                                    onSave: _onSaveSubject,
                                  );
                                });
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xFFABA9A9)),
                              minimumSize: WidgetStateProperty.all<Size>(
                                  const Size(200, 150)), // Set the minimum size
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add,
                                size: 22,
                                color: Colors.white,
                              ),
                              const SizedBox(height: spacing1x),
                              Text('Add a subject',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.white)),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
