import 'dart:ui';

import 'package:hetu_script/values.dart';

import 'event.dart';
import '../tilemap/tile.dart';
import '../tilemap/actor.dart';

abstract class Events {
  static const createdScene = 'created_scene';
  static const loadingScene = 'loading_scene';
  static const endedScene = 'ended_scene';
  static const loadedMap = 'loaded_map';
  static const tappedMap = 'tapped_tile';
  static const checkTerrain = 'checkTerrain';
  static const enteredLocation = 'entered_location';
  static const leftLocation = 'left_location';
  static const incidentOccurred = 'incident_occurred';
  static const heroMoved = 'hero_moved_on_worldmap';
}

class SceneEvent extends GameEvent {
  final String sceneKey;

  const SceneEvent({
    required String eventName,
    required this.sceneKey,
  }) : super(eventName);

  const SceneEvent.created({required String sceneKey})
      : this(eventName: Events.createdScene, sceneKey: sceneKey);

  const SceneEvent.loading({required String sceneKey})
      : this(eventName: Events.loadingScene, sceneKey: sceneKey);

  const SceneEvent.ended({required String sceneKey})
      : this(eventName: Events.endedScene, sceneKey: sceneKey);
}

class MapLoadedEvent extends GameEvent {
  final bool isNewGame;

  const MapLoadedEvent({this.isNewGame = false}) : super(Events.loadedMap);
}

class MapInteractionEvent extends GameEvent {
  final Offset? globalPosition;

  final TileMapTerrain? terrain;
  final TileMapActor? actor;

  const MapInteractionEvent.mapTapped(
      {required this.globalPosition, this.terrain, this.actor})
      : super(Events.tappedMap);

  const MapInteractionEvent.checkTerrain({required this.terrain, this.actor})
      : globalPosition = null,
        super(Events.checkTerrain);

  const MapInteractionEvent.heroMoved()
      : terrain = null,
        actor = null,
        globalPosition = null,
        super(Events.heroMoved);
}

class LocationEvent extends GameEvent {
  final String locationId;

  const LocationEvent({
    required String eventName,
    required this.locationId,
  }) : super(eventName);

  const LocationEvent.entered({required String locationId})
      : this(eventName: Events.enteredLocation, locationId: locationId);

  const LocationEvent.left({required String locationId})
      : this(eventName: Events.leftLocation, locationId: locationId);
}

class HistoryEvent extends GameEvent {
  final HTStruct data;

  const HistoryEvent({
    required String eventName,
    required this.data,
  }) : super(eventName);

  const HistoryEvent.occurred({required HTStruct data})
      : this(eventName: Events.incidentOccurred, data: data);
}
