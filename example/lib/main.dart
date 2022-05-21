import 'package:flutter/material.dart';
import 'package:kiosk_virtual_keyboard/kiosk_virtual_keyboard.dart';
import 'colors.dart' as colors;

void main() {
  runApp(const KioskVirtualKeyboardExample());
}

class KioskVirtualKeyboardExample extends StatelessWidget {
  const KioskVirtualKeyboardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appName = 'Kiosk Virtual Keyboard';
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        platform: TargetPlatform.android,
        primarySwatch: colors.black,
      ),
      home: RotatedBox( quarterTurns: 0, child: KeyboardExamplePage(title: appName)),
    );
  }
}

class KeyboardExamplePage extends StatefulWidget {
  const KeyboardExamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<KeyboardExamplePage> createState() => _KeyboardExamplePageState();
}

class _KeyboardExamplePageState extends State<KeyboardExamplePage> {

  late TextEditingController _textEditingController;
  final _virtualKeyboardFocusNode = FocusNode();
  late VirtualKeyboardController _virtualKeyboardController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _virtualKeyboardController = VirtualKeyboardController();
    _virtualKeyboardFocusNode.addListener(() { 
       if(_virtualKeyboardFocusNode.hasFocus) {
        _virtualKeyboardController.show();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: _textEditingController,
              focusNode: _virtualKeyboardFocusNode,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          const Spacer(),
          Theme(
            data: ThemeData.dark().copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
              ),
            ),
            child: VirtualKeyboard (
              controller: _virtualKeyboardController,
              textController: _textEditingController,
              focusNode: _virtualKeyboardFocusNode,
            ),
          ),
        ],
      ),
    );
  }
}
