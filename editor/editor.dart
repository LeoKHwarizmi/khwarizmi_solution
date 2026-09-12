
import 'dart:convert';
import 'dart:html';
import 'dart:js_util' as js_util;


void main() {

  final ide =
      DartWebIDE();

  ide.start();
}


class DartWebIDE {

  // ============================================================
  // IDE ELEMENTS
  // ============================================================

  late TextAreaElement editor;

  late DivElement lineNumbers;

  late ButtonElement runButton;

  late ButtonElement saveButton;

  late ButtonElement clearButton;

  late ButtonElement newFileButton;

  late PreElement output;

  late IFrameElement preview;

  late SpanElement currentFile;

  late DivElement tabs;


  // ============================================================
  // PROJECT
  // ============================================================

  final Map<String, String> files = {};


  String currentFileName =
      'main.dart';


  // ============================================================
  // DEFAULT DART
  // ============================================================

  static const defaultDart = '''
import 'dart:html';

void main() {

  final button =
      querySelector('#hello');

  button?.onClick.listen((event) {

    window.alert(
      'Hello from Dart!'
    );

  });

}''';


  // ============================================================
  // DEFAULT HTML
  // ============================================================

  static const defaultHtml = '''
<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Dart Web App</title>

</head>

<body>

    <h1>
        Hello from Dart Web
    </h1>

    <p id="message">
        Click the button.
    </p>

    <button id="hello">
        Click me
    </button>

</body>

</html>
''';


  // ============================================================
  // DEFAULT CSS
  // ============================================================

  static const defaultCss = '''
body {
    font-family: Arial, sans-serif;
    padding: 40px;
}

h1 {
    color: #333;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}
''';


  // ============================================================
  // START
  // ============================================================

  void start() {

    findElements();

    createDefaultProject();

    loadSavedProject();

    loadCurrentEditor();

    updateTabs();

    connectEvents();

    showOutput(
      'Dart Web IDE ready.',
    );
  }


  // ============================================================
  // FIND HTML ELEMENTS
  // ============================================================

  void findElements() {

    editor =
        querySelector('#editor')
            as TextAreaElement;

    lineNumbers =
        querySelector('#line-numbers')
            as DivElement;

    runButton =
        querySelector('#run')
            as ButtonElement;

    saveButton =
        querySelector('#save')
            as ButtonElement;

    clearButton =
        querySelector('#clear')
            as ButtonElement;

    newFileButton =
        querySelector('#new-file')
            as ButtonElement;

    output =
        querySelector('#output')
            as PreElement;

    preview =
        querySelector('#preview')
            as IFrameElement;

    currentFile =
        querySelector('#current-file')
            as SpanElement;

    tabs =
        querySelector('#tabs')
            as DivElement;
  }


  // ============================================================
  // CREATE DEFAULT PROJECT
  // ============================================================

  void createDefaultProject() {

    files.clear();


    files['main.dart'] =
        defaultDart;


    files['index.html'] =
        defaultHtml;


    files['styles.css'] =
        defaultCss;
  }


  // ============================================================
  // SHOW OUTPUT
  // ============================================================

  void showOutput(
      String text) {

    output.text =
        text;
  }


  // ============================================================
  // GET CURRENT CODE
  // ============================================================

  String getCurrentCode() {

    return files[
        currentFileName
    ] ?? '';
  }


  // ============================================================
  // SAVE CURRENT EDITOR
  // ============================================================

  void saveCurrentEditor() {

    files[
        currentFileName
    ] =
        editor.value ?? '';
  }


  // ============================================================
  // LOAD CURRENT EDITOR
  // ============================================================

  void loadCurrentEditor() {

    editor.value =
        getCurrentCode();


    currentFile.text =
        currentFileName;


    updateLineNumbers();
  }


  // ============================================================
  // UPDATE LINE NUMBERS
  // ============================================================

  void updateLineNumbers() {

    final code =
        editor.value ?? '';


    final lineCount =
        '\n'.allMatches(code).length + 1;


    lineNumbers.text =
        List.generate(
          lineCount,
          (index) => '${index + 1}',
        ).join('\n');
  }


  // ============================================================
  // ACTIVATE TAB
  // ============================================================

  void activateTab(
      String fileName) {

    if (!files.containsKey(
        fileName)) {

      return;
    }


    saveCurrentEditor();


    currentFileName =
        fileName;


    loadCurrentEditor();


    updateTabs();
  }


  // ============================================================
  // UPDATE TABS
  // ============================================================

  void updateTabs() {

    tabs.children.clear();


    files.keys.forEach(
      (fileName) {

        final tab =
            ButtonElement();


        tab
          ..text = fileName
          ..className = 'tab';


        if (fileName ==
            currentFileName) {

          tab.classes.add(
            'active',
          );
        }


        tab.onClick.listen(
          (event) {

            activateTab(
              fileName,
            );
          },
        );


        tabs.append(
          tab,
        );
      },
    );
  }


  // ============================================================
  // CREATE NEW FILE
  // ============================================================

  void createNewFile() {

    final result =
        js_util.callMethod(
          window,
          'prompt',
          [
            'Enter file name:',
          ],
        );


    if (result == null) {

      return;
    }


    final name =
        result.toString().trim();


    if (name.isEmpty) {

      return;
    }


    if (files.containsKey(
        name)) {

      window.alert(
        'A file named "$name" already exists.',
      );

      return;
    }


    files[name] =
        '';


    currentFileName =
        name;


    loadCurrentEditor();

    updateTabs();


    showOutput(
      'Created $name',
    );
  }


  // ============================================================
  // CLEAR CURRENT FILE
  // ============================================================

  void clearCurrentFile() {

    editor.value =
        '';


    saveCurrentEditor();


    updateLineNumbers();


    showOutput(
      '$currentFileName cleared.',
    );
  }


  // ============================================================
  // SAVE PROJECT
  // ============================================================

  void saveProject() {

    saveCurrentEditor();


    window.localStorage[
      'dart-ide-files'
    ] =
        jsonEncode(
          files,
        );


    showOutput(
      'Project saved.',
    );
  }


  // ============================================================
  // LOAD SAVED PROJECT
  // ============================================================

  void loadSavedProject() {

    final saved =
        window.localStorage[
          'dart-ide-files'
        ];


    if (saved == null) {

      return;
    }


    try {

      final data =
          jsonDecode(
            saved,
          );


      if (data is Map) {

        final loadedFiles =
            <String, String>{};


        data.forEach(
          (key, value) {

            if (key is String &&
                value is String) {

              loadedFiles[key] =
                  value;
            }
          },
        );


        if (loadedFiles.isNotEmpty) {

          files.clear();

          files.addAll(
            loadedFiles,
          );


          if (!files.containsKey(
              currentFileName)) {

            currentFileName =
                files.keys.first;
          }
        }
      }

    } catch (error) {

      showOutput(
        'Could not load saved project.\n\n'
        '$error',
      );
    }
  }


  // ============================================================
  // BUILD PREVIEW HTML
  // ============================================================

  String buildPreviewHtml(
      String javascript) {

    final html =
        files['index.html'] ?? '';


    final css =
        files['styles.css'] ?? '';


    return '''
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<style>

$css

</style>

</head>


<body>

$html


<script>

window.addEventListener(
    "error",
    function(event) {

        parent.postMessage(
            {
                type: "error",
                message: event.message
            },
            "*"
        );

    }
);


window.addEventListener(
    "unhandledrejection",
    function(event) {

        parent.postMessage(
            {
                type: "error",
                message: String(event.reason)
            },
            "*"
        );

    }
);


const originalLog =
    console.log;


console.log =
    function() {

        const message =
            Array.from(arguments)
                .join(" ");

        parent.postMessage(
            {
                type: "output",
                message: message
            },
            "*"
        );

        originalLog.apply(
            console,
            arguments
        );

    };


const originalError =
    console.error;


console.error =
    function() {

        const message =
            Array.from(arguments)
                .join(" ");

        parent.postMessage(
            {
                type: "error",
                message: message
            },
            "*"
        );

        originalError.apply(
            console,
            arguments
        );

    };


try {

$javascript

} catch (error) {

    parent.postMessage(
        {
            type: "error",
            message: String(error)
        },
        "*"
    );

}

</script>

</body>

</html>
''';
  }


  // ============================================================
  // SHOW PREVIEW
  // ============================================================

  void showPreview(
      String javascript) {

    final html =
        buildPreviewHtml(
          javascript,
        );


    final blob =
        Blob(
          [
            html,
          ],
          'text/html',
        );


    final url =
        Url.createObjectUrl(
          blob,
        );


    preview.src =
        url;
  }


  // ============================================================
  // RUN DART
  // ============================================================

  Future<void> runCode() async {

    saveCurrentEditor();


    final mainCode =
        files['main.dart'] ?? '';


    if (mainCode.trim().isEmpty) {

      showOutput(
        'main.dart is empty.',
      );

      return;
    }


    showOutput(
      'Compiling Dart...',
    );


    try {

      final request =
          HttpRequest();


      request.open(
        'POST',
        'http://127.0.0.1:9000/compile',
      );


      request.setRequestHeader(
        'Content-Type',
        'application/json',
      );


      request.send(
        jsonEncode(
          {
            'files':
                files,
          },
        ),
      );


      await request.onLoad.first;


      final responseText =
          request.responseText ?? '';


      if (request.status != 200) {

        showOutput(
          'Compiler server error.\n\n'
          '$responseText',
        );

        return;
      }


      if (responseText.isEmpty) {

        showOutput(
          'Compiler returned an empty response.',
        );

        return;
      }


      final data =
          jsonDecode(
            responseText,
          );


      final compilerError =
          data['error'];


      if (compilerError != null) {

        showOutput(
          'Dart compilation error:\n\n'
          '$compilerError',
        );

        return;
      }


      final javascript =
          data['javascript'];


      if (javascript == null) {

        showOutput(
          'Compiler returned no JavaScript.',
        );

        return;
      }


      showOutput(
        'Running Dart Web application...',
      );


      showPreview(
        javascript,
      );

    } catch (error) {

      showOutput(
        'Could not connect to compiler server.\n\n'
        'Make sure compiler_server.py is running.\n\n'
        '$error',
      );
    }
  }


  // ============================================================
  // TAB KEY
  // ============================================================

  void handleTab(
      KeyboardEvent event) {

    if (event.key != 'Tab') {

      return;
    }


    event.preventDefault();


    final text =
        editor.value ?? '';


    final start =
        editor.selectionStart ?? 0;


    final end =
        editor.selectionEnd ?? start;


    final newText =
        text.substring(
          0,
          start,
        ) +
        '    ' +
        text.substring(
          end,
        );


    editor.value =
        newText;


    final position =
        start + 4;


    editor.selectionStart =
        position;


    editor.selectionEnd =
        position;


    saveCurrentEditor();


    updateLineNumbers();
  }


  // ============================================================
  // KEYBOARD SHORTCUTS
  // ============================================================

  void handleKeyboard(
      KeyboardEvent event) {

    // ----------------------------------------------------------
    // CTRL + ENTER
    // ----------------------------------------------------------

    if (event.ctrlKey &&
        event.key == 'Enter') {

      event.preventDefault();

      runCode();

      return;
    }


    // ----------------------------------------------------------
    // CTRL + S
    // ----------------------------------------------------------

    final key =
        event.key;


    if (event.ctrlKey &&
        key != null &&
        key.toLowerCase() == 's') {

      event.preventDefault();

      saveProject();

      return;
    }


    // ----------------------------------------------------------
    // TAB
    // ----------------------------------------------------------

    handleTab(
      event,
    );
  }


  // ============================================================
  // CONNECT EVENTS
  // ============================================================

  void connectEvents() {

    // ----------------------------------------------------------
    // EDITOR INPUT
    // ----------------------------------------------------------

    editor.onInput.listen(
      (event) {

        saveCurrentEditor();

        updateLineNumbers();
      },
    );


    // ----------------------------------------------------------
    // EDITOR SCROLL
    // ----------------------------------------------------------

    editor.onScroll.listen(
      (event) {

        lineNumbers.scrollTop =
            editor.scrollTop;
      },
    );


    // ----------------------------------------------------------
    // EDITOR KEYBOARD
    // ----------------------------------------------------------

    editor.onKeyDown.listen(
      (event) {

        handleKeyboard(
          event,
        );
      },
    );


    // ----------------------------------------------------------
    // RUN
    // ----------------------------------------------------------

    runButton.onClick.listen(
      (event) {

        runCode();
      },
    );


    // ----------------------------------------------------------
    // SAVE
    // ----------------------------------------------------------

    saveButton.onClick.listen(
      (event) {

        saveProject();
      },
    );


    // ----------------------------------------------------------
    // CLEAR
    // ----------------------------------------------------------

    clearButton.onClick.listen(
      (event) {

        clearCurrentFile();
      },
    );


    // ----------------------------------------------------------
    // NEW FILE
    // ----------------------------------------------------------

    newFileButton.onClick.listen(
      (event) {

        createNewFile();
      },
    );


    // ----------------------------------------------------------
    // PREVIEW MESSAGES
    // ----------------------------------------------------------

    window.onMessage.listen(
      (MessageEvent event) {

        final data =
            event.data;


        if (data is! Map) {

          return;
        }


        final type =
            data['type'];


        final message =
            data['message'];


        if (type == 'output') {

          showOutput(
            '$message',
          );

        } else if (type == 'error') {

          showOutput(
            'Runtime error:\n\n'
            '$message',
          );
        }
      },
    );
  }
}
