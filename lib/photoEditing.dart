import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class photoEditing extends StatefulWidget {
  const photoEditing({Key? key}) : super(key: key);

  @override
  _photoEditingState createState() => _photoEditingState();
}

int selectedFrame = 0;
List<String> FrameNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9",
  "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
  "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33"];


class _photoEditingState extends State<photoEditing> {
  String title = "Select Image";

  bool drag = false;

  bool selected = false;
  final picker = ImagePicker();

  File? image;

  Future _imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        title = "Image Selected";
        image = File(pickedFile.path);
      });
      // var bytes =  (await pickedFile.readAsBytes());
      // bytes = Uint8List.fromList(bytes);


      print("done reading");
      // return ByteData.view(bytes.buffer);

    } else {
      print('No image selected.');
    }
  }

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // selected = true;
        title = "Image Selected";
        image = File(pickedFile.path);
      });
      // var bytes =  (await pickedFile.readAsBytes());
      // bytes = Uint8List.fromList(bytes);

      // return ByteData.view(bytes.buffer);


    } else {
      print('No image selected.');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // ExtendedExactAssetImageProvider(Provider.of<imageProvider>(context,listen: false).editImage!.path,cacheRawData: true);
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery. of(context). size. height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff225560),
        title: Text(title),
        actions: [
          image != null
              ? GestureDetector(
              onTap: () {
                setState(() {
                  image = null;
                  title = "Select Image";
                  // selected = false;
                });
              },
              child: Icon(Icons.delete))
              : GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Icon(Icons.add))
        ],
      ),
      body: SizedBox.expand(
          child: image == null
              ? Center(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff225560),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _showPicker(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Choose Image "),
                    Icon(
                      Icons.image,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          )
              :
          Column(
            children: [
              Expanded(
                child:
                GestureDetector(
                  // onTap: (){
                  //   print("tap");
                  //   // setState(() {
                  //   //   drag = true;
                  //   // });
                  // },
                  // onPanCancel: () {
                  //   print("pan");
                  //   setState(() {
                  //     drag = false;
                  //   });
                  // },

                  onScaleUpdate: (details) => updateScale(details.scale),
                  onScaleEnd: (_) => commitScale(),
                  child:
                  Container(
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(FrameNames[0]),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: Screenshot(
                        controller: screenshotController,
                        child:
                        Stack(children: [

                          // Image.asset(FrameNames[0],fit: BoxFit.fill,),
                          // FittedBox(
                          //   child: Image.asset(FrameNames[0],),
                          //   fit: BoxFit.fill,
                          // ),
                          Center(
                            child: Positioned(
                                left: position.dx,
                                top: position.dy,
                                child:
                                Transform.scale(
                                    scale: scale,
                                    child: Image.file(
                                      image!,
                                      height: 200,
                                      width: 200,
                                    ))
                              // Draggable(
                              //     maxSimultaneousDrags: 1,
                              //     feedback: Image.file(
                              //       image!,
                              //       height: 200,
                              //       width: 200,
                              //     ),
                              //     childWhenDragging: Opacity(
                              //       opacity: .3,
                              //       child: Image.file(
                              //         image!,
                              //         height: 200,
                              //         width: 200,
                              //       ),
                              //     ),
                              //     onDragEnd: (details) => updatePosition(details.offset),
                              //     child:
                              //     Transform.scale(
                              //         scale: scale,
                              //         child: Image.file(
                              //           image!,
                              //           height: 200,
                              //           width: 200,
                              //         )),
                              // )
                            ),
                          ),

                          if(selectedFrame != 0)
                            // GestureDetector(
                                // behavior: HitTestBehavior.translucent,
                                // onPanUpdate: (_) {
                                //   updatePosition(_.localPosition);
                                // },
                                // onScaleUpdate: (details) => updateScale(details.scale),
                                // onScaleEnd: (_) => commitScale(),
                                // child:
                                InteractiveViewer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/valentines_frames/"+selectedFrame.toString()+".png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),),
                                )
    // )
                        ])),
                  ),
                ),
              ),
              createFrameList(),
            ],
          )),
    );
  }

  ScreenshotController screenshotController = ScreenshotController();

  Offset position = Offset(100, 100);
  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);

  void commitScale() => setState(() => prevScale = scale);

  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);


  Widget createFrameList() {
    return Container(
      height: MediaQuery. of(context). size. height/6,
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: FrameNames.length,
        itemBuilder: (context, index) {
          return Container(child:
            GestureDetector(
                onTap: (){
                  setState(() {
                   selectedFrame = index+1;
                  });
                },
                child: Card(child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.asset("assets/valentines_frames/"+(index+1).toString()+".png",fit: BoxFit.cover,)),)),);
        }),);
  }

}
