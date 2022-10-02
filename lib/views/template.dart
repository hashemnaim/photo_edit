import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editor/models/sticker_model.dart';
import 'package:editor/views/Editor/image_editor_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 5, left: 10, bottom: 10),
          height: double.infinity,
          decoration:isColors?BoxDecoration(
              gradient: LinearGradient(colors: isDark?darkColors[selectedElement]: lightColors[selectedElement],end: Alignment.bottomRight,begin: Alignment.topLeft)
          ) : BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageThemes[selectedElement].largeImage),
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
                        icon:const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          'Template',
                          style: myTextStyle(18, FontWeight.w600, kWhiteColor),
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('templates').snapshots(),
                    builder: (context, snapshot) {


                      if(!snapshot.hasData){
                        return SizedBox(
                          width: double.infinity,
                          height: Get.height * 0.6,
                          child:const  Center(child: CircularProgressIndicator()),
                        );
                      }

                      final data = snapshot.data!.docs;

                      return Container(
                        // color: Colors.yellow,
                        margin: const EdgeInsets.only(right: 5),
                        child: GridView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            // controller: scrollController,
                            physics:const  NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4),
                            itemBuilder: (ctx, i) {


                              BackgroundModel template = BackgroundModel.fromJson(data[i].data());

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ImageEditorPro(
                                    backgroundImagePath: template.image!,
                                  ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                    template.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
