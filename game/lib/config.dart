import 'package:flutter/material.dart';
import 'package:samsara/samsara.dart';
import 'ui.dart';

const kForegroundColor = Colors.white;
final kBackgroundColor = Colors.black.withAlpha(180);
final kBarrierColor = Colors.black.withAlpha(128);
final kBorderRadius = BorderRadius.circular(5.0);

const iconTheme = IconThemeData(
  color: kForegroundColor,
);

const captionStyle = TextStyle(
  fontFamily: GameUI.fontFamily,
  fontSize: 18.0,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(),
  fontFamily: GameUI.fontFamily,
  colorScheme: ColorScheme.dark(
    surface: kBackgroundColor,
  ),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.transparent,
    toolbarHeight: 36,
    iconTheme: iconTheme,
    actionsIconTheme: iconTheme,
    titleTextStyle: captionStyle,
  ),
  dialogBackgroundColor: kBarrierColor,
  iconTheme: iconTheme,
  cardTheme: CardTheme(
    elevation: 0.5,
    shape: RoundedRectangleBorder(
      borderRadius: kBorderRadius,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kForegroundColor,
      shape: const RoundedRectangleBorder(),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kBackgroundColor,
      foregroundColor: kForegroundColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: kForegroundColor,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          topRight: Radius.circular(5.0),
        ),
      ),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: kBackgroundColor,
    shape: RoundedRectangleBorder(
        side: const BorderSide(color: kForegroundColor),
        borderRadius: BorderRadius.circular(8)),
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: kForegroundColor,
    activeTickMarkColor: kForegroundColor,
    thumbColor: kForegroundColor,
    valueIndicatorTextStyle: TextStyle(
      fontFamily: GameUI.fontFamily,
      color: kForegroundColor,
    ),
  ),
  dividerColor: kForegroundColor,
);

abstract class GameConfig {
  static String gameTitle = 'Heavenly Tribulation';
  static ThemeData appTheme = darkTheme;
  static bool isDebugMode = true;
  static Size screenSize = Size.zero;
  static double musicVolume = 0.5;
  static double soundEffectVolume = 0.5;
  static Map<String, dynamic> modules = {
    'tutorial': {
      'enabled': true,
      'preinclude': true,
    }
  };
}

const kValueTypeInt = 'int';
const kValueTypeFloat = 'float';
const kValueTypePercentage = 'percentage';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final SamsaraEngine engine = SamsaraEngine(
  config: EngineConfig(
    name: GameConfig.gameTitle,
    isOnDesktop: true,
    debugMode: GameConfig.isDebugMode,
    musicVolume: GameConfig.musicVolume,
    soundEffectVolume: GameConfig.soundEffectVolume,
  ),
);
