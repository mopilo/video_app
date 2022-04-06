import 'package:flutter/material.dart';
import 'package:video_app/features/videos/data/datasource/server.dart';
import 'package:video_app/features/videos/data/model/assets_data.dart';

import '../widgets/video_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isProcessing = false;
  final ClientCall _clientCall = ClientCall();

  @override
  void initState() {
    _clientCall.initializeDio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Video stream'),
        // backgroundColor: CustomColors.muxPink,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<AssetData>(
              future: _clientCall.getAssetList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AssetData assetData = snapshot.data!;
                  int length = assetData.data.length;

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return VideoTile(assetData: assetData.data[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 10.0,
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
