import 'package:editor/widgets/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../views/backgroundScreen.dart';
import '../views/myCreative.dart';
import '../views/photo_college.dart';
import '../views/template.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: Get.height,
            width: double.infinity,
            // margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.only(top: 20),
            decoration:isColors?BoxDecoration(
                gradient: LinearGradient(colors: isDark?darkColors[selectedElement]: lightColors[selectedElement],end: Alignment.bottomRight,begin: Alignment.topLeft)
            ) : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageThemes[selectedElement].largeImage),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                _createDrawerItem(
                  image: 'images/newIcons/home 1.png',
                  text: 'Home',
                  onTap: () => Get.back(),
                ),
                _createDrawerItem(
                    image: 'images/college.png',
                    text: 'Photo College',
                    onTap: () => Get.to(() => const CollageScreen())),
                _createDrawerItem(
                  image: 'images/edit-image.png',
                  text: 'My Create',
                  onTap: () => Get.to(() => const MyCreative()),
                ),
                _createDrawerItem(
                    image: 'images/background.png',
                    text: 'Backgrounds',
                    onTap: () => Get.to(() => const BackgroundScreen())),
                _createDrawerItem(
                    image: 'images/newIcons/page-layout 1.png',
                    text: 'Templates',
                    onTap: () => Get.to(() => const Template())),
                const SizedBox(
                  height: 10,
                ),
               const  Divider(
                  color:   Color(0xff71DECA30),
                ),
                const SizedBox(
                  height: 10,
                ),
                _createDrawerItem(
                  image: 'images/newIcons/rating 1.png',
                  text: 'Rate Us',
                  // onTap: () => Get.to(() => Settings())
                ),
                _createDrawerItem(
                    image: 'images/newIcons/privacy 1.png',
                    text: 'Privacy Policy',
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(
                          'https://pages.flycricket.io/text-on-photo-5/privacy.html'))) {
                        throw 'Could not launch privacy policy';
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {String? image, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
            image!,
            color: kWhiteColor,
          )),
      title: Text(
        text!.tr,
        style: myTextStyle(16, FontWeight.w300, kWhiteColor),
      ),
      onTap: onTap,
    );
  }
}
