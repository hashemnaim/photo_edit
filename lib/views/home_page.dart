import 'package:editor/service/ad_service.dart';
import 'package:editor/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/theme.dart';
import '../widgets/myDrawer.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKye = GlobalKey<ScaffoldState>();

  late SharedPreferences prefs;

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    try {
      isColors = prefs.getBool('isColor')!;
    } catch (e) {
      isColors = false;
    }

    if (isColors) {
      try {
        isDark = prefs.getBool('isDark')!;
      } catch (e) {
        isDark = false;
      }
      if (isDark) {
        kWhiteColor = Colors.white;
      } else {
        kWhiteColor = Colors.black;
      }
    }

    try {
      selectedElement = prefs.getInt('element')!;
    } catch (e) {
      selectedElement = 0;
    }

    if (!isColors) {
      kWhiteColor = imageThemes[selectedElement].color;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
    AdmobService.initilizeBanner();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKye, drawer: const MyDrawer(), body: Home(scaffoldKye)),
    );
  }
}
