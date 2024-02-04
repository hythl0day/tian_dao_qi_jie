import 'package:flutter/material.dart';
import 'package:samsara/samsara.dart';
import 'package:samsara/event.dart';
import 'package:samsara/tilemap.dart';
import 'package:hetu_script/values.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:hetu_script/types.dart';
import 'package:samsara/ui/flutter/loading_screen.dart';
import 'package:samsara/console.dart';

import '../../../global.dart';
import '../../../scene/maze.dart';
import 'drop_menu.dart';
import '../hero_info.dart';
import '../history_panel.dart';
import '../../../event/events.dart';
import '../../dialog/game_over.dart';

class MazeOverlay extends StatefulWidget {
  static Future<bool?> show({
    required BuildContext context,
    required HTStruct mazeData,
    double priceFactor = 1.0,
  }) {
    return showDialog<bool?>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) {
        return MazeOverlay(
          key: UniqueKey(),
          mazeData: mazeData,
        );
      },
    );
  }

  const MazeOverlay({
    required super.key,
    required this.mazeData,
    this.startLevel = 0,
  });

  final HTStruct mazeData;

  final int startLevel;

  @override
  State<MazeOverlay> createState() => _MazeOverlayState();
}

class _MazeOverlayState extends State<MazeOverlay>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late MazeScene _scene;

  HTStruct? _heroData;

  late int _currentLevelIndex;

  bool _isDisposing = false;

  // late final HTStruct _heroData;

  @override
  void initState() {
    super.initState();

    engine.invoke('build', positionalArgs: [context]);
    _currentLevelIndex = widget.startLevel;
    // _heroData = engine.invoke('getHero');

    engine.hetu.interpreter.bindExternalFunction(
        'showMazeGameOver',
        (HTEntity object,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<HTType> typeArgs = const []}) =>
            // 脚本调用dart，dart又调用脚本，这种行为应该注意尽量避免
            // engine.invoke('leaveMaze');
            showDialog(
              context: context,
              builder: (BuildContext context) => const GameOver(),
            ),
        override: true);

    engine.hetu.interpreter.bindExternalFunction(
        'moveHeroToLastRouteNode',
        (HTEntity object,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<HTType> typeArgs = const []}) =>
            _scene.map.moveHeroToLastRouteNode(),
        override: true);

    engine.hetu.interpreter.bindExternalFunction(
        'setFogOfWar',
        (HTEntity object,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<HTType> typeArgs = const []}) =>
            _scene.map.showFogOfWar = positionalArgs.first,
        override: true);

    engine.hetu.interpreter.bindExternalFunction('setMazeSprite',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      _scene.map.setTerrainSprite(
          positionalArgs[0], positionalArgs[1], positionalArgs[2]);
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('setMazeOverlaySprite',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      _scene.map.setTerrainOverlaySprite(
          positionalArgs[0], positionalArgs[1], positionalArgs[2]);
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('setMazeObject',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      _scene.map.setTerrainObject(
          positionalArgs[0], positionalArgs[1], positionalArgs[2]);
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('addMazeObject',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      _scene.map.addObject(positionalArgs[0]);
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('proceedToNextLevel',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      assert(_currentLevelIndex < widget.mazeData['levels'].length);
      setState(() {
        ++_currentLevelIndex;
      });
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('backToPreviousLevel',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      assert(_currentLevelIndex > 0);
      setState(() {
        --_currentLevelIndex;
      });
    }, override: true);

    engine.hetu.interpreter.bindExternalFunction('disposeMaze',
        (HTEntity object,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<HTType> typeArgs = const []}) {
      Navigator.of(context).pop();
      for (final level in widget.mazeData['levels']) {
        final id = level['id'];
        engine.clearCache(id);
      }
      // 这里使用isDisposing来阻止在界面重绘时再次创建场景
      _isDisposing = true;
    }, override: true);

    engine.registerListener(
      GameEvents.mapTapped,
      EventHandler(
        ownerKey: widget.key!,
        handle: (event) {
          final hero = _scene.map.hero;
          if (hero == null) return;
          if (hero.isMoving) return;
          final terrain = _scene.map.selectedTerrain;
          if (terrain == null) return;
          List<int>? route;
          if (terrain.tilePosition != hero.tilePosition) {
            final start = engine.invoke('getTerrain',
                positionalArgs: [hero.left, hero.top, _scene.mapData]);
            final end = engine.invoke('getTerrain',
                positionalArgs: [terrain.left, terrain.top, _scene.mapData]);
            List? calculatedRoute = engine.invoke('calculateRoute',
                positionalArgs: [start, end, _scene.mapData],
                namedArgs: {'restrictedInZoneIndex': start['zoneIndex']});
            if (calculatedRoute != null) {
              route = List<int>.from(calculatedRoute);
              _scene.map.moveHeroToTilePositionByRoute(route);
            }
          }
        },
      ),
    );

    engine.registerListener(
      GameEvents.loadedMap,
      EventHandler(
        ownerKey: widget.key!,
        handle: (GameEvent event) async {
          final charSheet = SpriteSheet(
            image: await Flame.images.load('character/tile_character.png'),
            srcSize: heroSrcSize,
          );
          final shipSheet = SpriteSheet(
            image: await Flame.images.load('character/tile_ship.png'),
            srcSize: heroSrcSize,
          );
          _scene.map.hero = TileMapObject(
            engine: engine,
            sceneId: _scene.id,
            isHero: true,
            moveAnimationSpriteSheet: charSheet,
            swimAnimationSpriteSheet: shipSheet,
            left: _scene.mapData['entryX'],
            top: _scene.mapData['entryY'],
            tileShape: _scene.map.tileShape,
            tileMapWidth: _scene.map.tileMapWidth,
            gridWidth: _scene.map.gridWidth,
            gridHeight: _scene.map.gridHeight,
            srcWidth: heroSrcSize.x,
            srcHeight: heroSrcSize.y,
          );
          setState(() {});
        },
      ),
    );

    engine.registerListener(
      GameEvents.heroMoved,
      EventHandler(
        ownerKey: widget.key!,
        handle: (GameEvent event) async {
          final tile = _scene.map.getTerrainAtHero();
          assert(tile != null);
          if (_scene.map.hero != null) {
            final blocked = engine.invoke(
              'onHeroMovedOnMazeMap',
              namedArgs: {
                'left': tile!.left,
                'top': tile.top,
                'maze': widget.mazeData,
                'currentLevelIndex': _currentLevelIndex,
              },
            );
            if (blocked != null) {
              if (blocked) {
                _scene.map.moveHeroToLastRouteNode();
              } else {
                _scene.map.hero!.isMovingCanceled = true;
              }
            }
            setState(() {});
          }
        },
      ),
    );

    engine.registerListener(
      CustomEvents.needRebuildUI,
      EventHandler(
        ownerKey: widget.key!,
        handle: (GameEvent event) {
          if (!mounted) return;
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    engine.disposeListenders(widget.key!);
    // FlameAudio.bgm.stop();
    // FlameAudio.bgm.dispose();

    // _scene.detach();
    super.dispose();
  }

  Future<Scene?> _createLevel(HTStruct levelData) async {
    if (_isDisposing) return null;
    final scene = await engine.createScene('maze', levelData['id'], levelData)
        as MazeScene;
    _heroData = engine.invoke('getHero');
    return scene;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return _isDisposing
        ? LoadingScreen(text: engine.locale['loading'])
        : FutureBuilder(
            // 不知道为啥，这里必须用这种写法才能进入载入界面，否则一定会卡住
            future: Future.delayed(
              const Duration(milliseconds: 100),
              () => _createLevel(widget.mazeData['levels'][_currentLevelIndex]),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingScreen(text: engine.locale['loading']);
              } else {
                _scene = snapshot.data as MazeScene;
                if (_scene.isAttached) {
                  _scene.detach();
                }

                return Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      SceneWidget(scene: _scene),
                      if (_heroData != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: HeroInfoPanel(
                            heroData: _heroData!,
                          ),
                        ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: MazeDropMenu(
                          onSelected: (MazeDropMenuItems item) async {
                            switch (item) {
                              case MazeDropMenuItems.console:
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Console(engine: engine),
                                ).then((_) => setState(() {}));
                                break;
                              case MazeDropMenuItems.quit:
                                engine.invoke('leaveMaze',
                                    positionalArgs: [widget.mazeData]);
                                break;
                              default:
                            }
                          },
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: HistoryPanel(
                          title:
                              '${widget.mazeData['name']} ${widget.mazeData['levels'][_currentLevelIndex]['name']}',
                          heroId: _heroData?['id'],
                          historyData: widget.mazeData['history'],
                          showTileInfo: false,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
  }
}