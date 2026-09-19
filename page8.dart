import 'dart:html';
import 'dart:js_util' as js_util;

Element buildPage8() {
  const svgcdn = 'http://www.w3.org/2000/svg';

  final sec = Element.tag('section')..classes.addAll(['section']);
  final svg = document.createElementNS(svgcdn, 'svg')..setAttribute('width', '210mm')..setAttribute('height', '297mm')..setAttribute('viewBox', '0 0 210 297');

  // header
  final test_banner = document.createElementNS(svgcdn, 'polygon')..setAttribute('points', '0,157 140,156 150,167 210,167 210,297 0,297')..setAttribute('fill', 'rgb(230, 255, 230)');
  final left_line = document.createElementNS(svgcdn, 'polygon')..setAttribute('points', '0,0 5,0 5,205 0,210')..setAttribute('fill', 'CadetBlue');
  final banner_title_bg = document.createElementNS(svgcdn, 'polygon')..setAttribute('points', '142,159 190,159 190,167 150,167')..setAttribute('fill', 'CadetBlue');
  final banner_title = document.createElementNS(svgcdn, 'text')..text = 'FASTTEST'..setAttribute('x', '155')..setAttribute('y', '165')..setAttribute('font-size', '5')..setAttribute('fill', 'white');
  final solution_bg = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '30')..setAttribute('y', '275')..setAttribute('width', '44')..setAttribute('height', '7')..setAttribute('rx', '2')..setAttribute('fill', 'SkyBlue');
  final solution = document.createElementNS(svgcdn, 'text')..text = 'Solution > P. 120'..setAttribute('x', '34')..setAttribute('y', '280')..setAttribute('font-size', '5')..setAttribute('font-weight', '600');
  final sidenumber = document.createElementNS(svgcdn, 'text')..text = '02\u00A0\u00A0|\u00A0\u00A0Two'..setAttribute('font-size', '5')..setAttribute('fill', 'black')..setAttribute('x', '10')..setAttribute('y', '245')..setAttribute('transform', 'rotate(-90 10 245)');

  svg..append(test_banner)..append(left_line)..append(banner_title_bg)..append(banner_title)..append(solution_bg)
  ..append(solution)..append(sidenumber);

  // main content
  final practice2a = document.createElementNS(svgcdn, 'text')..text = 'd'..setAttribute('x', '20')..setAttribute('y', '20')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final practice2a_title = document.createElementNS(svgcdn, 'text')..text = 'How do you debug the code!?'..setAttribute('x', '30')..setAttribute('y', '20')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final word1_bg = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '30')..setAttribute('y', '25')..setAttribute('width', '135')..setAttribute('height', '7')..setAttribute('rx', '2')..setAttribute('fill', 'PapayaWhip');
  final word1 = document.createElementNS(svgcdn, 'text')..text = "final title = "..setAttribute('x', '31')..setAttribute('y', '30')..setAttribute('font-size', '5');
  final word6_input = document.createElementNS(svgcdn, 'foreignObject')..setAttribute('x', '55')..setAttribute('y', '25')..setAttribute('width', '38')..setAttribute('height', '7');
  final word6_textbox = InputElement()..style.width = "38px"..style.height = "7px"..style.fontSize = "5.5px"..style.border = "1px solid black"..style.borderRadius = "0"..style.outline = "none"..style.boxSizing = "border-box"..id = "word6_input";
  word6_input.append(word6_textbox);
  final word1_1 = document.createElementNS(svgcdn, 'text')..text = "('title').."..setAttribute('x', '93')..setAttribute('y', '30')..setAttribute('font-size', '5');
  final word6_1_input = document.createElementNS(svgcdn, 'foreignObject')..setAttribute('x', '109')..setAttribute('y', '25')..setAttribute('width', '15')..setAttribute('height', '7');
  final word6_1_textbox = InputElement()..style.width = "15px"..style.height = "7px"..style.fontSize = "5.5px"..style.border = "1px solid black"..style.borderRadius = "0"..style.outline = "none"..style.boxSizing = "border-box"..id = "word6_1_input";
  word6_1_input.append(word6_1_textbox);
  final word1_2 = document.createElementNS(svgcdn, 'text')..text = " = 'Dart Web Page';"..setAttribute('x', '125')..setAttribute('y', '30')..setAttribute('font-size', '5');


  final word2_bg = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '30')..setAttribute('y', '33')..setAttribute('width', '70')..setAttribute('height', '7')..setAttribute('rx', '2')..setAttribute('fill', 'PapayaWhip');
  final word2 = document.createElementNS(svgcdn, 'text')..text = "document."..setAttribute('x', '31')..setAttribute('y', '38')..setAttribute('font-size', '5');
  final word7_input = document.createElementNS(svgcdn, 'foreignObject')..setAttribute('x', '52')..setAttribute('y', '33')..setAttribute('width', '19')..setAttribute('height', '7');
  final word7_textbox = InputElement()..style.width = "19px"..style.height = "7px"..style.fontSize = "5.5px"..style.border = "1px solid black"..style.borderRadius = "0"..style.outline = "none"..style.boxSizing = "border-box"..id = "word7_input";
  word7_input.append(word7_textbox);
  final word2_1 = document.createElementNS(svgcdn, 'text')..text = "!.."..setAttribute('x', '72')..setAttribute('y', '38')..setAttribute('font-size', '5');
  final word8_input = document.createElementNS(svgcdn, 'foreignObject')..setAttribute('x', '77')..setAttribute('y', '33')..setAttribute('width', '25')..setAttribute('height', '7');
  final word8_textbox = InputElement()..style.width = "25px"..style.height = "7px"..style.fontSize = "5.5px"..style.border = "1px solid black"..style.borderRadius = "0"..style.outline = "none"..style.boxSizing = "border-box"..id = "word8_input";
  word8_input.append(word8_textbox);
  final word2_2 = document.createElementNS(svgcdn, 'text')..text = "(title);"..setAttribute('x', '103')..setAttribute('y', '38')..setAttribute('font-size', '5');

final checkBtn = document.createElementNS(svgcdn, 'foreignObject')
  ..setAttribute('x', '150')
  ..setAttribute('y', '35')
  ..setAttribute('width', '40')
  ..setAttribute('height', '10');

final btn = ButtonElement()
  ..text = "Check"
  ..style.width = "100%"
  ..style.height = "100%"
  ..style.fontSize = "5px"
  ..style.cursor = "pointer"
  ..id = "checkBtn";

checkBtn.append(btn);

btn.onClick.listen((_) {
  final answers = {
    "word6_input": "Element.tag",
    "word6_1_input": "text",
    "word7_input": "head",
    "word8_input": "append",
  };

  answers.forEach((id, correct) {
    final input = document.getElementById(id) as InputElement;
    if ((input.value ?? "").trim() == correct) {
      input.style.color = "green";
      input.style.border = "1px solid green";
    } else {
      input.style.color = "red";
      input.style.border = "1px solid red";
    }
  });
});



  svg..append(practice2a)..append(practice2a_title)..append(word1_bg)..append(word2_bg)
  ..append(word1)..append(word1_1)..append(word1_2)..append(word6_input)..append(word6_1_input)..append(word1)..append(word7_input)..append(word2)..append(word2_1)..append(word2_2)..append(word8_input)..append(checkBtn)..append(sidenumber);

  // test content
  final testb = document.createElementNS(svgcdn, 'text')..text = 'b'..setAttribute('x', '20')..setAttribute('y', '175')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final testb_title = document.createElementNS(svgcdn, 'text')..text = '''Create a wbsite, that have the title of 'Your Name's Personal Website' '''..setAttribute('x', '30')..setAttribute('y', '175')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final hr2 = document.createElementNS(svgcdn, 'line')..setAttribute('x1', '20')..setAttribute('y1', '185')..setAttribute('x2', '190')..setAttribute('y2', '185')..setAttribute('stroke', 'black')..setAttribute('stroke-width', '0.5')..setAttribute('stroke-linecap', 'round')..setAttribute('stroke-dasharray', '0.1 2');
  final testc = document.createElementNS(svgcdn, 'text')..text = 'c'..setAttribute('x', '20')..setAttribute('y', '195')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final testc_title = document.createElementNS(svgcdn, 'text')..text = '''Create a website, with this output' '''..setAttribute('x', '30')..setAttribute('y', '195')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');

  svg..append(testb)..append(testb_title)..append(hr2)
  ..append(testc)..append(testc_title);

  sec..append(svg);

return sec;
}


void showHtmlPage(String webpage) {
  final body = document.body!;

  // Overlay
  final overlay = DivElement();

  overlay.style
    ..position = "fixed"
    ..top = "0"
    ..left = "0"
    ..width = "100%"
    ..height = "100%"
    ..display = "flex"
    ..alignItems = "center"
    ..justifyContent = "center"
    ..zIndex = "9999";

  // Dialog
  final dialog = DivElement();

  dialog.style
    ..position = "relative"
    ..width = "1300px"
    ..height = "650px"
    ..backgroundColor = "white"
    ..borderRadius = "12px"
    ..padding = "20px"
    ..boxSizing = "border-box";

  // Close button
  final close = ButtonElement()
    ..text = "✕";

  close.style
    ..position = "absolute"
    ..top = "10px"
    ..right = "10px"
    ..width = "35px"
    ..height = "35px"
    ..border = "none"
    ..borderRadius = "50%"
    ..backgroundColor = "red"
    ..color = "white"
    ..cursor = "pointer";

  // HTML preview
  final frame = IFrameElement()
    ..style.width = "100%"
    ..style.height = "100%"
    ..style.border = "none";

  dialog
    ..append(frame)
    ..append(close);

  overlay.append(dialog);
  body.append(overlay);

  close.onClick.listen((_) {
    overlay.remove();
  });

  // Write the HTML into the iframe
frame.srcdoc = webpage;
}


/*

  document.head!..append(title);

*/