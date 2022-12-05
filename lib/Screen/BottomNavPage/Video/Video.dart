import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_status_saver/Screen/BottomNavPage/Video/video_view.dart';
import 'package:whatsapp_status_saver/Utils/getThumbnail.dart';

import '../../../Provider/getStatusProvider.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<getStatusProvider>(builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatus(".mp4");
            Future.delayed(Duration(microseconds: 1));
            _isFetched = true;
          }
          return file.isWhatsappAvailable == false ? const Center(
            child: Text("Whatsapp not Available"),
          ):file.getVideos.isEmpty ? const Center(
            child: Text("No Video avaliable"),
          ):Container(
            padding: const EdgeInsets.all(20),
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                children: List.generate(file.getVideos.length, (index) {
                  final data = file.getVideos[index];
                  return FutureBuilder<String?>(
                   future: getThumbnail(data.path),
                    builder: (context, snapshot) {
                    return  snapshot.hasData ? GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (_) =>  VideoView(VideoPath: data.path,)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(snapshot.data!)),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ):const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  );
                })),
          );
        }));
  }
}
