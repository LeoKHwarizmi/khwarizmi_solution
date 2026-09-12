import 'dart:html';

void loadscript() {

  final button = querySelector('#btn');
  final paragraph = querySelector('#p1');

  if (button == null || paragraph == null) {
    return;
  }

  button.onClick.listen((event) {
    paragraph.style.color = 'green';
  });

  window.console.log("Page opened successfully!");
}