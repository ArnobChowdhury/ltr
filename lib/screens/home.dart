import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltr/constants/style.dart';
import 'package:ltr/widgets/add_subject.dart';
import 'package:ltr/services/hive_service.dart';
import 'package:ltr/models/subject.dart';

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

  void _onAddSubject(String name, String color) async {
    await HiveService().addSubject(name, color);
    _loadSubjects();
  }

  void _onSubjectMenuItemClick(String? selectedValue, int index) async {
    if (selectedValue == 'Delete') {
      await HiveService().deleteSubject(index);
      _loadSubjects();
    }
    if (selectedValue == 'Edit') {
      // Edit this subject
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Subject> indexedSubjects = _subjects.asMap();

    final TextStyle subjectTextStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white);

    return Scaffold(
      // todo app bar to be replaced by Custom app bar
      appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.red[100],
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
                        String hexString = subject.color;
                        int colorValue = int.parse('FF$hexString', radix: 16);

                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // Take the user to the editor
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(colorValue)),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(
                                            200, 150)), // Set the minimum size
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)))),
                                child: Text(subject.name,
                                    style: subjectTextStyle)),
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
                                    onAdd: _onAddSubject,
                                  );
                                });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFABA9A9)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(200, 150)), // Set the minimum size
                              shape: MaterialStateProperty.all<
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
                              Text('Add a subject', style: subjectTextStyle),
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
