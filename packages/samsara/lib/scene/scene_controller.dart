import 'package:meta/meta.dart';

import 'scene.dart';

class SceneController {
  Scene? _currentScene;
  Scene? get currentScene => _currentScene;

  final _cachedScenes = <String, Scene>{};

  final _sceneConstructors = <String, Future<Scene> Function([dynamic arg])>{};

  void registerSceneConstructor<T extends Scene>(
      String name, Future<T> Function([dynamic args]) constructor) {
    _sceneConstructors[name] = constructor;
  }

  @mustCallSuper
  Future<Scene> createScene(String key, [dynamic args]) async {
    final _cached = _cachedScenes[key];
    if (_cached != null) {
      _currentScene = _cached;
      return _cached;
    } else {
      final constructor = _sceneConstructors[key]!;
      final Scene scene = await constructor(args);
      _cachedScenes[key] = scene;
      _currentScene = scene;
      return scene;
    }
  }

  void leaveScene(String key) {
    assert(_cachedScenes.containsKey(key));
    if (_currentScene?.key == _cachedScenes[key]!.key) {
      _currentScene = null;
    }
    _cachedScenes.remove(key);
  }
}
