part of endgame;

class EndgameAssetManager extends AssetManager {
  EndgameAssetManager()
      : super(imageRepository: {
          'dino': const AssetImage('dino.png'),
          'ground': const AssetImage('ground.png'),
          'wall': const AssetImage('wall.png'),
          'null': const AssetImage('null_tile.png'),
        });

  AssetImage get dinoImg => imageRepository['dino']!;
  AssetImage get wallImg => imageRepository['wall']!;
  AssetImage get groundImg => imageRepository['ground']!;
  AssetImage get nullImg => imageRepository['null']!;
}
