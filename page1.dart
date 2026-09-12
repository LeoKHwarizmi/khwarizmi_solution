import 'dart:html';

Element buildPage1() {
  const svgcdn = 'http://www.w3.org/2000/svg';

  final sec = Element.tag('section')..classes.addAll(['section']);
  final svg = document.createElementNS(svgcdn, 'svg')..setAttribute('width', '210mm')..setAttribute('height', '297mm')..setAttribute('viewBox', '0 0 210 297');
  
  // header
  final course_banner = document.createElementNS(svgcdn, 'polygon')..setAttribute('points', '0,0 210,0 210,60 0,70')..setAttribute('fill', 'CadetBlue');
  final course_number_circle = document.createElementNS(svgcdn, 'circle')..setAttribute('cx', '200')..setAttribute('cy', '10')..setAttribute('r', '35')..setAttribute('fill', 'white');
  final course_number = document.createElementNS(svgcdn, 'text')..text = '01'..setAttribute('x', '175')..setAttribute('y', '30')..setAttribute('font-size', '30')..setAttribute('font-weight', '1000')..setAttribute('font-family', 'Impact')..setAttribute('fill', 'CadetBlue');
  final course_title = document.createElementNS(svgcdn, 'text')..text = '.Tag'..setAttribute('x', '15')..setAttribute('y', '20')..setAttribute('font-size', '10')..setAttribute('font-weight', '800')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'RoyalBlue');
  final course_subtitle = document.createElementNS(svgcdn, 'text')..text = 'DOCTYPE'..setAttribute('x', '38')..setAttribute('y', '30')..setAttribute('font-size', '10')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'white');
  final defs = document.createElementNS(svgcdn, 'defs');
  final clipPath = document.createElementNS(svgcdn, 'clipPath')..setAttribute('id', 'roundedImage');
  final roundedRect = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '20')..setAttribute('y', '40')..setAttribute('width', '170')..setAttribute('height', '60')..setAttribute('rx', '5')..setAttribute('ry', '5');
  clipPath.append(roundedRect);defs.append(clipPath);
  final course_image = document.createElementNS(svgcdn, 'image')..setAttribute('href', 'lessen1.jpg')..setAttribute('x', '20')..setAttribute('y', '40')..setAttribute('width', '170')..setAttribute('height', '60')..setAttribute('preserveAspectRatio', 'xMidYMid slice')..setAttribute('clip-path', 'url(#roundedImage)')..setAttribute('transform', 'rotate(3 90 85)');
  final sidenumber = document.createElementNS(svgcdn, 'text')..text = '01\u00A0\u00A0|\u00A0\u00A0One'..setAttribute('font-size', '5')..setAttribute('fill', 'black')..setAttribute('x', '200')..setAttribute('y', '245')..setAttribute('transform', 'rotate(-90 195 245)');

  svg..append(defs)..append(course_banner)..append(course_number_circle)..append(course_number)..append(course_title)
  ..append(course_subtitle)..append(sidenumber)..append(course_image);

  // footer
  final footer_title = document.createElementNS(svgcdn, 'text')..text = 'Learn Goal'..setAttribute('x', '95')..setAttribute('y', '273')..setAttribute('font-size', '4')..setAttribute('font-weight', '500')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final hr1 = document.createElementNS(svgcdn, 'line')..setAttribute('x1', '30')..setAttribute('y1', '275')..setAttribute('x2', '180')..setAttribute('y2', '275')..setAttribute('stroke', 'green')..setAttribute('stroke-width', '0.5');
  final footer_content = document.createElementNS(svgcdn, 'text')..text = 'Basic Tags: doctype, html, head, body'..setAttribute('x', '35')..setAttribute('y', '281')..setAttribute('font-size', '4')..setAttribute('font-weight', '500')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final hr2 = document.createElementNS(svgcdn, 'line')..setAttribute('x1', '30')..setAttribute('y1', '285')..setAttribute('x2', '180')..setAttribute('y2', '285')..setAttribute('stroke', 'green')..setAttribute('stroke-width', '0.5');

  svg..append(footer_title)..append(hr1)..append(footer_content)..append(hr2);

  // main content
  final practice1 = document.createElementNS(svgcdn, 'text')..text = '1'..setAttribute('x', '20')..setAttribute('y', '115')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final practice1_title = document.createElementNS(svgcdn, 'text')..text = 'Speak With Me!'..setAttribute('x', '30')..setAttribute('y', '115')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice1a = document.createElementNS(svgcdn, 'text')..text = 'a'..setAttribute('x', '20')..setAttribute('y', '123')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final practice1a_title = document.createElementNS(svgcdn, 'text')..text = 'How to code it?'..setAttribute('x', '30')..setAttribute('y', '123')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice1a_description = document.createElementNS(svgcdn, 'text')..text = 'Watch the Video and pay attention who codes what.'..setAttribute('x', '30')..setAttribute('y', '131')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');

  final practice2a = document.createElementNS(svgcdn, 'text')..text = 'b'..setAttribute('x', '20')..setAttribute('y', '155')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final practice2a_title = document.createElementNS(svgcdn, 'text')..text = 'How to define it?'..setAttribute('x', '30')..setAttribute('y', '155')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice2a_wort1 = document.createElementNS(svgcdn, 'text')..text = 'Tag'..setAttribute('x', '30')..setAttribute('y', '163')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice2a_line1 = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '30')..setAttribute('y', '167')..setAttribute('width', '1')..setAttribute('height', '10')..setAttribute('fill', 'SteelBlue');
  final practice2a_description1 = document.createElementNS(svgcdn, 'text')..text = 'A code that define how a web browser must format and display contents'..setAttribute('x', '35')..setAttribute('y', '173')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'SteelBlue');
  
  final practice2a_wort2 = document.createElementNS(svgcdn, 'text')..text = 'DOCTYPE'..setAttribute('x', '30')..setAttribute('y', '188')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice2a_line2 = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '30')..setAttribute('y', '192')..setAttribute('width', '1')..setAttribute('height', '10')..setAttribute('fill', 'SteelBlue');
  final practice2a_description2 = document.createElementNS(svgcdn, 'text')..text = 'It is an "information" to the browser about what document type to expect.'..setAttribute('x', '35')..setAttribute('y', '198')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'SteelBlue');

  final practice3a = document.createElementNS(svgcdn, 'text')..text = 'c'..setAttribute('x', '20')..setAttribute('y', '222')..setAttribute('font-size', '5')..setAttribute('font-weight', '900')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'green');
  final practice3a_title = document.createElementNS(svgcdn, 'text')..text = 'How you code it?'..setAttribute('x', '30')..setAttribute('y', '222')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');
  final practice3a_description = document.createElementNS(svgcdn, 'text')..text = 'Watch the Video and pay attention who codes what.'..setAttribute('x', '30')..setAttribute('y', '230')..setAttribute('font-size', '5')..setAttribute('font-family', 'Times New Roman')..setAttribute('fill', 'black');

  svg..append(defs)..append(practice1)..append(practice1_title)..append(practice1a)..append(practice1a_title)
  ..append(practice1a_description)..append(practice2a)..append(practice2a_title)
  ..append(practice2a_wort1)..append(practice2a_line1)..append(practice2a_description1)
  ..append(practice2a_wort2)..append(practice2a_line2)..append(practice2a_description2)
  ..append(practice3a)..append(practice3a_title)..append(practice3a_description);

// buttons
  final btn = document.createElementNS(svgcdn, 'g');
  final rectbtn = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '5')..setAttribute('y', '111')..setAttribute('width', '12')..setAttribute('height', '12')..setAttribute('rx', '3')..setAttribute('fill', 'CadetBlue')..style.cursor = 'pointer';
  final iconbtn = document.createElementNS(svgcdn, 'image')..setAttribute('href', 'youtube.svg')..setAttribute('x', '7')..setAttribute('y', '113')..setAttribute('width', '8')..setAttribute('height', '8')..style.pointerEvents = 'none';

  final btn1 = document.createElementNS(svgcdn, 'g');
  final rect_btn1 = document.createElementNS(svgcdn, 'rect')..setAttribute('x', '6')..setAttribute('y', '218')..setAttribute('width', '12')..setAttribute('height', '12')..setAttribute('rx', '3')..setAttribute('fill', 'CadetBlue')..style.cursor = 'pointer';
  final icon_btn1 = document.createElementNS(svgcdn, 'image')..setAttribute('href', 'code.svg')..setAttribute('x', '8')..setAttribute('y', '220')..setAttribute('width', '8')..setAttribute('height', '8')..style.pointerEvents = 'none';
  btn1..append(rect_btn1)..append(icon_btn1);
  btn1.onClick.listen((_) {window.open('https://stackblitz.com/edit/stackblitz-starters-acd5l6xf?file=index.html','myWindow');});
  btn..append(rectbtn)..append(iconbtn);

  svg..append(btn)..append(btn1);

  sec..append(svg);

// Click event
btn.onClick.listen((_) {
  showOnboarding();
});

return sec;
}

void showOnboarding() {
  final body = document.body!;
  // Overlay
  final overlay = DivElement();
  overlay.style
    ..position = "fixed"
    ..top = "0"
    ..left = "0"
    ..width = "100%"
    ..height = "100%"
    ..backgroundColor = "rgba(0,0,0,0.5)"
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
    ..borderRadius = "50%"
    ..border = "none"
    ..backgroundColor = "red"
    ..color = "white"
    ..fontSize = "20px"
    ..cursor = "pointer";
  // YouTube video
  final video = IFrameElement()
  ..src = "https://www.youtube.com/embed/Vlzqf6Ldg5w"
    ..width = "100%"
    ..height = "100%"
    ..style.border = "none"
    ..allowFullscreen = true;
  // Close action
  close.onClick.listen((_) {
    overlay.remove();
  });
  dialog
    ..append(video)
    ..append(close);
  overlay.append(dialog);
  body.append(overlay);
}


/*

<!DOCTYPE html>
<html>
<head>
<title>Eliott — Freelance UI/UX Designer & Frontend Dev</title>
<link rel="icon" type="image/x-icon" href="code.svg">
</head>
</html>
<body></body>
</html>

*/