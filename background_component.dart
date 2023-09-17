import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:what/games/pet_grab.dart';

import '../constants/global.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<PetGrab> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.backgroundSprite);
    size = gameRef.size;

  }


}