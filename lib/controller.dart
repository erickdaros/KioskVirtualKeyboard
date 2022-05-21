import 'package:flutter/widgets.dart';

class VirtualKeyboardController extends ChangeNotifier {
  bool shouldShowKeyboard = false;

  void show() {
    shouldShowKeyboard = true;
    notifyListeners();
  }

  void hide() {
    shouldShowKeyboard = false;
    notifyListeners();
  }
}