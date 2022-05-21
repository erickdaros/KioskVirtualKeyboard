import 'key_action.dart';

class VirtualKeyboardKey {
  final String? value;
  final VirtualKeyboardKeyAction action;

  VirtualKeyboardKey({this.value, this.action = VirtualKeyboardKeyAction.writeValue});
}