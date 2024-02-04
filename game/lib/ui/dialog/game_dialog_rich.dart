import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:hetu_script/values.dart';

import '../avatar.dart';
import '../../global.dart';
import '../../event/events.dart';
import '../view/character/information/character.dart';
import '../view/character/npc.dart';

class GameDialog extends StatefulWidget {
  static Future<void> show({
    required BuildContext context,
    required HTStruct dialogData,
    required dynamic returnValue,
  }) {
    return showDialog<dynamic>(
      context: context,
      barrierColor: kBackgroundColor.withOpacity(0.5),
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameDialog(dialogData: dialogData, returnValue: returnValue);
      },
    );
  }

  final HTStruct dialogData;

  final dynamic returnValue;

  const GameDialog({
    super.key,
    required this.dialogData,
    this.returnValue,
  });

  @override
  State<GameDialog> createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {
  HTStruct get _data => widget.dialogData;
  Timer? _timer;
  String? _currentAvatar;
  String _currentSay = '';
  int _currentContentIndex = 0;
  HTStruct? _currentContent;
  int _currentSayIndex = 0;
  int _letterCount = 0;
  bool _finished = false;

  HTStruct? _characterData;
  bool _isNpc = false;

  final _textShowController = StreamController<String>.broadcast();

  @override
  void initState() {
    _startTalk();
    super.initState();
  }

  @override
  void dispose() {
    _textShowController.close();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration? backgroundImage;
    if (_currentContent != null) {
      final cg = _currentContent!['background'];
      if (cg != null) {
        backgroundImage = BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/${cg!}'),
            fit: BoxFit.cover,
          ),
        );
      }
    }

    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (_finished) {
          _nextSay();
        } else {
          _finishLine();
        }
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: backgroundImage,
            ),
            StreamBuilder(
              stream: _textShowController.stream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Container(
                  width: 720,
                  height: 160,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: kBorderRadius,
                    border: Border.all(color: kForegroundColor),
                  ),
                  child: Row(
                    children: [
                      Avatar(
                        image: _currentAvatar != null
                            ? AssetImage('assets/images/$_currentAvatar')
                            : null,
                        size: const Size(120.0, 120.0),
                        onPressed: () {
                          if (_characterData != null) {
                            if (_isNpc) {
                              showDialog(
                                context: context,
                                barrierColor: Colors.transparent,
                                builder: (context) {
                                  return NpcView(npcData: _characterData!);
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                barrierColor: Colors.transparent,
                                builder: (context) {
                                  return CharacterView(
                                      characterData: _characterData);
                                },
                              );
                            }

                            showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              builder: (context) {
                                return CharacterView(
                                    characterData: _characterData);
                              },
                            );
                          }
                        },
                      ),
                      Container(
                        width: 520,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startTalk() {
    setState(() {
      _finished = false;
      _letterCount = 0;
      _currentContent = _data['contents'][_currentContentIndex];

      final characterId = _currentContent!['characterId'];
      if (characterId != null) {
        if (widget.dialogData['isMajorCharacter'] ?? false) {
          _characterData =
              engine.invoke('getCharacterById', positionalArgs: [characterId]);
          _isNpc = false;
        } else {
          _characterData =
              engine.invoke('getNpcById', positionalArgs: [characterId]);
          _isNpc = true;
        }
      }

      _currentAvatar = _currentContent!['icon'];
      _currentSay = _currentContent!['lines'][_currentSayIndex];
      final displayName = _currentContent!['displayName'];
      if (displayName != null) {
        _currentSay = '$displayName: $_currentSay';
      }
      _timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        _letterCount++;
        if (_letterCount > _currentSay.length) {
          _finishLine();
        } else {
          _textShowController.add(_currentSay.substring(0, _letterCount));
        }
      });
    });
  }

  void _nextSay() {
    ++_currentSayIndex;
    if (_currentSayIndex >= _currentContent!['lines'].length) {
      _nextContent();
    } else {
      _startTalk();
    }
  }

  void _finishLine() {
    _timer?.cancel();
    _textShowController.add(_currentSay);
    _finished = true;
  }

  void _nextContent() {
    _currentSayIndex = 0;
    ++_currentContentIndex;
    if (_currentContentIndex < _data['contents'].length) {
      _startTalk();
    } else {
      _currentContentIndex = 0;
      _finishDialog();
    }
  }

  void _finishDialog() {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    Navigator.pop(context, widget.returnValue);
    engine.broadcast(const UIEvent.needRebuildUI());
    // });
  }
}