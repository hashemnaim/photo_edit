import 'package:editor/splash_screen.dart';
import 'package:editor/utils/s_helpar.dart';
import 'package:editor/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'config/language/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SHelper.sHelper.initSharedPrefrences();

  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String lang = "ar";

  @override
  void initState() {
    lang = SHelper.sHelper.getLanguge() ?? "ar";
    SHelper.sHelper.setLanguge(lang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 955),
        builder: (context, widget) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Text On Photo',
            translations: Translation(),
            locale: Locale(lang),
            fallbackLocale: Locale(lang),
            theme: ThemeData(
              textTheme: SHelper.sHelper.getLanguge() == "ar"
                  ? GoogleFonts.cairoTextTheme()
                  : GoogleFonts.rajdhaniTextTheme(
                      Theme.of(context).textTheme,
                    ),
            ),
            home: const SplashScreen(),
          );
        });
  }
}
