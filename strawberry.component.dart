import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:what/components/sammy.component.dart';
import 'package:what/games/pet_grab.dart';
import '../constants/global.dart';

class StrawberryComponent extends SpriteComponent
    with HasGameRef<PetGrab>, CollisionCallbacks {

  final double _spriteHeight = 100;

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.strawberrySprite);
    height = width = _spriteHeight;
    position = _getRandomPosition();
    anchor = Anchor.center;

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SammyComponent) {
      FlameAudio.play(Globals.eatingSound);

      removeFromParent();

      gameRef.score -= 5;

      gameRef.add(StrawberryComponent());
    }
  }


  Vector2 _getRandomPosition(){
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();


    return Vector2(x, y);
  }
}
