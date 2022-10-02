
import 'package:flutter/material.dart';

import '../models/font_family_model.dart';
import 'filters.dart';

List<FontFamilyModel> myFontFamilyList = [
  FontFamilyModel(fontName: 'AEROBIC'),
  FontFamilyModel(fontName: "Astral Sisters"),
  FontFamilyModel(fontName: 'AwayStress'),
  FontFamilyModel(fontName: 'BaguetteBread'),
  FontFamilyModel(fontName: 'BeigeWave'),
  FontFamilyModel(fontName: 'Bigcups'),
  FontFamilyModel(fontName: 'Caniago'),
  FontFamilyModel(fontName: 'Cartline Brush'),
  FontFamilyModel(fontName: "deserted-canyon"),
  FontFamilyModel(fontName: 'DOLPHINES'),
  FontFamilyModel(fontName: 'edinburg'),
  FontFamilyModel(fontName: 'Gesturally'),
  FontFamilyModel(fontName: 'GlowingSkin'),
  FontFamilyModel(fontName: 'GOLDEN'),
  FontFamilyModel(fontName: "Highbary Sunfest"),
  FontFamilyModel(fontName: "Hirarki Signature"),
  FontFamilyModel(fontName: 'Hugshack'),
  FontFamilyModel(fontName: 'Januaryta'),
  FontFamilyModel(fontName: "Journal Republica"),
  FontFamilyModel(fontName: "just-because"),
  FontFamilyModel(fontName: "Jute Basket"),
  FontFamilyModel(fontName: 'Listhon'),
  FontFamilyModel(fontName: 'LowMagnetic'),
  FontFamilyModel(fontName: "MONGONDOW"),
  FontFamilyModel(fontName: 'Moonlight'),
  FontFamilyModel(fontName: 'morriles'),
  FontFamilyModel(fontName: 'NightMelody'),
  FontFamilyModel(fontName: 'Palagio'),
  FontFamilyModel(fontName: 'phenomicon'),
  FontFamilyModel(fontName: 'Posting'),
  FontFamilyModel(fontName: "Qapitaly"),
  FontFamilyModel(fontName: 'QEBIL'),
  FontFamilyModel(fontName: 'Qomarun'),
  FontFamilyModel(fontName: 'QueenChallenge'),
  FontFamilyModel(fontName: 'QUINOR'),
  FontFamilyModel(fontName: 'robosapien'),
  FontFamilyModel(fontName: "RockAway"),
  FontFamilyModel(fontName: "Scary Envision"),
  FontFamilyModel(fontName: 'Selebgram'),
  FontFamilyModel(fontName: "Sketch"),
  FontFamilyModel(fontName: 'SouthernAire'),
  FontFamilyModel(fontName: "stay-tuned"),
  FontFamilyModel(fontName: "CRONICLE"),
  FontFamilyModel(fontName: 'VASQUZ'),
  FontFamilyModel(fontName: 'walkthemoon'),
  FontFamilyModel(fontName: 'Another Flight'),
  FontFamilyModel(fontName: 'ArimaKoshi'),
  FontFamilyModel(fontName: 'beautiful'),
  FontFamilyModel(fontName: 'Brown Choco'),
  FontFamilyModel(fontName: 'Calligraffitti'),
  FontFamilyModel(fontName: 'DSFette'),
  FontFamilyModel(fontName: 'Exo'),
  FontFamilyModel(fontName: 'FingerPaint'),
  FontFamilyModel(fontName: 'Hartford'),
  FontFamilyModel(fontName: 'Herdrey'),
  FontFamilyModel(fontName: 'Jelle'),
  FontFamilyModel(fontName: 'Junction'),
  FontFamilyModel(fontName: 'JustBe'),
  FontFamilyModel(fontName: 'LillyMae'),
  FontFamilyModel(fontName: 'LuxuriousScript'),
  FontFamilyModel(fontName: 'Margueritas'),
  FontFamilyModel(fontName: 'MINUS'),
  FontFamilyModel(fontName: 'Rhonde'),
  FontFamilyModel(fontName: 'RubikWetPaint'),
  FontFamilyModel(fontName: 'Satanyc'),
  FontFamilyModel(fontName: 'ShortStack'),
  FontFamilyModel(fontName: 'TribalScript'),
];

final List<List<double>> filters = [
  noFilter,
  SWEET_MATRIX,
  SEPIA_MATRIX,
  GREYSCALE_MATRIX,
  VINTAGE_MATRIX,
  AddictiveRed,
  Negative,
  Grayscale,
  purple,
  Yellow,
  Cyan,
  BlackandWhite,
  OldTimes,
  ColdLife,
];

List<Shadow> myShadowList = [
  Shadow(color: Colors.black, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.red, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.green, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.purple, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.blue, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.orange, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.purpleAccent, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.teal, offset: Offset(5, 5), blurRadius: 5),
  Shadow(color: Colors.yellow, offset: Offset(5, 5), blurRadius: 5),
];

final List<Color> myColorList = [
  Colors.transparent,
  Colors.red,
  Colors.green,
  Colors.black,
  Colors.amberAccent,
  Colors.orangeAccent,
  Colors.redAccent,
  Colors.cyanAccent,
  Colors.indigoAccent,
  Colors.deepOrangeAccent,
  Colors.tealAccent,
  Colors.blueGrey,
  Colors.indigo,
];