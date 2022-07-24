import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hetu_script/util.dart' as util;

import '../global.dart';
import 'shared/responsive_window.dart';

const _kWorldScaleLabel = {
  1: 'tiny',
  2: 'medium',
  3: 'huge',
  4: 'massive',
};

const _kMaxNationNumberPerWorldScale = {
  1: 4,
  2: 8,
  3: 16,
  4: 32,
};

const _kMaxLocationNumberPerWorldScale = {
  1: 6,
  2: 14,
  3: 32,
  4: 72,
};

class CreateGameDialog extends StatefulWidget {
  static Future<dynamic> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (context) => const CreateGameDialog(),
    );
  }

  const CreateGameDialog({super.key});

  @override
  State<CreateGameDialog> createState() => _CreateGameDialogState();
}

class _CreateGameDialogState extends State<CreateGameDialog> {
  final _seedStringEditingController = TextEditingController();
  String _worldStyle = 'coast';
  int _worldScale = 1;
  int _nationNumber = 4;
  int _locationNumber = 6;
  int _characterNumber = 20;
  int _cultivationOrganizationNumber = 4;
  int _tradinghouseOrganizationNumber = 2;
  // int _religionOrganizationNumber = 0;
  // int _gangOrganizationNumber = 0;
  // int _academyOrganizationNumber = 0;
  // int _workshopOrganizationNumber = 0;
  // int _restaurantOrganizationNumber = 0;

  late String _worldScaleLabel;

  @override
  void initState() {
    super.initState();
    _worldScaleLabel = engine.locale[_kWorldScaleLabel[_worldScale]!];

    _seedStringEditingController.text = 'Hello world!';
  }

  @override
  Widget build(BuildContext context) {
    final newOrganizationNumberMax =
        math.min(_locationNumber, _characterNumber);
    final newNationNumberMax = _kMaxNationNumberPerWorldScale[_worldScale]!;
    final newLocationNumberMax = _kMaxLocationNumberPerWorldScale[_worldScale]!;

    final layout = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(engine.locale['loadGame']),
        actions: const [CloseButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // 随机数种子
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['randomSeed']}: '),
                      ),
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          controller: _seedStringEditingController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _seedStringEditingController.text =
                                math.Random().nextInt(1 << 32).toString();
                          },
                          child: Text(engine.locale['random']),
                        ),
                      ),
                    ],
                  ),
                  // 地图风格
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['worldStyle']}: '),
                      ),
                      DropdownButton<String>(
                        items: <String>['islands', 'coast', 'inland']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(engine.locale[value]),
                          );
                        }).toList(),
                        value: _worldStyle,
                        onChanged: (value) {
                          _worldStyle = value!;
                        },
                      ),
                    ],
                  ),
                  // world size
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['worldSize']}: '),
                      ),
                      Slider(
                        value: _worldScale.toDouble(),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        label: _worldScaleLabel,
                        onChanged: (double value) {
                          setState(() {
                            _worldScale = value.toInt();
                            _worldScaleLabel =
                                engine.locale[_kWorldScaleLabel[_worldScale]!];
                            final newNationNumberMax =
                                _kMaxNationNumberPerWorldScale[_worldScale]!;
                            if (_nationNumber > newNationNumberMax) {
                              _nationNumber = newNationNumberMax;
                            }
                            final newLocationNumberMax =
                                _kMaxLocationNumberPerWorldScale[_worldScale]!;
                            if (_locationNumber > newLocationNumberMax) {
                              _locationNumber = newLocationNumberMax;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_worldScaleLabel),
                      ),
                    ],
                  ),
                  // nation number
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['nationNumber']}: '),
                      ),
                      Slider(
                        value: _nationNumber.toDouble(),
                        min: 1,
                        max: newNationNumberMax.toDouble(),
                        divisions: newNationNumberMax,
                        label: _nationNumber.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _nationNumber = value.toInt();
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_nationNumber.toString()),
                      ),
                    ],
                  ),
                  // location number
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['locationNumber']}: '),
                      ),
                      Slider(
                        value: _locationNumber.toDouble(),
                        min: 1,
                        max: newLocationNumberMax.toDouble(),
                        divisions: newLocationNumberMax,
                        label: _locationNumber.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _locationNumber = value.toInt();
                            final newOrganizationNumberMax =
                                math.min(_locationNumber, _characterNumber);
                            if (_cultivationOrganizationNumber >
                                newOrganizationNumberMax) {
                              _cultivationOrganizationNumber =
                                  newOrganizationNumberMax;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_locationNumber.toString()),
                      ),
                    ],
                  ),
                  // character number
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text('${engine.locale['characterNumber']}: '),
                      ),
                      Slider(
                        value: _characterNumber.toDouble(),
                        min: 1,
                        max: 100,
                        divisions: 10,
                        label: _characterNumber.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _characterNumber = value.toInt();
                            final newOrganizationNumberMax =
                                math.min(_locationNumber, _characterNumber);
                            if (_cultivationOrganizationNumber >
                                newOrganizationNumberMax) {
                              _cultivationOrganizationNumber =
                                  newOrganizationNumberMax;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_characterNumber.toString()),
                      ),
                    ],
                  ),
                  // cultivation organization number
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                            '${engine.locale['cultivationOrganizationNumber']}: '),
                      ),
                      Slider(
                        value: _cultivationOrganizationNumber.toDouble(),
                        min: 0,
                        max: newOrganizationNumberMax.toDouble(),
                        divisions: newOrganizationNumberMax,
                        label: _cultivationOrganizationNumber.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _cultivationOrganizationNumber = value.toInt();
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_cultivationOrganizationNumber.toString()),
                      ),
                    ],
                  ),
                  // tradinghouse organization number
                  Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                            '${engine.locale['tradinghouseOrganizationNumber']}: '),
                      ),
                      Slider(
                        value: _tradinghouseOrganizationNumber.toDouble(),
                        min: 0,
                        max: newOrganizationNumberMax.toDouble(),
                        divisions: newOrganizationNumberMax,
                        label: _tradinghouseOrganizationNumber.toString(),
                        onChanged: (double value) {
                          setState(() {
                            _tradinghouseOrganizationNumber = value.toInt();
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.0,
                        child: Text(_tradinghouseOrganizationNumber.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(engine.locale['cancel']),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_seedStringEditingController.text.isNotEmpty) {
                      Navigator.of(context).pop({
                        'id': 'world_${util.uid4(4)}',
                        'seedString': _seedStringEditingController.text,
                        'style': _worldStyle,
                        'worldScale': _worldScale,
                        'nationNumber': _nationNumber,
                        'locationNumber': _locationNumber,
                        'characterNumber': _characterNumber,
                        'cultivationOrganizationNumber':
                            _cultivationOrganizationNumber,
                        'tradinghouseOrganizationNumber':
                            _tradinghouseOrganizationNumber,
                      });
                    } else {}
                  },
                  child: Text(engine.locale['continue']),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return ResponsiveWindow(
      alignment: AlignmentDirectional.center,
      child: layout,
    );
  }
}
