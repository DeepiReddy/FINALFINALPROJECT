import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:what/games/pet_grab.dart';
import '../constants/global.dart';

enum MovementState {
  idle,
  slideLeft,
  slideRight,
}

class SammyComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<PetGrab> {

  final double _spriteHeight = 300;

  final double _speed = 500;
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  JoystickComponent joystick;

  SammyComponent({required this.joystick});

    @override
    Future<void> onLoad() async {
      await super.onLoad();

      Sprite sammyIdle = await gameRef.loadSprite(Globals.sammySprite);
      Sprite sammyLeft = await gameRef.loadSprite(Globals.sammyLeftSprite);
      Sprite sammyRight = await gameRef.loadSprite(Globals.sammyRightSprite);

      sprites = {
        MovementState.idle: sammyIdle,
        MovementState.slideLeft: sammyLeft,
        MovementState.slideRight: sammyRight,
      };

      _rightBound = gameRef.size.x - 1;
      _leftBound = 1;
      _upBound = 200;
      _downBound = gameRef.size.y + 100;

      current = MovementState.idle;


      // 1.2, stands by the door
      position = gameRef.size / 1.2;
      height = _spriteHeight;
      width = _spriteHeight * 0.7;
      anchor = Anchor.bottomCenter;

      add(CircleHitbox());
    }


    @override
    void update(dt) {
      super.update(dt);

      if (joystick.direction == JoystickDirection.idle) {
        current = MovementState.idle;
        return;
      }

      if (x >= _rightBound) {
        x = _rightBound - 1;
      }

      if (x <= _leftBound) {
        x = _leftBound + 1;
      }

      if (y <= _upBound) {
        y = _upBound + 1;
      }

      if (y >= _downBound) {
        y = _downBound - 1;
      }


      bool movingLeft = joystick.relativeDelta[0] < 0;

      if (movingLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }

      position.add(joystick.relativeDelta * _speed * dt);
    }
  }
