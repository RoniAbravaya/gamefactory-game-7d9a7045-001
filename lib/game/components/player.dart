import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  double speed = 200.0;
  Vector2 direction = Vector2.zero();
  bool isJumping = false;
  final double jumpSpeed = -300;
  final double gravity = 1000;
  double health = 100;
  bool isInvulnerable = false;
  final double invulnerabilityTime = 2.0; // seconds
  double currentInvulnerabilityTime = 0;

  Player()
      : super(size: Vector2(48, 48), anchor: Anchor.center) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(48, 48),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    handleMovement(dt);
    handleJump(dt);
    handleInvulnerability(dt);
  }

  void handleMovement(double dt) {
    position.add(direction * speed * dt);
    direction = Vector2.zero();
  }

  void handleJump(double dt) {
    if (isJumping) {
      speed += gravity * dt;
    } else {
      speed = 0;
    }
    position.y += speed * dt;
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      speed = jumpSpeed;
    }
  }

  void moveLeft() {
    direction = Vector2(-1, 0);
  }

  void moveRight() {
    direction = Vector2(1, 0);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Obstacle && !isInvulnerable) {
      takeDamage(20);
    } else if (other is Collectible) {
      collectItem(other);
    }
  }

  void takeDamage(double damage) {
    if (!isInvulnerable) {
      health -= damage;
      isInvulnerable = true;
      currentInvulnerabilityTime = invulnerabilityTime;
    }
  }

  void handleInvulnerability(double dt) {
    if (isInvulnerable) {
      currentInvulnerabilityTime -= dt;
      if (currentInvulnerabilityTime <= 0) {
        isInvulnerable = false;
      }
    }
  }

  void collectItem(Collectible item) {
    // Implement item collection logic
  }

  bool get isAlive => health > 0;
}

class Obstacle extends SpriteComponent with Hitbox, Collidable {
  Obstacle() {
    addHitbox(HitboxRectangle());
  }
}

class Collectible extends SpriteComponent with Hitbox, Collidable {
  Collectible() {
    addHitbox(HitboxRectangle());
  }
}