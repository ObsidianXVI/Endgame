library endgame;

import 'package:flutter/material.dart';
import 'package:demoncore_engine/demoncore_engine.dart';

part './asset_man.dart';

final EndgameAssetManager assetManager = EndgameAssetManager();
final DemoncoreEngine demoncore = DemoncoreEngine(
  assetManager: assetManager,
);

void main() {
  runApp(const Endgame());
}

class Endgame extends StatelessWidget {
  const Endgame({super.key});

  static final GlobalKey asKey = GlobalKey();
  static final Map<TilePosition, GlobalKey> sgkeys = {};
  static final Map<TilePosition, GlobalKey> egkeys = {};

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GameCanvas gameCanvas = GameCanvas(
      tileSize: 40,
      stepSize: 20,
      backgroundColor: Colors.blue.shade900,
      gameMapBuilder: GameMapBuilder(
        buildMap: (GameCanvas gameCanvas) {
          return GameMap(
            gameCanvas: gameCanvas,
            rows: 20,
            cols: 20,
            activeSprite: ExtrudedControllableSprite(
              key: asKey,
              baseImage: assetManager.dinoImg,
              width: 2 * 40,
              height: 3 * 40,
              gameCanvas: gameCanvas,
            ),
            tileSpriteGenerator: (TilePosition tilePosition) {
              if ((tilePosition.colNum > 5 && tilePosition.colNum < 15) ||
                  (tilePosition.rowNum > 5 && tilePosition.rowNum < 15)) {
                return StaticTileSprite(
                  key: sgkeys.putIfAbsent(tilePosition, () => GlobalKey()),
                  tilePosition: tilePosition,
                  baseImage: assetManager.groundImg,
                  gameCanvas: gameCanvas,
                );
              } else {
                if (tilePosition.colNum == 5 && tilePosition.rowNum < 5) {
                  return ExtrudedStaticTileSprite(
                    key: egkeys.putIfAbsent(tilePosition, () => GlobalKey()),
                    tilePosition: tilePosition,
                    baseImage: assetManager.wallImg,
                    gameCanvas: gameCanvas,
                  );
                } else {
                  return StaticTileSprite(
                    key: sgkeys.putIfAbsent(tilePosition, () => GlobalKey()),
                    tilePosition: tilePosition,
                    baseImage: assetManager.nullImg,
                    gameCanvas: gameCanvas,
                  );
                }
              }
            },
          );
        },
      ),
    );
    return MaterialApp(
      title: 'Endgame',
      home: gameCanvas,
    );
  }
}
