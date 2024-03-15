import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsara/ui/responsive_window.dart';
import 'package:samsara/ui/close_button.dart';

import '../../config.dart';
import '../../state/tile_info.dart';

class TileDetailPanel extends StatefulWidget {
  const TileDetailPanel({super.key});

  @override
  State<TileDetailPanel> createState() => _TileDetailPanelState();
}

class _TileDetailPanelState extends State<TileDetailPanel> {
  @override
  Widget build(BuildContext context) {
    final currentZone = context.watch<SelectedTileState>().currentZone;
    final currentNation = context.watch<SelectedTileState>().currentNation;
    final currentLocation = context.watch<SelectedTileState>().currentLocation;
    final currentTerrain = context.watch<SelectedTileState>().currentTerrain;

    String? coordinate;
    if (currentTerrain != null) {
      coordinate = '${currentTerrain.left}, ${currentTerrain.top}';
    }

    return ResponsiveWindow(
      alignment: Alignment.center,
      color: kBackgroundColor,
      size: const Size(400, 400),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(engine.locale('terrain')),
          actions: const [CloseButton2()],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentTerrain != null) ...[
                Text('${engine.locale('coordinate')}: $coordinate'),
                Text(
                    '${engine.locale('kind')}: ${engine.locale(currentTerrain.kind!)}'),
              ],
              if (currentZone != null)
                Text('${engine.locale('zone')}: ${currentZone['name']}'),
              if (currentNation != null)
                Text(
                    '${engine.locale('organization')}: ${currentNation['name']}'),
              if (currentLocation != null)
                Text(
                    '${engine.locale('location')}: ${currentLocation['name']}'),
            ],
          ),
        ),
      ),
    );
  }
}