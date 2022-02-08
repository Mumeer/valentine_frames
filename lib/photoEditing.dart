import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:valentines_day_frames/colors.dart';
import 'package:valentines_day_frames/showsavedpicture.dart';

class photoEditing extends StatefulWidget {
  const photoEditing({Key? key}) : super(key: key);

  @override
  _photoEditingState createState() => _photoEditingState();
}

int selectedFrame = 0;
List<String> FrameNames = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33"
];

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
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(pinkish[0]),
        title: Text(title),
        actions: [
          image != null
              ? GestureDetector(
                  onTap: () {
                    screenshotController.capture().then((image) async {
                      var bytes = (await image!.toList());

                      savedpics.images.add(await Uint8List.fromList(bytes));
                      final String dir =
                          (await getApplicationDocumentsDirectory()).path;
                      final String fullPath =
                          '$dir/${DateTime.now().millisecond}.png';
                      File capturedFile = File(fullPath);
                      await capturedFile.writeAsBytes(savedpics.images[0]);
                      print(capturedFile.path);

                      await GallerySaver.saveImage(capturedFile.path)
                          .then((value) {
                        // print("saved " + fullPath);
                        savedpics.imagesPath.add(capturedFile.path);
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => showsavedpicture()),
                      );
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: Icon(Icons.save))
              : Container(),
          SizedBox(
            width: 10,
          ),
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
                  child: Icon(Icons.add)),
        ],
      ),
      body: SizedBox.expand(
          child: image == null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(pinkish[0]),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
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
              : Column(
                  children: [
                    Color_background(),

                    Expanded(
                      child: Container(
                          decoration: colorSelected[1] == true
                              ? BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xfffae0e4),
                                  Color(0xffff5c8a)
                                ],
                              ))
                              : BoxDecoration(),

                          child:
                      Screenshot(
                          controller: screenshotController,
                          child:  Stack(children: [
                              Positioned(
                                  left: position.dx,
                                  top: position.dy,
                                  child: Transform.rotate(
                                    angle: angle,
                                    child: Transform.scale(
                                        scale: scale,
                                        child: Image.file(
                                          image!,
                                          height: 200,
                                          width: 200,
                                        )),
                                  )),
                              Positioned.fill(
                                child: GestureDetector(
                                    onScaleUpdate: (details) {
                                      updateScale(details.scale);
                                      updatePosition(details.localFocalPoint);
                                      updateangle(details.rotation);
                                      //scale and rotation now available
                                    },
                                    onScaleEnd: (_) => commitScale(),
                                    child: (selectedFrame != 0)
                                        ? AspectRatio(
                                            aspectRatio: 4 / 3,
                                            child: Image.asset(
                                              "assets/valentines_frames/" +
                                                  selectedFrame.toString() +
                                                  ".png",
                                              fit: BoxFit.fill,
                                            ))
                                        : Container(
                                            color: Colors.transparent,
                                          )),
                              ),
                            ]),
                          )),
                    ),
                    Divider(
                      color: Color(pinkish[1]),
                      thickness: 1,
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
  double angle = 0;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);

  void updateangle(double anglee) {
    // print(anglee);
    setState(() => angle = anglee);
  }

  void commitScale() => setState(() => prevScale = scale);

  void updatePosition(Offset newPosition) =>
      setState(() => position = newPosition);

  Widget createFrameList() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      padding: EdgeInsets.all(2),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: FrameNames.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                // decoration: BoxDecoration(border: Border.all(color: Color(pinkish[1]))),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFrame = index + 1;
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(pinkish[3]), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Color(pinkish[1]),
                      child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.asset(
                            "assets/valentines_frames/" +
                                (index + 1).toString() +
                                ".png",
                            fit: BoxFit.fill,
                          )),
                    )),
              ),
            );
          }),
    );
  }

  List<bool> colorSelected = [false,false];
  Widget Color_background() {
    return Container(
        height: MediaQuery.of(context).size.height / 10,
        padding: EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Background Color"),
            SizedBox(height: 5,),
            ToggleButtons(
              children: [
                Container(
                  color: Colors.white,
                ),
                Icon(Icons.brush,color: Color(0xffff5c8a),)
              ],
              onPressed: (int index){
                  setState(() {
                    if(index == 1){
                colorSelected[0] = false;
                colorSelected[1] = true;}
                else{
                  colorSelected[0] = true;
                  colorSelected[1] = false;
                }
                  });

              },
              isSelected: colorSelected,
            ),
          ],
        )
    );
  }
}
