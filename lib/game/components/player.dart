import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  double speed = 150.0;
  Vector2 velocity = Vector2.zero();
  bool isJumping = false;
  int health = 3;
  int score = 0;

  Player() : super(size: Vector2(50.0, 75.0)) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(50.0, 75.0),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Gravity
    if (!isJumping) {
      velocity.y += 500 * dt;
    }

    // Screen bounds check
    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      isJumping = false;
    }
  }

  void jump() {
    if (!isJumping) {
      velocity.y = -300;
      isJumping = true;
    }
  }

  void moveLeft() {
    velocity.x = -speed;
  }

  void moveRight() {
    velocity.x = speed;
  }

  void stop() {
    velocity.x = 0;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
        jump();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moveLeft();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moveRight();
      }
    } else if (event is RawKeyUpEvent) {
      if (!keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
          !keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        stop();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with obstacles or enemies
    if (other is Enemy) {
      health -= 1;
      if (health <= 0) {
        removeFromParent();
        // Optionally, trigger game over or respawn logic here
      }
    }
  }

  void increaseScore(int points) {
    score += points;
  }
}