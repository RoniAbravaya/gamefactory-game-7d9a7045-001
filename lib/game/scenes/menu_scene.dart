import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// Represents the main menu scene in the game with title, play button,
/// level select, settings, and a simple background animation.
class MenuScene extends Component with TapDetector {
  late final TextComponent _title;
  late final SpriteComponent _playButton;
  late final SpriteComponent _levelSelectButton;
  late final SpriteComponent _settingsButton;
  late final SpriteAnimationComponent _backgroundAnimation;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBackgroundAnimation();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  /// Loads and sets up the background animation for the menu.
  void _loadBackgroundAnimation() {
    final spriteSheet = SpriteSheet(
      image: gameRef.images.fromCache('background_spritesheet.png'),
      srcSize: Vector2(1920.0, 1080.0),
    );
    _backgroundAnimation = SpriteAnimationComponent(
      animation: spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 10),
      size: gameRef.size,
    );
    add(_backgroundAnimation);
  }

  /// Loads and displays the game title.
  void _loadTitle() {
    _title = TextComponent(
      text: 'Test Claude Latest-platformer-01',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 48.0,
          color: Colors.white,
          fontFamily: 'Arial',
        ),
      ),
    )..anchor = Anchor.topCenter;
    _title.position = Vector2(gameRef.size.x / 2, gameRef.size.y * 0.1);
    add(_title);
  }

  /// Loads and sets up the play button.
  void _loadPlayButton() {
    _playButton = SpriteComponent(
      sprite: Sprite(gameRef.images.fromCache('play_button.png')),
      size: Vector2(150.0, 150.0),
      position: gameRef.size / 2 - Vector2(75.0, 75.0),
    );
    _playButton.add(TapAreaComponent(onTap: () {
      // Handle play button tap
    }));
    add(_playButton);
  }

  /// Loads and sets up the level select button.
  void _loadLevelSelectButton() {
    _levelSelectButton = SpriteComponent(
      sprite: Sprite(gameRef.images.fromCache('level_select_button.png')),
      size: Vector2(100.0, 100.0),
      position: Vector2(gameRef.size.x * 0.25 - 50.0, gameRef.size.y * 0.8 - 50.0),
    );
    _levelSelectButton.add(TapAreaComponent(onTap: () {
      // Handle level select button tap
    }));
    add(_levelSelectButton);
  }

  /// Loads and sets up the settings button.
  void _loadSettingsButton() {
    _settingsButton = SpriteComponent(
      sprite: Sprite(gameRef.images.fromCache('settings_button.png')),
      size: Vector2(100.0, 100.0),
      position: Vector2(gameRef.size.x * 0.75 - 50.0, gameRef.size.y * 0.8 - 50.0),
    );
    _settingsButton.add(TapAreaComponent(onTap: () {
      // Handle settings button tap
    }));
    add(_settingsButton);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_playButton.containsPoint(info.eventPosition.game)) {
      // Navigate to game play scene
    } else if (_levelSelectButton.containsPoint(info.eventPosition.game)) {
      // Navigate to level select scene
    } else if (_settingsButton.containsPoint(info.eventPosition.game)) {
      // Navigate to settings scene
    }
  }
}