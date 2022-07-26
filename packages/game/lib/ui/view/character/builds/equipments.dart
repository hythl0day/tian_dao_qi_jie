import 'package:flutter/material.dart';
import 'package:hetu_script/values.dart';

import '../../grid/entity_grid.dart';
import '../../../../global.dart';

class EquipmentsView extends StatelessWidget {
  const EquipmentsView({
    super.key,
    required this.characterData,
    this.selectedIndex = 0,
    this.cooldownValue = 0.0,
    this.cooldownColor = Colors.white,
    this.onItemTapped,
  });

  final HTStruct characterData;
  final int selectedIndex;
  final double cooldownValue;
  final Color cooldownColor;
  final void Function(HTStruct item, Offset screenPosition)? onItemTapped;

  @override
  Widget build(BuildContext context) {
    final defenses = characterData['equipments']['defense'];
    final defense1 = engine.invoke('getEquipped', positionalArgs: [
      defenses[1],
      characterData,
    ]);
    final defense2 = engine.invoke('getEquipped', positionalArgs: [
      defenses[2],
      characterData,
    ]);
    final defense3 = engine.invoke('getEquipped', positionalArgs: [
      defenses[3],
      characterData,
    ]);
    final offenses = characterData['equipments']['offense'];
    final offense1 = engine.invoke('getEquipped', positionalArgs: [
      offenses[1],
      characterData,
    ]);
    final offense2 = engine.invoke('getEquipped', positionalArgs: [
      offenses[2],
      characterData,
    ]);
    final offense3 = engine.invoke('getEquipped', positionalArgs: [
      offenses[3],
      characterData,
    ]);
    final offense4 = engine.invoke('getEquipped', positionalArgs: [
      offenses[4],
      characterData,
    ]);
    final companions = characterData['equipments']['companion'];
    final companion1 = engine.invoke('getEquipped', positionalArgs: [
      companions[1],
      characterData,
    ]);
    final companion2 = engine.invoke('getEquipped', positionalArgs: [
      companions[2],
      characterData,
    ]);
    final companion3 = engine.invoke('getEquipped', positionalArgs: [
      companions[3],
      characterData,
    ]);

    return Container(
      width: 390.0,
      height: 390.0,
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: defense1,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 1,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_defense.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: defense2,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 2,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_defense.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: defense3,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 2,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_defense.png'),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: companion1,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 1,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_companion.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: companion2,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 2,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_companion.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: EntityGrid(
                      entityData: companion3,
                      onItemTapped: onItemTapped,
                      isSelected: selectedIndex == 2,
                      backgroundImage: const AssetImage(
                          'assets/images/icon/item/bg_companion.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: EntityGrid(
                  entityData: offense1,
                  onItemTapped: onItemTapped,
                  isSelected: selectedIndex == 1,
                  backgroundImage: const AssetImage(
                      'assets/images/icon/item/bg_offense.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: EntityGrid(
                  entityData: offense2,
                  onItemTapped: onItemTapped,
                  isSelected: selectedIndex == 2,
                  backgroundImage: const AssetImage(
                      'assets/images/icon/item/bg_offense.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: EntityGrid(
                  entityData: offense3,
                  onItemTapped: onItemTapped,
                  isSelected: selectedIndex == 3,
                  backgroundImage: const AssetImage(
                      'assets/images/icon/item/bg_offense.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: EntityGrid(
                  entityData: offense4,
                  onItemTapped: onItemTapped,
                  isSelected: selectedIndex == 4,
                  backgroundImage: const AssetImage(
                      'assets/images/icon/item/bg_offense.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}