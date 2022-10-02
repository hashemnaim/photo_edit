import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';
import 'Editor/image_editor_pro.dart';

class MyCreative extends StatefulWidget {
  const MyCreative({Key? key}) : super(key: key);


  @override
  _MyCreativeState createState() => _MyCreativeState();
}

class _MyCreativeState extends State<MyCreative> {
  String? directory;
  List file =  [];
  RxBool isLoading = true.obs;
  void listOfFiles() async {

    try {
      directory = (await getApplicationDocumentsDirectory()).path;
      file = io.Directory("$directory/").listSync();

      file = file.where((element) => element.path.contains('jpg')).toList();

      isLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print("Error while loading files $e");
      }
    }
    if (kDebugMode) {
      print("Total files are ${file.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfFiles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: double.infinity,
            decoration:  isColors?BoxDecoration(
                gradient: LinearGradient(colors: isDark?darkColors[selectedElement]: lightColors[selectedElement],end: Alignment.bottomRight,begin: Alignment.topLeft)
            ) : BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageThemes[selectedElement].smallImage),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: AppBar().preferredSize.height,
                    child: Row(children: [
                      Expanded(
                        // flex: 1,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back, color: kWhiteColor),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Text(
                            'My Creative',
                            style:
                                myTextStyle(18, FontWeight.w600, kWhiteColor),
                          ),
                        ),
                      ),
                      Expanded(
                        // flex: 1,
                        child: Text(
                          '',
                          style: myTextStyle(18, FontWeight.w300, kWhiteColor),
                        ),
                      )
                    ]),
                  ),
                  Obx(() => isLoading.value
                      ?  const Center(child: CircularProgressIndicator(),) :file.isEmpty? SizedBox(

                       width: Get.width,
                        height: Get.height*0.8,
                        child: Center(
                            child: Text(
                              'No Data',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kWhiteColor
                              ),
                            ),
                          ),
                      )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: file.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: FileImage(
                                      File(file[i].path))),
                              title: Text(
                                path.basename(file[i].path),
                                style: TextStyle(color: kWhiteColor),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.off(
                                          () => ImageEditorPro(
                                            appBarColor: Colors.black87,
                                            bottomBarColor: Colors.black87,
                                            pathSave:
                                                io.Directory("$directory/"),
                                            galleryImage: file[i],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: kWhiteColor,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        await File(file[i].path).delete();
                                        file.removeAt(i);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ]),
                              ),
                            );
                          },
                        )),
                ],
              ),
            )),
      ),
    );
  }
}
