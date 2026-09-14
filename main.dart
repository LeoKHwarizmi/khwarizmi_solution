import 'dart:html';
import 'style.dart';
import 'action.dart';
import 'dart:math' as math;
import 'page1.dart';
import 'page2.dart';
import 'style.dart';
import 'action.dart';

  final html = document.documentElement!;
  final head = document.head!;
    final title = TitleElement()..text = 'Dart Web Page';
  final body = document.body!;
    final svgcdn = "http://www.w3.org/2000/svg";
    final svg = document.createElementNS(svgcdn,'svg',)
    ..setAttribute('width', '100%')
    ..setAttribute('height', '100%')
    ..setAttribute('viewBox', '0 0 1200 800')
    ..setAttribute('preserveAspectRatio','none');
      final world = document.createElementNS(svgcdn,'g',)
      ..setAttribute('id', 'world');
      

void main() {
if ((window.location.pathname ?? "").endsWith("html.html")) {

  // --------------------------------------------------
  // Site icon / Favicon
  // --------------------------------------------------

  final favicon = LinkElement()
    ..rel = 'icon'
    ..type = 'image/jpeg'
    ..href = 'khs logo.jpeg';

  document.head!.append(favicon);

final page1 = buildPage1();
final page2 = buildPage2();

// If buildPage2 crashes, at least page1 still shows:
document.body!..append(page1)..append(Element.tag('br'))..append(page2);

  // Change URL from /html.html to /
  window.history.replaceState(null, '', '/khwarizmi_solution/');

  // --------------------------------------------------
  // Navigation SVG
  // --------------------------------------------------

  final navSvg = document.createElementNS(svgcdn, 'svg')
    ..setAttribute('width', '100%')
    ..setAttribute('height', '100%')
    ..setAttribute('viewBox', '0 0 210 297')
    ..setAttribute('preserveAspectRatio', 'none')
    ..style.position = 'fixed'
    ..style.top = '0'
    ..style.left = '0'
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.pointerEvents = 'none';



// --------------------------------------------------
// Back button
// --------------------------------------------------

final button = document.createElementNS(svgcdn, 'g')
  ..setAttribute('id', 'button-left')
  ..style.cursor = 'pointer'
  ..style.pointerEvents = 'all';

// --------------------------------------------------
// Back button ellipse
// --------------------------------------------------

final circle = document.createElementNS(svgcdn, 'ellipse')
  ..setAttribute('cx', '7')
  ..setAttribute('cy', '150')
  ..setAttribute('rx', '5')
  ..setAttribute('ry', '9')
  ..setAttribute('fill', 'black')
  ..setAttribute('fill-opacity', '0.09')
  ..setAttribute('stroke', 'black')
  ..setAttribute('stroke-opacity', '0.09');

// --------------------------------------------------
// Back arrow
// --------------------------------------------------

final text = document.createElementNS(svgcdn, 'text')
  ..text = '←'
  ..setAttribute('x', '7')
  ..setAttribute('y', '150')
  ..setAttribute('text-anchor', 'middle')
  ..setAttribute('dominant-baseline', 'middle')
  ..setAttribute('font-size', '7')
  ..setAttribute('fill', 'black')
  ..setAttribute('pointer-events', 'none');

// --------------------------------------------------
// Tutorials text
// --------------------------------------------------

final gototutorial = document.createElementNS(svgcdn, 'text')
  ..text = 'Tutorials'
  ..setAttribute('x', '8')
  ..setAttribute('y', '140')
  ..setAttribute('text-anchor', 'middle')
  ..setAttribute('font-size', '4')
  ..setAttribute('font-family', 'Arial, sans-serif')
  ..setAttribute('font-weight', 'normal')
  ..setAttribute('fill', 'Gray')
  ..setAttribute('pointer-events', 'none');

// --------------------------------------------------
// Put everything inside button
// --------------------------------------------------

button
  ..append(circle)
  ..append(text)
  ..append(gototutorial);

// --------------------------------------------------
// Button action
// --------------------------------------------------

button.onClick.listen((event) {
  fromHtmlRToTuts();
});

// --------------------------------------------------
// Put button in navigation layer
// --------------------------------------------------

navSvg.append(button);

// --------------------------------------------------
// Put navigation layer outside section
// --------------------------------------------------

document.body!.append(navSvg);

  // CSS + actions
  loadcss();
  loadscript();

  return;
}

  html.setAttribute('lang', 'en-US');
  head.append(title);

  createHome();
  createTuts();
  // createHtml();
  createAbout();
  createContact();
  createFooter();

  final page1 = buildPage1();

  svg.append(world);
  body.append(svg)..append(page1);

if (window.sessionStorage['open-tuts'] == 'true') {
  world.setAttribute('transform', 'translate(-1200 0)');
  window.sessionStorage.remove('open-tuts');
}
}

void fromHtmlRToTuts() {
  final svg = document.querySelector('.section')?.querySelector('svg');

  if (svg == null) return;

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    // Page 1 → RIGHT
    final x = 1200 * eased;

    svg.setAttribute(
      'transform',
      'translate($x 0)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    } else {
      // Tell the main page to open the Tuts page
      window.sessionStorage['open-tuts'] = 'true';

      // Return to the main address
      window.location.href = '/khwarizmi_solution/';
    }
  }

  window.requestAnimationFrame(animate);
}


void fromTutsGoToHtml() {
  final page1 = document.querySelector('.section')?.querySelector('svg');

  if (page1 == null) {
    window.location.href = "/khwarizmi_solution/html.html";
    return;
  }

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final elapsed =
        DateTime.now().millisecondsSinceEpoch - start;

    double progress = elapsed / 600;

    if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = -1200 * eased;

    page1.setAttribute(
      'transform',
      'translate($x 0)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    } else {
      window.location.href = "/khwarizmi_solution/html.html";
    }
  }

  page1.setAttribute(
    'transform',
    'translate(0 0)',
  );

  window.requestAnimationFrame(animate);
}

Element createPage(String id, int x, int y) {
  final page = document.createElementNS(svgcdn,'svg')
  ..setAttribute('id', 'page-$id')
  ..setAttribute('class', 'page');

  final posx = x * 1200;

  final posy = y * 800;

  page.setAttribute('transform', 'translate($posx $posy)');


  world.append(page);

  return page;
}



void createHome() {
  final home = createPage('home', 0, 0);
  
  final logo = document.createElementNS(svgcdn, 'text')..text = 'Khwarizmi'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y',800 / 2 - 60)
  ..setAttribute('class', 'page-title')
  ..setAttribute('text-anchor', 'middle');

  final logo1 = document.createElementNS(svgcdn, 'text')..text = 'Solution'
  ..setAttribute('x', 1200 / 2 + 3)
  ..setAttribute('y',800 / 2 - 10)
  ..setAttribute('class', 'page-title1')
  ..setAttribute('text-anchor', 'middle');

  final logo2 = document.createElementNS(svgcdn, 'text')
  ..text = 'An Omrani Research Industries Project'
  ..setAttribute('x', 1200 / 2 + 50)
  ..setAttribute('y', 800 / 2 + 15)
  ..setAttribute('text-anchor', 'middle')
  ..setAttribute('fill', 'LightSteelBlue')
  ..setAttribute('font-size', '20px');

  svg.onContextMenu.listen((event) {
    event.preventDefault();
  });

  svg.onMouseDown.listen((event) {
    event.preventDefault();
  });

  svg.onDragStart.listen((event) {
    event.preventDefault();
  });

  final button = document.createElementNS(svgcdn, 'g',)
  ..setAttribute('id', 'button-up')
  ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn,'circle',)
  ..setAttribute('cx', 1200 / 2)
  ..setAttribute('cy', 50)
  ..setAttribute('r', '28',)
  ..setAttribute('fill', '#ffffff',)
  ..setAttribute('fill-opacity','0.08',)
  ..setAttribute('stroke','#ffffff',)
  ..setAttribute('stroke-opacity','0.25',);

  final text = document.createElementNS(svgcdn,'text',)..text = '↑'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 50)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','24',)
  ..setAttribute('fill','white',)
  ..setAttribute('pointer-events','none',);

  final gotoabout = document.createElementNS(svgcdn,'text',)..text = 'About Us'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 90)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button.onClick.listen((event) {
    fromHomeGoToAbout();
  });

  final button1 = document.createElementNS(svgcdn, 'g',)
  ..setAttribute('id', 'button-down')
  ..setAttribute('class', 'nav-button');

  final circle1 = document.createElementNS(svgcdn,'circle',)
  ..setAttribute('cx', 1200 / 2)
  ..setAttribute('cy', 800 - 50)
  ..setAttribute('r', '28',)
  ..setAttribute('fill', '#ffffff',)
  ..setAttribute('fill-opacity','0.08',)
  ..setAttribute('stroke','#ffffff',)
  ..setAttribute('stroke-opacity','0.25',);

  final text1 = document.createElementNS(svgcdn,'text',)..text = '↓'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 800 - 50)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','24',)
  ..setAttribute('fill','white',)
  ..setAttribute('pointer-events','none',);

  final gotosupport = document.createElementNS(svgcdn,'text',)..text = 'Support'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 800 - 85)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button1.onClick.listen((event) {
    fromHomeGoToContact();
  });

  final button2 = document.createElementNS(svgcdn, 'g',)
  ..setAttribute('id', 'button-right')
  ..setAttribute('class', 'nav-button');

  final circle2 = document.createElementNS(svgcdn,'circle',)
  ..setAttribute('cx', 1200 - 50)
  ..setAttribute('cy', 800 / 2)
  ..setAttribute('r', '28',)
  ..setAttribute('fill', '#ffffff',)
  ..setAttribute('fill-opacity','0.08',)
  ..setAttribute('stroke','#ffffff',)
  ..setAttribute('stroke-opacity','0.25',);

  final text2 = document.createElementNS(svgcdn,'text',)..text = '→'
  ..setAttribute('x', 1200 - 50)
  ..setAttribute('y', 800 / 2)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','24',)
  ..setAttribute('fill','white',)
  ..setAttribute('pointer-events','none',);

  final gototutorials = document.createElementNS(svgcdn,'text',)..text = 'Tutorials'
  ..setAttribute('x', 1200 - 50)
  ..setAttribute('y', 800 / 2 - 35)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button2.onClick.listen((event) {
    fromHomeGoToTuts();
  });


  final editorButton = document.createElementNS(svgcdn, 'g')
  ..setAttribute('id', 'editor-button')
  ..setAttribute('class', 'nav-button')
  ..style.cursor = 'pointer';

  final editorCircle = document.createElementNS(svgcdn, 'circle')
  ..setAttribute('cx', '50')
  ..setAttribute('cy', '400')
  ..setAttribute('r', '28')
  ..setAttribute('fill', '#ffffff')
  ..setAttribute('fill-opacity', '0.08')
  ..setAttribute('stroke', '#ffffff')
  ..setAttribute('stroke-opacity', '0.25');

  final editorText = document.createElementNS(svgcdn, 'text')
  ..text = '←'
  ..setAttribute('x', '50')
  ..setAttribute('y', '400')
  ..setAttribute('text-anchor', 'middle')
  ..setAttribute('font-size', '24')
  ..setAttribute('fill', 'white')
  ..setAttribute('pointer-events', 'none');

  final gotoeditor = document.createElementNS(svgcdn,'text',)..text = 'Sybil Studio'
  ..setAttribute('x', '50')
  ..setAttribute('y', '365')
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  editorButton
  ..append(editorCircle)
  ..append(editorText)..append(gotoeditor);

  editorButton.onClick.listen((event) {
  print('EDITOR BUTTON CLICKED');

  window.open(
  'sybilstudio.dev/',
  '_blank',
  );
  });


// -------------------------
// HOME FOOTER
// -------------------------

final footer = document.createElementNS(svgcdn, 'g')
  ..setAttribute('id', 'home-footer');


final footerClipPath = document.createElementNS(svgcdn, 'clipPath')
  ..setAttribute('id', 'footerLogoClip');

final footerCircle = document.createElementNS(svgcdn, 'circle')
  ..setAttribute('cx', '55')
  ..setAttribute('cy', '765')
  ..setAttribute('r', '27');

footerClipPath.append(footerCircle);
svg.append(footerClipPath);

final footerLogo = document.createElementNS(svgcdn, 'image')
  ..setAttribute('href', 'footerlogo.png')
  ..setAttribute('x', '20')
  ..setAttribute('y', '730')
  ..setAttribute('width', '75')
  ..setAttribute('height', '75')
  ..setAttribute('preserveAspectRatio', 'xMidYMid meet')
  ..setAttribute('clip-path', 'url(#footerLogoClip)');

// -------------------------
// SITE NAME
// -------------------------

final footerName = document.createElementNS(svgcdn, 'text')
  ..text = 'mrani Research Industries'
  ..setAttribute('x', '78')
  ..setAttribute('y', '782')
  ..setAttribute('font-size', '14')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.65');


// -------------------------
// PRIVACY POLICY LINK
// -------------------------

final privacy = document.createElementNS(svgcdn, 'text')
  ..text = 'Privacy Policy'
  ..setAttribute('x', '850')
  ..setAttribute('y', '770')
  ..setAttribute('font-size', '13')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.60')
  ..setAttribute('cursor', 'pointer')
  ..setAttribute('pointer-events', 'all');

privacy.onClick.listen((event) {
  window.open('privacy.html', '_blank');
});


// -------------------------
// TERMS LINK
// -------------------------

final terms = document.createElementNS(svgcdn, 'text')
  ..text = 'Terms'
  ..setAttribute('x', '965')
  ..setAttribute('y', '770')
  ..setAttribute('font-size', '13')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.60')
  ..setAttribute('cursor', 'pointer')
  ..setAttribute('pointer-events', 'all');

terms.onClick.listen((event) {
  window.open('terms.html', '_blank');
});
// -------------------------
// COPYRIGHT
// -------------------------

final copyright = document.createElementNS(svgcdn, 'text')
  ..text = 'ORI © 2026'
  ..setAttribute('x', '1050')
  ..setAttribute('y', '770')
  ..setAttribute('font-size', '13')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.40');

// -------------------------
// APPEND FOOTER
// -------------------------

footer
  ..append(footerLogo)
  ..append(footerName)
  ..append(privacy)
  ..append(terms)
  ..append(copyright);


// -------------------------
// JOIN SOCIETY
// -------------------------

final joinGroup = document.createElementNS(svgcdn, 'g')
  ..setAttribute('id', 'join-society')
  ..setAttribute('class', 'nav-button');

// "Join to"
final joinText1 = document.createElementNS(svgcdn, 'text')
  ..text = 'Join'
  ..setAttribute('x', '900')
  ..setAttribute('y', '45')
  ..setAttribute('font-size', '15')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.75')
  ..setAttribute('text-anchor', 'end')
  ..setAttribute('pointer-events', 'none');

// Society button
final societyButton = document.createElementNS(svgcdn, 'rect')
  ..setAttribute('x', '910')
  ..setAttribute('y', '0')
  ..setAttribute('width', '80')
  ..setAttribute('height', '57')
  ..setAttribute('fill', 'Maroon')
  ..setAttribute('fill-opacity', '0.5')
  ..setAttribute('cursor', 'pointer');

// Society text
final societyText = document.createElementNS(svgcdn, 'text')
  ..text = 'Society'
  ..setAttribute('x', '950')
  ..setAttribute('y', '45')
  ..setAttribute('font-size', '17')
  ..setAttribute('fill', 'white')
  ..setAttribute('text-anchor', 'middle')
  ..setAttribute('pointer-events', 'none');

// "and become a Dartist"
final joinText2 = document.createElementNS(svgcdn, 'text')
  ..text = 'and become a Dartist'
  ..setAttribute('x', '1000')
  ..setAttribute('y', '45')
  ..setAttribute('font-size', '15')
  ..setAttribute('fill', 'white')
  ..setAttribute('opacity', '0.75')
  ..setAttribute('text-anchor', 'start')
  ..setAttribute('pointer-events', 'none');

// Hover effect
societyButton.onMouseEnter.listen((event) {
  societyButton
    ..setAttribute('fill', 'DarkOrange');
  societyText.setAttribute('fill', 'black');
});

societyButton.onMouseLeave.listen((event) {
  societyButton
  ..setAttribute('x', '910')
  ..setAttribute('y', '0')
  ..setAttribute('width', '80')
  ..setAttribute('height', '57')
  ..setAttribute('fill', 'Maroon')
  ..setAttribute('fill-opacity', '0.5')
  ..setAttribute('cursor', 'pointer');

  societyText.setAttribute('fill', 'white');
});

// Click
societyButton.onClick.listen((event) {
  window.open('https://discord.gg/znC3MUagHn', '_blank');
});

joinGroup
  ..append(joinText1)
  ..append(societyButton)
  ..append(societyText)
  ..append(joinText2);


  button..append(circle)..append(text)..append(gotoabout);
  button1..append(circle1)..append(text1)..append(gotosupport);
  button2..append(circle2)..append(text2)..append(gototutorials);
  home..append(logo)..append(logo1)..append(logo2)..append(button)..append(button1)..append(button2)
  ..append(editorButton)..append(footer)..append(joinGroup);
}

void createTuts() {
  final home = createPage('tuts', 1, 0);

  final button1 = document.createElementNS(svgcdn, 'g',)
  ..setAttribute('id', 'button-right')
  ..setAttribute('class', 'nav-button');

  final rect1 = document.createElementNS(svgcdn, 'rect')
  ..setAttribute('x', 1200 / 2 - 140,)
  ..setAttribute('y', 250)
  ..setAttribute('width', '280')
  ..setAttribute('height', '180')
  ..setAttribute('rx', '20')
  ..setAttribute('fill', 'CornflowerBlue');

  final text1 = document.createElementNS(svgcdn, 'text')..text = 'html'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y',800 / 2 - 70)
  ..setAttribute('class', 'page-title')
  ..setAttribute('text-anchor', 'middle');

  button1.onClick.listen((event) {
    fromTutsGoToHtml();
  });

  final button = document.createElementNS(svgcdn, 'g',)
  ..setAttribute('id', 'button-left')
  ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn,'circle',)
  ..setAttribute('cx', 50)
  ..setAttribute('cy', 800 / 2)
  ..setAttribute('r', '28',)
  ..setAttribute('fill', '#ffffff',)
  ..setAttribute('fill-opacity','0.08',)
  ..setAttribute('stroke','#ffffff',)
  ..setAttribute('stroke-opacity','0.25',);

  final text = document.createElementNS(svgcdn,'text',)..text = '←'
  ..setAttribute('x', 50)
  ..setAttribute('y', 800 / 2)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','24',)
  ..setAttribute('fill','white',)
  ..setAttribute('pointer-events','none',);

  final gotohome = document.createElementNS(svgcdn,'text',)..text = 'Home'
  ..setAttribute('x', '50')
  ..setAttribute('y', '365')
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button.onClick.listen((event) {
    fromTutsGoToHome();
  });

  button1..append(rect1)..append(text1);
  button..append(circle)..append(text)..append(gotohome);
  home..append(button1)..append(button);
}

void createHtml() {
  // Get page 1
  final page1 = buildPage1();

  // Back button
  final button = document.createElementNS(svgcdn, 'g')
    ..setAttribute('id', 'button-left')
    ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn, 'circle')
    ..setAttribute('cx', '50')
    ..setAttribute('cy', '400')
    ..setAttribute('r', '28')
    ..setAttribute('fill', 'black')
    ..setAttribute('fill-opacity', '0.10')
    ..setAttribute('stroke', 'black')
    ..setAttribute('stroke-opacity', '0.50');

  final text = document.createElementNS(svgcdn, 'text')
    ..text = '←'
    ..setAttribute('x', '50')
    ..setAttribute('y', '408')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '24')
    ..setAttribute('fill', 'black')
    ..setAttribute('pointer-events', 'none');

  button.onClick.listen((event) {
    fromHtmlGoToTuts();
  });

  button
    ..append(circle)
    ..append(text);

  // Add everything
  world
    ..append(page1)
    ..append(button);
}


void fromhtmlGoToTut() {
  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    // Tuts → Home
    final x = -1200 + (1200 * eased);
    const y = 0;

    world.setAttribute(
      'transform',
      'translate($x $y)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromTutsGoToHome() {
  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    // Tuts → Home
    final x = -1200 + (1200 * eased);
    const y = 0;

    world.setAttribute(
      'transform',
      'translate($x $y)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromPage1GoTohtml() {
  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    // Tuts → Home
    final x = -1200 + (1200 * eased);
    const y = 0;

    world.setAttribute(
      'transform',
      'translate($x $y)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromHtmlGoToTuts() {
  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = -2400 + (1200 * eased);
    const y = 0;

    world.setAttribute(
      'transform',
      'translate($x $y)',
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    } else {
      world.setAttribute(
        'transform',
        'translate(-1200 0)',
      );
    }
  }

  window.requestAnimationFrame(animate);
}

void fromHomeGoToTuts() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = -1200 * eased;
    final y = 0;

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}


void createAbout() {

  final about = createPage('about', 0, -1);

  final title1 = document.createElementNS(svgcdn, 'text')
    ..text = 'Khwarizmi Solution'
    ..setAttribute('x', '50')
    ..setAttribute('y', '80')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text1 = document.createElementNS(svgcdn, 'text')
    ..text = 'Khwarizmi Solution is a technology and education project developed by Omrani Research Industries (ORI).'
    ..setAttribute('x', '50')
    ..setAttribute('y', '100')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');


  // -------------------------
  // KHwarizmi ONLINE LEARNING
  // -------------------------

  final title2 = document.createElementNS(svgcdn, 'text')
    ..text = 'Khwarizmi Online Learning Platform'
    ..setAttribute('x', '50')
    ..setAttribute('y', '170')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text2 = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '50')
    ..setAttribute('y', '190')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line1 = document.createElementNS(svgcdn, 'tspan')
    ..text = 'An online learning environment created to make programming education more accessible to people around the world.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '0');

  final line2 = document.createElementNS(svgcdn, 'tspan')
    ..text = 'The platform focuses on practical learning, experimentation, and building real software through programming.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');

  final line3 = document.createElementNS(svgcdn, 'tspan')
    ..text = 'Sybil Studio provides the development environment used to write, test, and run Dart Web applications.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');

  text2
    ..append(line1)
    ..append(line2)
    ..append(line3);


  // -------------------------
  // SYBIL STUDIO
  // -------------------------

  final title3 = document.createElementNS(svgcdn, 'text')
    ..text = 'Sybil Studio'
    ..setAttribute('x', '50')
    ..setAttribute('y', '290')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text3 = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '50')
    ..setAttribute('y', '310')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line3a = document.createElementNS(svgcdn, 'tspan')
    ..text = 'Sybil Studio is a multi-file Dart Web IDE designed for developing and experimenting with web applications.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '0');

  final line3b = document.createElementNS(svgcdn, 'tspan')
    ..text = 'It is a product of Omrani Research Industries (ORI) and a core part of the Khwarizmi Solution project.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');

  text3
    ..append(line3a)
    ..append(line3b);


  // -------------------------
  // BULLSEYE DART ENGINE
  // -------------------------

  final title4 = document.createElementNS(svgcdn, 'text')
    ..text = 'Bullseye Dart Engine'
    ..setAttribute('x', '50')
    ..setAttribute('y', '410')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text4 = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '50')
    ..setAttribute('y', '430')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line4a = document.createElementNS(svgcdn, 'tspan')
    ..text = 'Bullseye is the Dart engine that powers the core execution workflow of Sybil Studio.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '0');

  final line4b = document.createElementNS(svgcdn, 'tspan')
    ..text = 'It coordinates the tasks required to process, compile, and run Dart Web code within the platform.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');

  text4
    ..append(line4a)
    ..append(line4b);


  // -------------------------
  // OMranI RESEARCH INDUSTRIES
  // -------------------------

  final title5 = document.createElementNS(svgcdn, 'text')
    ..text = 'Omrani Research Industries (ORI)'
    ..setAttribute('x', '50')
    ..setAttribute('y', '530')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text5 = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '50')
    ..setAttribute('y', '550')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line5a = document.createElementNS(svgcdn, 'tspan')
    ..text = 'Omrani Research Industries (ORI) is an independent technology initiative focused on software and digital solutions.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '0');

  final line5b = document.createElementNS(svgcdn, 'tspan')
    ..text = 'Its mission is to explore technology, develop useful software, and create tools that contribute to a more digital world.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');

  text5
    ..append(line5a)
    ..append(line5b);


  // -------------------------
  // ABOUT ME
  // -------------------------

  final title6 = document.createElementNS(svgcdn, 'text')
    ..text = 'About Me'
    ..setAttribute('x', '50')
    ..setAttribute('y', '650')
    ..setAttribute('font-size', '28')
    ..setAttribute('fill', 'white');

  final text6 = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '50')
    ..setAttribute('y', '670')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line6a = document.createElementNS(svgcdn, 'tspan')
    ..text = 'My name is Mohammad Reza Omrani. I am a software engineer and the founder of Omrani Research Industries (ORI).'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '0');

  final line6b = document.createElementNS(svgcdn, 'tspan')
    ..text = 'I build software and technology projects with a focus on programming, web development, and digital innovation.'
    ..setAttribute('x', '50')
    ..setAttribute('dy', '20');


  text6
    ..append(line6a)
    ..append(line6b);


  // -------------------------
  // BOTTOM BUTTON
  // -------------------------

  final button = document.createElementNS(svgcdn, 'g')
    ..setAttribute('id', 'button-left')
    ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn, 'circle')
    ..setAttribute('cx', '600')
    ..setAttribute('cy', '750')
    ..setAttribute('r', '28')
    ..setAttribute('fill', '#ffffff')
    ..setAttribute('fill-opacity', '0.08')
    ..setAttribute('stroke', '#ffffff')
    ..setAttribute('stroke-opacity', '0.25');

  final text = document.createElementNS(svgcdn, 'text')
    ..text = '↓'
    ..setAttribute('x', '600')
    ..setAttribute('y', '758')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '24')
    ..setAttribute('fill', 'white')
    ..setAttribute('pointer-events', 'none');

  final gotohome = document.createElementNS(svgcdn, 'text')
    ..text = 'Home'
    ..setAttribute('x', '600')
    ..setAttribute('y', '715')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '15')
    ..setAttribute('fill', 'Gray')
    ..setAttribute('pointer-events', 'none');

  button.onClick.listen((event) {
    fromAboutGoToHome();
  });

  button
    ..append(circle)
    ..append(text)
    ..append(gotohome);


  // -------------------------
  // ADD EVERYTHING
  // -------------------------

  about
    ..append(button)
    ..append(title1)
    ..append(text1)
    ..append(title2)
    ..append(text2)
    ..append(title3)
    ..append(text3)
    ..append(title4)
    ..append(text4)
    ..append(title5)
    ..append(text5)
    ..append(title6)
    ..append(text6);
}



void createContact() {
  final about = createPage('contact', 0, 1);

  // -------------------------
  // CONTACT TEXT
  // -------------------------

  final contactText = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '600')
    ..setAttribute('y', '350')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite');

  final line1 = document.createElementNS(svgcdn, 'tspan')
    ..text = 'For support and frequently asked questions (FAQ), please contact me by email at:'
    ..setAttribute('x', '600')
    ..setAttribute('dy', '0');

  contactText
    ..append(line1);


  // -------------------------
  // EMAIL LINK
  // -------------------------

  final emailLink = document.createElementNS(svgcdn, 'a')
    ..setAttribute(
      'href',
      'mailto:omrani.mohammadreze.1993@gmail.com',
    )
    ..setAttribute(
      'target',
      '_blank',
    );

  final emailText = document.createElementNS(svgcdn, 'text')
    ..text = 'omrani.mohammadreze.1993@gmail.com'
    ..setAttribute('x', '600')
    ..setAttribute('y', '380')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'DodgerBlue')
    ..setAttribute('text-decoration', 'underline')
    ..setAttribute('pointer-events', 'auto')
    ..setAttribute('cursor', 'pointer');

  emailLink.append(emailText);


  // -------------------------
  // TOP BUTTON
  // -------------------------

  final button = document.createElementNS(svgcdn, 'g')
    ..setAttribute('id', 'button-up')
    ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn, 'circle')
    ..setAttribute('cx', '600')
    ..setAttribute('cy', '50')
    ..setAttribute('r', '28')
    ..setAttribute('fill', '#ffffff')
    ..setAttribute('fill-opacity', '0.08')
    ..setAttribute('stroke', '#ffffff')
    ..setAttribute('stroke-opacity', '0.25');

  final text = document.createElementNS(svgcdn, 'text')
    ..text = '↑'
    ..setAttribute('x', '600')
    ..setAttribute('y', '58')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '24')
    ..setAttribute('fill', 'white')
    ..setAttribute('pointer-events', 'none');

  final gotohome = document.createElementNS(svgcdn,'text',)..text = 'Home'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 90)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button.onClick.listen((event) {
    fromContactGoToHome();
  });

  button
    ..append(circle)
    ..append(text)..append(gotohome);


  // -------------------------
  // BOTTOM BUTTON
  // -------------------------

  final button1 = document.createElementNS(svgcdn, 'g')
    ..setAttribute('id', 'button-left')
    ..setAttribute('class', 'nav-button');

  final circle1 = document.createElementNS(svgcdn, 'circle')
    ..setAttribute('cx', '600')
    ..setAttribute('cy', '750')
    ..setAttribute('r', '28')
    ..setAttribute('fill', '#ffffff')
    ..setAttribute('fill-opacity', '0.08')
    ..setAttribute('stroke', '#ffffff')
    ..setAttribute('stroke-opacity', '0.25');

  final text1 = document.createElementNS(svgcdn, 'text')
    ..text = '↓'
    ..setAttribute('x', '600')
    ..setAttribute('y', '758')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '24')
    ..setAttribute('fill', 'white')
    ..setAttribute('pointer-events', 'none');

  final gotonews = document.createElementNS(svgcdn,'text',)..text = 'Newsletter'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 800 - 85)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button1.onClick.listen((event) {
    fromContactGoToFooter();
  });

  button1
    ..append(circle1)
    ..append(text1)..append(gotonews);


  // -------------------------
  // ADD EVERYTHING
  // -------------------------

  about
    ..append(contactText)
    ..append(emailLink)
    ..append(button)
    ..append(button1);
}

void createFooter() {
  final footer = createPage('footer', 0, 2);

  // -------------------------
  // NEWSLETTER TEXT
  // -------------------------

  final newsletterText = document.createElementNS(svgcdn, 'text')
    ..setAttribute('x', '600')
    ..setAttribute('y', '340')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'FloralWhite')
    ..setAttribute('pointer-events', 'none');

  final line1 = document.createElementNS(svgcdn, 'tspan')
    ..text =
        'For being up to date and receiving our news, you can join our newsletter channels:'
    ..setAttribute('x', '600')
    ..setAttribute('dy', '0');

  newsletterText.append(line1);

  // -------------------------
  // DISCORD LINK
  // -------------------------

  final discordLink = document.createElementNS(svgcdn, 'a')
    ..setAttribute('href', 'https://discord.com/')
    ..setAttribute('target', '_blank')
    ..setAttribute('pointer-events', 'all')
    ..setAttribute('cursor', 'pointer');

  final discordText = document.createElementNS(svgcdn, 'text')
    ..text = 'Discord'
    ..setAttribute('x', '430')
    ..setAttribute('y', '370')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'DodgerBlue')
    ..setAttribute('text-decoration', 'underline')
    ..setAttribute('pointer-events', 'all');

  discordLink.append(discordText);

  // -------------------------
  // FACEBOOK LINK
  // -------------------------

  final facebookLink = document.createElementNS(svgcdn, 'a')
    ..setAttribute('href', 'https://www.facebook.com/')
    ..setAttribute('target', '_blank')
    ..setAttribute('pointer-events', 'all')
    ..setAttribute('cursor', 'pointer');

  final facebookText = document.createElementNS(svgcdn, 'text')
    ..text = 'Facebook'
    ..setAttribute('x', '560')
    ..setAttribute('y', '370')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'DodgerBlue')
    ..setAttribute('text-decoration', 'underline')
    ..setAttribute('pointer-events', 'all');

  facebookLink.append(facebookText);

  // -------------------------
  // X LINK
  // -------------------------

  final xLink = document.createElementNS(svgcdn, 'a')
    ..setAttribute('href', 'https://x.com/')
    ..setAttribute('target', '_blank')
    ..setAttribute('pointer-events', 'all')
    ..setAttribute('cursor', 'pointer');

  final xText = document.createElementNS(svgcdn, 'text')
    ..text = 'X'
    ..setAttribute('x', '660')
    ..setAttribute('y', '370')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'DodgerBlue')
    ..setAttribute('text-decoration', 'underline')
    ..setAttribute('pointer-events', 'all');

  xLink.append(xText);

  // -------------------------
  // LINKEDIN LINK
  // -------------------------

  final linkedinLink = document.createElementNS(svgcdn, 'a')
    ..setAttribute('href', 'https://www.linkedin.com/')
    ..setAttribute('target', '_blank')
    ..setAttribute('pointer-events', 'all')
    ..setAttribute('cursor', 'pointer');

  final linkedinText = document.createElementNS(svgcdn, 'text')
    ..text = 'LinkedIn'
    ..setAttribute('x', '760')
    ..setAttribute('y', '370')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '18')
    ..setAttribute('fill', 'DodgerBlue')
    ..setAttribute('text-decoration', 'underline')
    ..setAttribute('pointer-events', 'all');

  linkedinLink.append(linkedinText);

  // -------------------------
  // TOP BUTTON
  // -------------------------

  final button = document.createElementNS(svgcdn, 'g')
    ..setAttribute('id', 'button-up')
    ..setAttribute('class', 'nav-button');

  final circle = document.createElementNS(svgcdn, 'circle')
    ..setAttribute('cx', '${1200 / 2}')
    ..setAttribute('cy', '50')
    ..setAttribute('r', '28')
    ..setAttribute('fill', '#ffffff')
    ..setAttribute('fill-opacity', '0.08')
    ..setAttribute('stroke', '#ffffff')
    ..setAttribute('stroke-opacity', '0.25');

  final text = document.createElementNS(svgcdn, 'text')
    ..text = '↑'
    ..setAttribute('x', '${1200 / 2}')
    ..setAttribute('y', '58')
    ..setAttribute('text-anchor', 'middle')
    ..setAttribute('font-size', '24')
    ..setAttribute('fill', 'white')
    ..setAttribute('pointer-events', 'none');

  final gotosupport = document.createElementNS(svgcdn,'text',)..text = 'Support'
  ..setAttribute('x', 1200 / 2)
  ..setAttribute('y', 90)
  ..setAttribute('text-anchor','middle',)
  ..setAttribute('font-size','15',)
  ..setAttribute('fill','Gray',)
  ..setAttribute('pointer-events','none',);

  button.onClick.listen((event) {
    fromFooterGoToContact();
  });

  // -------------------------
  // ADD EVERYTHING
  // -------------------------

  button
    ..append(circle)
    ..append(text)..append(gotosupport);

  footer
    ..append(newsletterText)
    ..append(discordLink)
    ..append(facebookLink)
    ..append(xLink)
    ..append(linkedinLink)
    ..append(button);
}

void fromContactGoToHome() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = -800 + (800 * eased);

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromFooterGoToContact() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = -1600 + (800 * eased);

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}


void fromHomeGoToAbout() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = 800 * eased;

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromAboutGoToHome() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = 800 - (800 * eased);

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromContactGoToFooter() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = -800 - (800 * eased);

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

void fromHomeGoToContact() {

  final start = DateTime.now().millisecondsSinceEpoch;

  void animate(num timestamp) {

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsed = now - start;

    double progress = elapsed / 600;

    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }

    final eased = easeInOut(progress);

    final x = 0;
    final y = -800 * eased;

    world.setAttribute(
      'transform',
      'translate($x $y)'
    );

    if (progress < 1) {
      window.requestAnimationFrame(animate);
    }
  }

  window.requestAnimationFrame(animate);
}

double easeInOut(double value) {

  if (value < 0.5) {
  return 2 * value * value;
  }

  return 1 - math.pow(-2 * value + 2, 2) / 2;
}