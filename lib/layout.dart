import 'package:kiosk_virtual_keyboard/key_action.dart';

import 'key.dart';
import 'type.dart';

class VirtualKeyboardLayout {
  final VirtualKeyboardType _type;

  VirtualKeyboardLayout([this._type = VirtualKeyboardType.text]);

  bool get _isNumeric => _type == VirtualKeyboardType.number;

  List<List<VirtualKeyboardKey>> get keys {
    return _isNumeric ? _number : _text;
  }

  List<List<VirtualKeyboardKey>> get _text {
    return [
      [VirtualKeyboardKey(value: '1'), VirtualKeyboardKey(value: '2'), VirtualKeyboardKey(value: '3'), VirtualKeyboardKey(value: '4'), VirtualKeyboardKey(value: '5'), VirtualKeyboardKey(value: '6'), VirtualKeyboardKey(value: '7'), VirtualKeyboardKey(value: '8'), VirtualKeyboardKey(value: '9'), VirtualKeyboardKey(value: '0')],
      [VirtualKeyboardKey(value: 'Q'), VirtualKeyboardKey(value: 'W'), VirtualKeyboardKey(value: 'E'), VirtualKeyboardKey(value: 'R'), VirtualKeyboardKey(value: 'T'), VirtualKeyboardKey(value: 'Y'), VirtualKeyboardKey(value: 'U'), VirtualKeyboardKey(value: 'I'), VirtualKeyboardKey(value: 'O'), VirtualKeyboardKey(value: 'P')],
      [VirtualKeyboardKey(value: 'A'), VirtualKeyboardKey(value: 'S'), VirtualKeyboardKey(value: 'D'), VirtualKeyboardKey(value: 'F'), VirtualKeyboardKey(value: 'G'), VirtualKeyboardKey(value: 'H'), VirtualKeyboardKey(value: 'J'), VirtualKeyboardKey(value: 'K'), VirtualKeyboardKey(value: 'L')],
      [VirtualKeyboardKey(action: VirtualKeyboardKeyAction.shift), VirtualKeyboardKey(value: 'Z'), VirtualKeyboardKey(value: 'X'), VirtualKeyboardKey(value: 'C'), VirtualKeyboardKey(value: 'V'), VirtualKeyboardKey(value: 'B'), VirtualKeyboardKey(value: 'N'), VirtualKeyboardKey(value: 'M'), VirtualKeyboardKey(action: VirtualKeyboardKeyAction.backspace)],
      [VirtualKeyboardKey(value: '_'), VirtualKeyboardKey(value: ','), VirtualKeyboardKey(action: VirtualKeyboardKeyAction.space), VirtualKeyboardKey(value: '.'), VirtualKeyboardKey(action: VirtualKeyboardKeyAction.enter)],
    ];
  }

  List<List<VirtualKeyboardKey>> get _number {
    return [
      [VirtualKeyboardKey(value: '1'), VirtualKeyboardKey(value: '2'), VirtualKeyboardKey(value: '3')],
      [VirtualKeyboardKey(value: '4'), VirtualKeyboardKey(value: '5'), VirtualKeyboardKey(value: '6')],
      [VirtualKeyboardKey(value: '7'), VirtualKeyboardKey(value: '8'), VirtualKeyboardKey(value: '9')],
      [VirtualKeyboardKey(value: ','), VirtualKeyboardKey(value: '0'), VirtualKeyboardKey(value: '.')],
    ];
  }
}