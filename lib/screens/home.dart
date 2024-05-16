import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltr/constants/style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Align(
        // alignment: Alignment.center,
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
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align buttons to the left
                  children: [
                    TextButton(
                        onPressed: () {
                          // Add your button action here
                          print('Button 1 pressed!');
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF5D9476)),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(200, 150)), // Set the minimum size
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        child: Text('Physics', style: subjectTextStyle)),
                    const SizedBox(width: 10), // Add space between buttons
                    TextButton(
                        onPressed: () {
                          // Add your button action here
                          print('Button 2 pressed!');
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
                            const SizedBox(height: 8),
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
    );
  }
}
