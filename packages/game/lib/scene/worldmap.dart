import 'package:flutter/widgets.dart';
import 'package:samsara/samsara.dart';
import 'package:samsara/event.dart';
import 'package:samsara/tilemap.dart';
import 'package:hetu_script/values.dart';

import '../global.dart';

class WorldMapScene extends Scene {
  final TileMap map;

  HTStruct worldData;

  TextStyle captionStyle;

  WorldMapScene({
    required this.worldData,
    required super.controller,
    required this.captionStyle,
  })  : map = TileMap(
          engine: engine,
          captionStyle: captionStyle,
          tileShape: TileShape.hexagonalVertical,
          gridWidth: 32.0,
          gridHeight: 28.0,
          tileSpriteSrcWidth: 32.0,
          tileSpriteSrcHeight: 48.0,
          tileOffsetX: 0.0,
          tileOffsetY: 2.0,
          scaleFactor: 2.0,
          showClouds: true,
          showSelected: false,
          showFogOfWar: false,
        ),
        super(id: worldData['id'], key: 'worldmap');

  bool isMapReady = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await map.updateData(worldData);
    add(map);
    isMapReady = true;
    engine
        .broadcast(MapLoadedEvent(isNewGame: worldData['isNewGame'] ?? false));
  }
}
