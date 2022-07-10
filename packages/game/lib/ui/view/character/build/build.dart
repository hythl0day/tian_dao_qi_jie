import 'package:flutter/material.dart';
import 'package:hetu_script/values.dart';

import '../../../../ui/shared/close_button.dart';
import '../../../../global.dart';
import 'equipments.dart';
import 'inventory.dart';
import '../../../shared/responsive_route.dart';

class BuildView extends StatefulWidget {
  const BuildView({
    super.key,
    required this.characterData,
    this.tabIndex = 0,
  });

  final HTStruct characterData;

  final int tabIndex;

  @override
  State<BuildView> createState() => _BuildViewState();
}

class _BuildViewState extends State<BuildView>
    with SingleTickerProviderStateMixin {
  static final List<Tab> _tabs = <Tab>[
    Tab(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.inventory),
          ),
          Text(engine.locale['inventory']),
        ],
      ),
    ),
    Tab(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.library_books),
          ),
          Text(engine.locale['skills']),
        ],
      ),
    ),
  ];

  // late TabController _tabController;

  // String _title = engine.locale['items'];

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(vsync: this, length: _tabs.length);
    // _tabController.addListener(() {
    //   setState(() {
    //     if (_tabController.index == 0) {
    //       _title = engine.locale['items'];
    //     } else if (_tabController.index == 1) {
    //       _title = engine.locale['skills'];
    //     }
    //   });
    // });
    // _tabController.index = widget.tabIndex;
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final charId = widget.characterId ??
    //     ModalRoute.of(context)!.settings.arguments as String;

    // final characterData =
    //     engine.invoke('getCharacterById', positionalArgs: [charId]);

    return ResponsiveRoute(
      size: const Size(700.0, 400.0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.characterData['name']),
          actions: const [ButtonClose()],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 340.0,
              height: 390.0,
              child: EquipmentsView(
                characterData: widget.characterData,
              ),
            ),
            SizedBox(
              width: 340.0,
              height: 390.0,
              child: DefaultTabController(
                length: _tabs.length, // 物品栏通过tabs过滤不同种类的物品
                child: Column(
                  children: [
                    TabBar(
                      // controller: _tabController,
                      tabs: _tabs,
                    ),
                    Expanded(
                      child: TabBarView(
                        // controller: _tabController,
                        children: [
                          InventoryView(
                            inventoryData: widget.characterData['inventory'],
                          ),
                          InventoryView(
                            inventoryData: widget.characterData['skills'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
