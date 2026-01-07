import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

/// A collectible item component for a platformer game that players can pick up for points.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  /// The score value this collectible adds when collected.
  final int scoreValue;

  /// Indicates whether this collectible has been collected.
  bool _collected = false;

  /// Constructs a new [Collectible] with a given [scoreValue].
  Collectible({
    required Sprite sprite,
    required Vector2 position,
    required Vector2 size,
    this.scoreValue = 100,
  }) : super(sprite: sprite, position: position, size: size) {
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Optional animation for the collectible item (e.g., spinning, floating)
    add(RotateEffect.by(1.0, EffectController(duration: 2, infinite: true)));
  }

  /// Handles the logic when a collectible is collected by the player.
  void collect() {
    if (!_collected) {
      _collected = true;
      // Play a sound effect upon collection
      FlameAudio.play('collectible_sound.mp3');
      // Optionally, add logic to add the score value to the player's total score here.
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Implement collision detection logic to determine if the other component is the player.
    // If so, call the collect method.
    // This is a placeholder for the actual player collision detection.
    if (other is Player) { // Assuming there's a Player class that represents the player.
      collect();
    }
  }
}