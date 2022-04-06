import 'package:flutter/material.dart';
import 'package:video_app/features/videos/data/model/video_model.dart';
import 'package:video_app/features/videos/presentation/pages/preview_page.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final Videos? assetData;

  const VideoTile({Key? key, @required this.assetData}) : super(key: key);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  VideoPlayerController? _controller;

  bool showInput = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      '${widget.assetData?.url}',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PreviewPage(
                assetData: widget.assetData,
              ),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            // color: CustomColors.muxGray.withOpacity(0.1),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xFF383838).withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: RichText(
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    text: TextSpan(
                      text: 'Name: ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: widget.assetData?.title,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: _controller!.value.isInitialized
                    ? _controller!.value.aspectRatio
                    : 3 / 2,
                child: _controller!.value.isInitialized
                    ? VideoPlayer(_controller!)
                    : Container(
                        color: Colors.black,
                        width: double.maxFinite,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
