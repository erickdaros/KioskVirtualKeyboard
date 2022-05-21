import 'package:flutter/material.dart';
import 'package:kiosk_virtual_keyboard/key.dart';
import 'package:kiosk_virtual_keyboard/key_action.dart';

import 'controller.dart';
import 'layout.dart';

class VirtualKeyboard extends StatefulWidget {
  final VirtualKeyboardController? controller;
  final TextEditingController textController;
  final FocusNode focusNode;

  const VirtualKeyboard(
      {Key? key,
      this.controller,
      required this.focusNode,
      required this.textController})
      : super(key: key);

  @override
  _VirtualKeyboardState createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  final _attached = ValueNotifier<bool>(true);
  final _layout = ValueNotifier<VirtualKeyboardLayout>(VirtualKeyboardLayout());

  bool isVisible = false;
  bool isShiftEnabled = false;

  late FocusNode? currentFocus;

  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {
        isVisible = widget.controller?.shouldShowKeyboard == true;
      });
    });
    super.initState();
    // _getCurrentFocus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getCurrentFocus() {
    currentFocus = FocusScope.of(context).focusedChild;
  }

  void _hide() {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).focusedChild?.unfocus();
    setState(() {
      isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      FocusScope.of(context).unfocus();
    }
    return FocusScope(
      canRequestFocus: false,
      child: isVisible
          ? Container(
              padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
              color: const Color(0xFF0A0A0A),//Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height / 3,
              child: ValueListenableBuilder<VirtualKeyboardLayout>(
                valueListenable: _layout,
                builder: (_, layout, __) {
                  return Column(
                    children: [
                      for (final keys in layout.keys)
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _attached,
                            builder: (_, attached, __) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: VirtualKeyboardRow(
                                  keys: keys,
                                  focusNode: widget.focusNode,
                                  enabled: attached,
                                  onInput: _handleKeyPress,
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          : Container(),
    );
  }

  void _handleKeyPress(VirtualKeyboardKey key) {
    widget.focusNode.requestFocus();
    final textController = widget.textController;
    final keyValue = key.value;
    switch (key.action) {
      case VirtualKeyboardKeyAction.writeValue:
        final text = textController.text;
        final selection = textController.selection;
        final newText = text.replaceRange(
            selection.start,
            selection.end,
            (isShiftEnabled
                    ? keyValue?.toUpperCase()
                    : keyValue?.toLowerCase()) ??
                "");
        textController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: selection.start + (keyValue?.length ?? 0)),
        );
        break;
      case VirtualKeyboardKeyAction.backspace:
        if (textController.text.isEmpty) return;
        // Remove selected character(s), fix selection position to end of edit
        final text = textController.text;
        final selection = textController.selection;
        String newText = "";
        int offset = 0;
        if (selection.baseOffset > 0 && selection.start != selection.end) {
          newText = text.replaceRange(selection.start, selection.end, "");
          offset = selection.start;
        } else if (selection.baseOffset > 0) {
          newText = text.substring(0, selection.baseOffset - 1) +
              text.substring(selection.baseOffset, text.length);
          offset = selection.baseOffset - 1;
        }
        textController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: offset),
        );
        break;
      case VirtualKeyboardKeyAction.enter:
        _hide();
        break;
      case VirtualKeyboardKeyAction.shift:
        setState(() {
          isShiftEnabled = !isShiftEnabled;
        });
        break;
      case VirtualKeyboardKeyAction.space:
        final text = textController.text;
        final selection = textController.selection;
        final newText = text.replaceRange(selection.start, selection.end, " ");
        textController.value = TextEditingValue(
          text: newText,
          selection:
              TextSelection.collapsed(offset: selection.start + " ".length),
        );
        break;
    }
    widget.focusNode.requestFocus();
  }
}

class VirtualKeyboardRow extends StatelessWidget {
  final bool _enabled;
  final List<VirtualKeyboardKey> _keys;
  final ValueSetter<VirtualKeyboardKey> _onInput;
  final FocusNode focusNode;

  const VirtualKeyboardRow(
      {Key? key,
      required bool enabled,
      required List<VirtualKeyboardKey> keys,
      required ValueSetter<VirtualKeyboardKey> onInput,
      required this.focusNode})
      : _enabled = enabled,
        _keys = keys,
        _onInput = onInput,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final key in _keys)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF2D2D2D)//Colors.grey.shade900, //Color(0xffd1daf2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTapDown: (t) {
                      focusNode.requestFocus();
                    },
                    onTap: _enabled ? () => _onInput(key) : null,
                    child: Center(
                      child: Text(key.value ?? "", style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
