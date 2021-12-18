import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';

// import 'package:path/path.dart' as path;

import '../../engine/game.dart';
import '../../shared/localization.dart';
import 'character/character_listview.dart';
import 'code/code_editor.dart';

class GameEditor extends StatefulWidget {
  const GameEditor({Key? key, required this.onQuit, required this.game})
      : super(key: key);

  final void Function() onQuit;

  final SamsaraGame game;

  @override
  State<GameEditor> createState() => _GameEditorState();
}

class _GameEditorState extends State<GameEditor> {
  // static const moduleEntryFileName = 'main.ht';
  SamsaraGame get game => widget.game;

  GameLocalization get locale => widget.game.locale;

  final _characterData = <Map<String, dynamic>>[];

  bool _isEditing = false;
  String? _currentProjectName;
  String? _currentSavePath;
  final _textFieldController = TextEditingController();

  final _codeFileNames = <String>[];
  final _codeFileContents = <String>[];

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  Future<void> _newProject() async {
    String? projectName;
    _textFieldController.text = locale['unnamedProject'];
    await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: _textFieldController,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(locale['cancel']),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green[800]),
              child: Text(locale['ok']),
              onPressed: () {
                setState(() {
                  projectName = _textFieldController.text;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
    if (projectName != null) {
      setState(() {
        _currentProjectName = projectName;
        _isEditing = true;
      });
    }
  }

  Future<void> _saveAs() async {
    if (_currentSavePath == null) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(locale['saveSuccessed'])));
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: locale['goBack'],
              onPressed: () {
                widget.onQuit();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: const Icon(Icons.save),
                    tooltip: locale['save'],
                    onPressed: () {
                      _saveAs();
                    },
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(_currentProjectName ?? ''),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: locale['character']),
                Tab(text: locale['location']),
                Tab(text: locale['organization']),
                Tab(text: locale['maze']),
                Tab(text: locale['dialog']),
                Tab(text: locale['localization']),
                Tab(text: locale['meta']),
                Tab(text: locale['code']),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                  child: CharacterListView(game: game, data: _characterData)),
              Center(child: Text(locale['location'])),
              Center(child: Text(locale['organization'])),
              Center(child: Text(locale['maze'])),
              Center(child: Text(locale['dialog'])),
              Center(child: Text(locale['localization'])),
              Center(child: Text(locale['meta'])),
              Center(
                child: CodeEditor(
                  names: _codeFileNames,
                  contents: _codeFileContents,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(locale['editorTitle']),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _newProject,
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: Center(
                    child: Text(
                      locale['newProject'],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}