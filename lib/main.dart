library endgame;

import 'package:flutter/material.dart';
import 'package:demoncore_engine/demoncore_engine.dart';

part './asset_man.dart';

final EndgameAssetManager assetManager = EndgameAssetManager();

class House extends MapComponent {
  @override
  List<SpriteBlueprint> createBlueprints() {
    final List<SpriteBlueprint> layers = [];
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 40; j++) {
        layers.add(
          StaticTileSprite(
            assetImage: assetManager.groundImg,
            position: RelativeTilePosition(i, j),
          ),
        );
        if (i == 20 || i == 0 || j == 0 || j == 20) {
          layers.add(
            StaticTileSprite(
              assetImage: assetManager.wallImg,
              position: RelativeTilePosition(i, j),
            ),
          );
        }
      }
    }
    return layers;
  }
}

void main() {
  runApp(
    DemoncoreEngine(
      title: 'Endgame',
      assetManager: assetManager,
      debugConfigs: const DebugConfigs(
        showSpriteBounds: true,
      ),
      initialGameView: 'games/dino',
      gameViews: {
        'games/dino': (BuildContext buildContext) {
          return GameCanvas(
            tileSize: 40,
            stepSize: 40,
            backgroundColor: Colors.blue.shade900,
            gameMapBuilder: GameMapBuilder(
              map: House(),
              controllableSprite: ExtrudedControllableSprite(
                position: RelativeTilePosition(15, 15),
                assetImage: assetManager.dinoImg,
                width: 2 * 40,
                height: 3 * 40,
              ),
            ),
          );
        }
      },
    ),
  );
}
