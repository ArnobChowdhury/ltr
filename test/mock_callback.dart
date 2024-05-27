import 'package:mockito/mockito.dart';

class MockCallback extends Mock {
  void onAdd({required String name, required String color, int? index}) {}
}
