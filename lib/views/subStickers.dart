import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/sticker_model.dart';
import '../utils/app_colors.dart';
import '../utils/theme.dart';
import '../widgets/textStyle.dart';
import 'Editor/image_editor_pro.dart';

// ignore: must_be_immutable
class SubStickers extends StatefulWidget {
  String? title;
  SubStickers({Key? key, this.title}) : super(key: key);



  @override
  _SubStickersState createState() => _SubStickersState();
}

class _SubStickersState extends State<SubStickers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: double.infinity,
          decoration: isColors?BoxDecoration(
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
                        icon: Icon(Icons.arrow_back, color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          widget.title!,
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

                Container(
                  // color: Colors.yellow,
                  margin: const EdgeInsets.only(right: 5),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('SubStickers').where('title',isEqualTo: widget.title).snapshots(),
                      builder: (context, snapshot) {


                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        final data = snapshot.data!.docs;

                        return GridView.builder(
                            itemCount:data.length,
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4),
                            itemBuilder: (ctx, i) {


                              SubSticker sticker = SubSticker.fromJson(data[i].data());

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ImageEditorPro(
                                    backgroundImagePath:
                                   sticker.image!,
                                  ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                    sticker.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            });
                      }
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
