import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 20,
    paint: BasicPalette.transparent.withAlpha(50).paint(),
    ),
    background: CircleComponent(
      radius: 55,
      paint: BasicPalette.transparent.withAlpha(50).paint(),
    ),
    margin: const EdgeInsets.only(left: 35, bottom: 30),
  );

