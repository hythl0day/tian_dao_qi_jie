import 'package:samsara/samsara.dart';
import 'package:samsara/event.dart';
import 'package:samsara/tilemap.dart';
import 'package:hetu_script/values.dart';

import '../global.dart';

class MazeScene extends Scene {
  late final TileMap map;

  HTStruct mapData;

  MazeScene({required this.mapData, required super.controller})
      : map = TileMap(
          engine: engine,
          tileShape: TileShape.hexagonalVertical,
          gridWidth: 32.0,
          gridHeight: 28.0,
          tileSpriteSrcWidth: 32.0,
          tileSpriteSrcHeight: 48.0,
          tileOffsetX: 0.0,
          tileOffsetY: 2.0,
          scaleFactor: 2.0,
          showClouds: false,
          showSelected: false,
          showFogOfWar: true,
        ),
        super(id: mapData['id'], key: 'maze');

  bool isMapReady = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await map.updateData(mapData);
    add(map);
    isMapReady = true;
    engine.broadcast(const MapLoadedEvent());
  }
}
