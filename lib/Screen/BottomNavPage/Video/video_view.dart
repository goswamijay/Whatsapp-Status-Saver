import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String? VideoPath;
  const VideoView({required this.VideoPath, Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttomList = [
    const Icon(Icons.download),
    const Icon(Icons.share),
  ];

  ChewieController? _ChewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ChewieController = ChewieController(
        videoPlayerController: VideoPlayerController.file(File(widget.VideoPath!)),
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        aspectRatio: 9/16 ,
        errorBuilder: (context, error) {
          return Center(
            child: Text(error),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ChewieController!.pause();
    _ChewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(controller: _ChewieController!),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0,bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            buttomList.length,
            (index) {
              return FloatingActionButton(
                  heroTag: "$index",
                  onPressed: ()async {
                    switch (index) {
                      case 0:
                        log('download image');
                        await ImageGallerySaver.saveFile(widget.VideoPath!).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Video Saved"))
                          );
                        });
                        break;
                      case 1:
                        log('Share image');
                        //FlutterNativeApi.shareVideo(widget.VideoPath);
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
