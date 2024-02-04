
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/value/function/function.dart';

import '../ui/dialog/game_dialog.dart';
import '../ui/dialog/selection_dialog.dart';
// import '../ui/view/duel/duel.dart';
import '../ui/dialog/character_visit_dialog.dart';
import '../ui/dialog/character_select_dialog.dart';
import '../ui/view/merchant/merchant.dart';
import '../ui/view/quest/quests.dart';
import '../ui/overlay/maze/maze.dart';
import '../ui/dialog/progress_indicator.dart';
import '../ui/dialog/integer_input.dart';
import '../ui/dialog/skill_select_dialog.dart';

final Map<String, Function> externalGameFunctions = {
  r'showGameDialog': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return GameDialog.show(
      context: positionalArgs[0],
      dialogData: positionalArgs[1],
      returnValue: positionalArgs[2],
    );
  },
  r'showSelection': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return SelectionDialog.show(
      context: positionalArgs[0],
      selections: positionalArgs[1],
    );
  },
  r'showCharacterSelection': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return CharacterSelectDialog.show(
      context: positionalArgs[0],
      title: positionalArgs[1],
      characterIds: positionalArgs[2],
      showCloseButton: positionalArgs[3],
    );
  },
  r'showVisitCharacterSelection': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return CharacterVisitDialog.show(
      context: positionalArgs[0],
      characterIds: positionalArgs[1],
    );
  },
  r'showSkillSelection': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return SkillSelectDialog.show(
      context: positionalArgs[0],
      title: positionalArgs[1],
      skillsData: positionalArgs[2],
      showCloseButton: positionalArgs[3],
    );
  },
  // r'showDuel': (HTEntity object,
  //     {List<dynamic> positionalArgs = const [],
  //     Map<String, dynamic> namedArgs = const {},
  //     List<HTType> typeArgs = const []}) {
  //   return Duel.show(
  //     context: positionalArgs[0],
  //     char1: positionalArgs[1],
  //     char2: positionalArgs[2],
  //     type: positionalArgs[3],
  //     data: positionalArgs[4],
  //   );
  // },
  r'showMerchant': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return MerchantView.show(
      context: positionalArgs[0],
      merchantData: positionalArgs[1],
      priceFactor: positionalArgs[2],
      allowSell: positionalArgs[3],
      sellableCategory: positionalArgs[4],
      sellableKind: positionalArgs[5],
    );
  },
  r'showQuests': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return QuestsView.show(
      context: positionalArgs[0],
      siteData: positionalArgs[1],
    );
  },
  r'showMaze': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return MazeOverlay.show(
      context: positionalArgs[0],
      mazeData: positionalArgs[1],
    );
  },
  r'showProgress': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    bool Function()? func;
    if (positionalArgs[2] is HTFunction) {
      func = () => (positionalArgs[2] as HTFunction).call();
    }
    return ProgressIndicator.show(
      context: positionalArgs[0],
      title: positionalArgs[1],
      checkProgress: func,
    );
  },
  r'showIntInput': (HTEntity object,
      {List<dynamic> positionalArgs = const [],
      Map<String, dynamic> namedArgs = const {},
      List<HTType> typeArgs = const []}) {
    return IntegerInputDialog.show(
      context: positionalArgs[0],
      title: positionalArgs[1],
      min: positionalArgs[2],
      max: positionalArgs[3],
    );
  },
};