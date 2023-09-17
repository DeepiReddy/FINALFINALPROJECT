import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:what/components/background_component.dart';
import 'package:what/components/strawberry.component.dart';
import 'package:what/inputs/joystick.dart';
import '../components/sammy.component.dart';
import '../constants/global.dart';

//Instead of HasDraggables, DragCallbacks
class PetGrab extends FlameGame with HasDraggablesBridge, HasCollisionDetection{
  int score = 50;

  late TextComponent _scoreText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();



    add(BackgroundComponent());

    add(SammyComponent(joystick: joystick));

    add(StrawberryComponent());

    add(joystick);


    //preloading audio
    FlameAudio.audioCache.loadAll(
      [
        Globals.eatingSound,
      ],

    );


    _scoreText = TextComponent(text: 'Score: $score',
      position: Vector2(365, 740),
      anchor: Anchor.bottomRight,
      textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
      ),
    );
    add(_scoreText);
  }

  @override
  void update(dt){
    super.update(dt);
    _scoreText.text = 'Score: $score';
  }
}