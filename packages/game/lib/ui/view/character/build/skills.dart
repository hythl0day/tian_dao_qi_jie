import 'package:flutter/material.dart';
import 'package:hetu_script/values.dart';

import 'item_grid.dart';

const kSkillSlotCount = 20;

class SkillsView extends StatelessWidget {
  const SkillsView({
    Key? key,
    required this.data,
    required this.onSelect,
  }) : super(key: key);

  final HTStruct data;

  final void Function(HTStruct item, Offset screenPosition) onSelect;

  @override
  Widget build(BuildContext context) {
    final List knowledges = data['inventory'];

    final skills = <ItemGrid>[];
    for (var i = 0; i < kSkillSlotCount; ++i) {
      if (i < knowledges.length) {
        skills.add(ItemGrid(
          data: knowledges[i],
          onSelect: onSelect,
        ));
      } else {
        skills.add(ItemGrid(
          onSelect: onSelect,
        ));
      }
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ItemGrid(
              verticalMargin: 40,
              onSelect: onSelect,
            ),
            ItemGrid(
              verticalMargin: 40,
              onSelect: onSelect,
            ),
            ItemGrid(
              verticalMargin: 40,
              onSelect: onSelect,
            ),
            ItemGrid(
              verticalMargin: 40,
              onSelect: onSelect,
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Wrap(
                  children: skills,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
