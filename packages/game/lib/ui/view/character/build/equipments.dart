import 'package:flutter/material.dart';
import 'package:hetu_script/values.dart';

import 'item_grid.dart';
import 'item_info.dart';

class EquipmentsView extends StatelessWidget {
  /// [selectedIndex] 表示目前正在激活的武器/斗技，表现为一个边框。默认是0，表示没有激活。
  const EquipmentsView({
    super.key,
    required this.data,
    this.verticalMargin = 5.0,
    this.horizontalMargin = 10.0,
    this.selectedIndex = 0,
    this.cooldown = 0.0,
  });

  final HTStruct data;

  final double verticalMargin, horizontalMargin;

  final int selectedIndex;

  final double cooldown;

  void _onItemTapped(
      BuildContext context, HTStruct item, Offset screenPosition) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return ItemInfo(
            data: item,
            left: screenPosition.dx,
            top: screenPosition.dy - 100.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['offense'][1],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
              isSelected: selectedIndex == 1,
              cooldownValue: selectedIndex == 1 ? cooldown : 0,
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['offense'][2],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
              isSelected: selectedIndex == 2,
              cooldownValue: selectedIndex == 2 ? cooldown : 0,
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['offense'][3],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
              isSelected: selectedIndex == 3,
              cooldownValue: selectedIndex == 3 ? cooldown : 0,
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['offense'][4],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
              isSelected: selectedIndex == 4,
              cooldownValue: selectedIndex == 4 ? cooldown : 0,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['defense'][1],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['defense'][2],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['defense'][3],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
            ),
            ItemGrid(
              verticalMargin: verticalMargin,
              horizontalMargin: horizontalMargin,
              data: data['defense'][4],
              onSelect: (item, screenPosition) =>
                  _onItemTapped(context, item, screenPosition),
            ),
          ],
        ),
      ],
    );
  }
}