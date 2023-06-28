import 'package:flutter/material.dart';

const MaterialColor basetheme =
    MaterialColor(_basethemePrimaryValue, <int, Color>{
  50: Color(0xFFF8FAFD),
  100: Color(0xFFEEF4FA),
  200: Color(0xFFE3ECF6),
  300: Color(0xFFD7E4F2),
  400: Color(0xFFCFDFF0),
  500: Color(_basethemePrimaryValue),
  600: Color(0xFFC0D5EB),
  700: Color(0xFFB9CFE8),
  800: Color(0xFFB1CAE5),
  900: Color(0xFFA4C0E0),
});
const int _basethemePrimaryValue = 0xFFC6D9ED;

const MaterialColor basethemeAccent =
    MaterialColor(_basethemeAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_basethemeAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _basethemeAccentValue = 0xFFFFFFFF;
