import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageView extends StatefulWidget {
  final String? ImagePath;
  const ImageView({required this.ImagePath, Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttomList = [
    const Icon(Icons.download),
    const Icon(Icons.print),
    const Icon(Icons.share),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                fit: BoxFit.contain,
                image: FileImage(File(widget.ImagePath!)))),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            buttomList.length,
            (index) {
              return FloatingActionButton(
                  heroTag: "$index",
                  onPressed: () async {
                    switch (index) {
                      case 0:
                        log('download image');
                        if (Platform.isAndroid) {
                          Directory? directory =
                              await getExternalStorageDirectory();
                          String newPath = "";
                          // print(directory);
                          List<String> paths = directory!.path.split("/");
                          for (int x = 1; x < paths.length; x++) {
                            String folder = paths[x];
                            if (folder != "Android") {
                              newPath += "/" + folder;
                            } else {
                              break;
                            }
                          }
                          newPath = newPath + "/RPSApp";
                          directory = Directory(newPath);

                          if (!await directory.exists()) {
                            await directory.create(recursive: true);
                          }
                          if (await directory.exists()) {
                            File saveFile1 = File(directory.path);
                            //await dio.download(widget.ImagePath!, saveFile1.path);
                            if (Platform.isIOS) {
                              await ImageGallerySaver.saveFile(saveFile1.path,
                                  isReturnPathOfIOS: true);
                            }
                          }
                          /*     await ImageDownloader.downloadImage(widget.ImagePath!,
                                  destination: AndroidDestinationType.custom(
                                      directory: directory.path)
                                    ..inExternalFilesDir()
                                    ..subDirectory(widget.ImagePath!))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Image Saved")));
                          });*/
                          await ImageGallerySaver.saveFile(widget.ImagePath!)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Image Saved")));
                          });
                        }
                      //  print(widget.ImagePath);

                        break;
                      case 1:
                        log('Print image');
                        //  FlutterNativeApi.printImage(widget.ImagePath, widget.ImagePath?.split("/").last);
                        break;
                      case 2:
                        log('Share image');
                        // FlutterNativeApi.shareImage(widget.ImagePath);
                        break;
                    }
                  },
                  child: buttomList[index]);
            },
          ),
        ),
      ),
    );
  }
}
/*
  Future<bool> saveVideo(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/RPSApp";
        directory = Directory(newPath);


        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          File saveFile = File(directory.path + "/$fileName");
          if (Platform.isIOS) {
            await ImageGallerySaver.saveFile(saveFile.path,
                isReturnPathOfIOS: true);
          }
          return true;
        }
      }
    }catch (e) {
      print(e);
    }
    return false;
  }*/
