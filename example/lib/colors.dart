import 'package:flutter/material.dart';

const MaterialColor black = MaterialColor(_blackPrimaryValue, <int, Color>{
  50: Color(0xFFE3E3E3),
  100: Color(0xFFB9B9B9),
  200: Color(0xFF8A8A8A),
  300: Color(0xFF5B5B5B),
  400: Color(0xFF373737),
  500: Color(_blackPrimaryValue),
  600: Color(0xFF121212),
  700: Color(0xFF0E0E0E),
  800: Color(0xFF0B0B0B),
  900: Color(0xFF060606),
});
const int _blackPrimaryValue = 0xFF141414;

const MaterialColor blackAccent = MaterialColor(_blackAccentValue, <int, Color>{
  100: Color(0xFFFF4E4E),
  200: Color(_blackAccentValue),
  400: Color(0xFFE70000),
  700: Color(0xFFCE0000),
});
const int _blackAccentValue = 0xFFFF1B1B;
