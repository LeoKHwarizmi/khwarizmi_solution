
import 'dart:html';

void loadcss() {
  final body = document.body;

  if (body != null) {
    body.style.backgroundColor = 'AliceBlue';
  }

  // Style ALL sections, not just the first one
  final sections = querySelectorAll('.section');

  for (final section in sections) {
    section.style
      ..display = 'block'
      ..width = '210mm'
      ..height = '297mm'
      ..backgroundColor = 'white'
      ..margin = '5px auto';

    final svg = section.querySelector('svg');

    if (svg != null) {
      svg.style
        ..display = 'block'
        ..backgroundColor = 'white';
    }

    final images = section.querySelectorAll('image');

    for (final image in images) {
      image.setAttribute('stroke', 'black');
      image.setAttribute('stroke-width', '5');
    }
  }

  // Style word1 input
  final word1Input = querySelector('#word1_input');

  if (word1Input != null) {
    word1Input.style
      ..border = '1px solid black'
      ..outline = 'none'
      ..boxShadow = 'none';

    // Keep exactly the same border when selected
    word1Input.onFocus.listen((event) {
      word1Input.style
        ..border = '1px solid black'
        ..outline = 'none'
        ..boxShadow = 'none';
    });

    word1Input.onBlur.listen((event) {
      word1Input.style
        ..border = '1px solid black'
        ..outline = 'none'
        ..boxShadow = 'none';
    });


  }
}
