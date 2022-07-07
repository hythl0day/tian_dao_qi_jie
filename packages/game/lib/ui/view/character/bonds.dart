import 'package:flutter/material.dart';
import 'package:hetu_script/values.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../global.dart';
import '../../shared/empty_placeholder.dart';
import '../../shared/constants.dart';

const _kCharacterBondsTableColumns = [
  'character',
  'organization',
  'location',
  'nation',
  'talisman',
];

const _kCharacterBondsSubTableColumns = ['name', 'impressionOfThem'];

class CharacterBondsView extends StatelessWidget {
  const CharacterBondsView({
    super.key,
    required this.bondsData,
  });

  final HTStruct? bondsData;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kCharacterBondsTableColumns.length,
      child: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kNestedTabBarHeight),
            child: TabBar(
              tabs: _kCharacterBondsTableColumns
                  .map(
                    (key) => Tab(text: engine.locale[key]),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: bondsData != null
                ? TabBarView(
                    children: bondsData!.keys
                        .map(
                          (key) => DataTable2(
                            scrollController: ScrollController(),
                            empty: EmptyPlaceholder(engine.locale['empty']),
                            columns: _kCharacterBondsSubTableColumns
                                .map((title) => DataColumn(
                                      label: TextButton(
                                        onPressed: () {},
                                        child: Text(engine.locale[title]),
                                      ),
                                    ))
                                .toList(),
                            rows: bondsData![key] != null
                                ? (bondsData![key] as HTStruct)
                                    .values
                                    .map((object) => DataRow2(cells: [
                                          DataCell(
                                            Text(object['name']),
                                          ),
                                          DataCell(
                                            Text(object['score']
                                                .toStringAsFixed(2)),
                                          ),
                                        ]))
                                    .toList()
                                : const [],
                          ),
                        )
                        .toList(),
                  )
                : EmptyPlaceholder(engine.locale['empty']),
          ),
        ],
      ),
    );
  }
}
