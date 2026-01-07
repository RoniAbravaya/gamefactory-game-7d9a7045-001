import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

/// A component representing an obstacle in a platformer game.
/// It includes a visual representation, collision detection, and damage dealing behavior.
class Obstacle extends PositionComponent with HasGameRef, Hitbox, Collidable {
  final Vector2 _size;
  final Paint _paint;
  final double _damage;

  /// Creates a new obstacle component.
  /// 
  /// [size] specifies the size of the obstacle.
  /// [color] specifies the color of the obstacle for its visual representation.
  /// [damage] specifies the amount of damage the obstacle deals on collision.
  Obstacle({
    required Vector2 size,
    required Color color,
    double damage = 1.0,
  })  : _size = size,
        _damage = damage,
        _paint = Paint()..color = color {
    addShape(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = _size;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  /// Gets the damage dealt by the obstacle.
  double get damage => _damage;
}