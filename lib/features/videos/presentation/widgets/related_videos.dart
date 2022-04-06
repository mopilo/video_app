import 'package:flutter/material.dart';
import 'package:video_app/features/videos/data/model/video_model.dart';
import 'package:video_player/video_player.dart';

class RelatedVideo extends StatefulWidget {
  const RelatedVideo({
    Key? key,
    this.videoAsset,
  }) : super(key: key);
  final Videos? videoAsset;

  @override
  State<RelatedVideo> createState() => _RelatedVideoState();
}

class _RelatedVideoState extends State<RelatedVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      '${widget.videoAsset?.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {});
      });

    // _controller?.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(30),
                  child: const Text(
                    "Related Videos",
                  )),
              _controller!.value.isInitialized
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_relatedItem(), _relatedItem()],
                      ),
                    )
                  : const SizedBox()
            ],
          )),
    );
  }

  Widget _relatedItem() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: VideoPlayer(_controller!),
      ),
    );
  }
}
