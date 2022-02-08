
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:valentines_day_frames/colors.dart';
import 'package:share_plus/share_plus.dart';

class showsavedpicture extends StatefulWidget {
  const showsavedpicture({Key? key}) : super(key: key);

  @override
  _showsavedpictureState createState() => _showsavedpictureState();
}

class _showsavedpictureState extends State<showsavedpicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(pinkish[0]),
        title: Text("Save Pictures"),
        actions: [

          GestureDetector(
              onTap: () {
              },
              child: Icon(Icons.add))

        ],
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Image.memory(savedpics.images[savedpics.images.length-1]),
            TextButton(
                onPressed: ()async{
                  Share.shareFiles([savedpics.imagesPath[0]], text: 'Great picture');
                  // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
              color: Color(pinkish[0]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Share ",style: TextStyle(color: Colors.white,fontSize: 22),),
                  Icon(Icons.share,color: Colors.white,size: 26,)

                ],
              ),
            ))
          ],
        ),
      ),);
  }
}

class savedpics{
  static List<Uint8List> images = [];
  static List<String> imagesPath = [];
}