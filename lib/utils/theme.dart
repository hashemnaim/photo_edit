import 'package:editor/models/image_theme_model.dart';
import 'package:flutter/material.dart';

int selectedElement = 0;

List<ImageThemeModel> imageThemes = [
  ImageThemeModel('images/bgc.png', 'images/bg.png', Colors.white),
  ImageThemeModel('images/newIcons/01.jpg',  'images/newIcons/001.jpg', Colors.white),
  ImageThemeModel('images/newIcons/02.jpg', 'images/newIcons/002.jpg', Colors.white),
  ImageThemeModel('images/newIcons/03.jpg', 'images/newIcons/003.jpg', Colors.white),
  ImageThemeModel( 'images/newIcons/04.jpg','images/newIcons/004.jpg', Colors.white),
  ImageThemeModel( 'images/newIcons/05.jpg', 'images/newIcons/005.jpg',Colors.white),
];

List<List<Color>> lightColors = const [

  [Color(0xffD8C9AF),Color(0xffD8C9AF),],
  [Color(0xff91CEC2),Color(0xff91CEC2),],

  [Color(0xffECEFF4),Color(0xffECEFF4),],
  [Color(0xffCFF1D6),Color(0xffCFF1D6),],

  [Color(0xffD0F2B1),Color(0xffD0F2B1),],
  [Color(0xff87B9E7),Color(0xff87B9E7),],

  [Color(0xff8FBCBB),Color(0xff8FBCBB),],

  [Color(0xffA2EC8E),Color(0xffA2EC8E),],

  [Color(0xffA58998),Color(0xffA58998),],
  [Color(0xffB48EAD),Color(0xffB48EAD),],

  [Color(0xffFFEB6D),Color(0xffFFEB6D),],

  [Color(0xffA7AB99),Color(0xffA7AB99),],
  [Color(0xffFECB4D),Color(0xffFECB4D),],

  [Color(0xffF7F6AF),Color(0xffF7F6AF),],

  [Color(0xffFFE0AB),Color(0xffFFE0AB),],
  [Color(0xffEDE7F8),Color(0xffEDE7F8),],
  [Color(0xffE7EAF5),Color(0xffE7EAF5),],
  [Color(0xffE4ECEF),Color(0xffE4ECEF),],
  [Color(0xffFEF2F2),Color(0xffFEF2F2),],
  [Color(0xffF0FDF4),Color(0xffF0FDF4),],
  [Color(0xffFFFBEB),Color(0xffF0FDF4),],




];

List<List<Color>> darkColors =const [

  [Color(0xff241730),Color(0xff19162D),],
  [Color(0xff578887),Color(0xff578887),],
  [Color(0xff4662B2),Color(0xff4662B2),],
  [Color(0xff4C566A),Color(0xff4C566A),],
  [Color(0xff4B709A),Color(0xff4B709A),],
  [Color(0xff3A4565),Color(0xff3A4565),],
  [Color(0xff6273BD),Color(0xff6273BD),],
  [Color(0xffBF616A),Color(0xffBF616A),],
  [Color(0xff788991),Color(0xff788991),],
  [Color(0xff1E538F),Color(0xff1E538F),],
  [Color(0xff81323D),Color(0xff81323D),],
  [Color(0xffA990DD),Color(0xffA990DD),],
  [Color(0xff8B7D7D),Color(0xff8B7D7D),],
  [Color(0xff638A8D),Color(0xff638A8D),],
  [Color(0xff7C7A66),Color(0xff7C7A66),],
  [Color(0xff1871AC),Color(0xff1871AC),],
  [Color(0xffAB1438),Color(0xffAB1438),],
  [Color(0xff5F41B2),Color(0xff5F41B2),],
  [Color(0xff7A6E49),Color(0xff7A6E49),],
  [Color(0xffF12E6D),Color(0xffF12E6D),],
  [Color(0xff4E6C54),Color(0xff4E6C54),],
  [Color(0xff474E95),Color(0xff474E95),],
  [Color(0xff5EBAD9),Color(0xff5EBAD9),],
  [Color(0xffFB0049),Color(0xffFB0049),],
  [Color(0xff525D49),Color(0xff525D49),],
  [Color(0xff757397),Color(0xff757397),],
  [Color(0xff5E81AC),Color(0xff5E81AC),],
  [Color(0xff715D50),Color(0xff715D50),],
  [Color(0xff1EA5FC),Color(0xff1EA5FC),],
  [Color(0xffFC3644),Color(0xffFC3644),],
  [Color(0xff5B7971),Color(0xff5B7971),],
  [Color(0xff474E95),Color(0xff474E95),],
  [Color(0xff225D7D),Color(0xff15394C),],
  [Color(0xff15394C),Color(0xff15394C),],
  [Color(0xff14532D),Color(0xff14532D),],
  [Color(0xff111827),Color(0xff111827),],


];


bool isColors = false;
bool isDark = false;

final List<Map<String, dynamic>> myCardList = [
  {
    'text': 'Text On Photo',
    'image': "images/textonphoto.png",
  },
  {
    'text': 'Camera',
    'image': "images/newIcons/camera 1.png",
  },
  {
    'text': 'My Creative',
    'image': "images/edit-image.png",
  },
  {
    'text': 'Background',
    'image': "images/background.png",
  },
  {
    'text': 'Template',
    'image': "images/newIcons/page-layout 1.png",
  },
  {
    'text': 'Photo Collage',
    'image': "images/college.png",
  },
];
