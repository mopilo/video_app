import 'package:flutter/material.dart';
import 'package:video_app/core/widget/show_modal.dart';
import 'package:video_app/features/videos/data/model/video_model.dart';
import 'package:video_app/features/videos/presentation/widgets/related_videos.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends StatefulWidget {
  final Videos? assetData;

  const PreviewPage({Key? key, @required this.assetData}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  VideoPlayerController? _controller;
  Videos? assetData;
  bool showInput = false;
  @override
  void initState() {
    super.initState();

    assetData = widget.assetData!;

    _controller = VideoPlayerController.network(
      '${assetData?.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {});
      });
    _controller?.setLooping(true);
    _controller?.videoPlayerOptions;
    _controller?.play();

    // _controller?.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _controller!.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _controller!.value.isPlaying
                                  ? _controller!.pause()
                                  : _controller!.play();
                            },
                            child: VideoPlayer(_controller!))),
                  ),
                )
              : Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: Colors.black,
                      width: double.maxFinite,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
          _controller!.value.isInitialized && showInput
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    alignment: Alignment.bottomLeft,
                    margin:
                        const EdgeInsets.only(right: 80, left: 20, bottom: 15),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.white))),
                    ),
                  ))
              : Container(),
          _controller!.value.isInitialized
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              showInput = !showInput;
                            });
                          },
                          child: Icon(
                            showInput
                                ? Icons.message_rounded
                                : Icons.chat_bubble,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => showModal(context,
                              RelatedVideo(videoAsset: widget.assetData)),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
