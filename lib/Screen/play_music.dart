import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import '../../../modal.dart';

class Play_music extends StatefulWidget {
  const Play_music({Key? key}) : super(key: key);

  @override
  _Play_musicState createState() => _Play_musicState();
}

class _Play_musicState extends State<Play_music> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool puse = false;
  Duration totalDuration = Duration(seconds: 0);
  Duration currantDuration = Duration(seconds: 0);



  @override
  Widget build(BuildContext context) {
    List? index = ModalRoute.of(context)!.settings.arguments as List?;

    playAudio() async {
      assetsAudioPlayer
          .open(
        Audio(
          "${[audio[index![0]].audio]}",
        ),
      )
          .then((value) {
        assetsAudioPlayer.current.listen((playingAudio) {
          setState(() {
            totalDuration = assetsAudioPlayer.current.value!.audio.duration;
          });
        });
      });
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              dispose();
              Navigator.pop(context);
            }),
        title: Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            audio[index![0]].name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "${index[1]}",
                ),
                fit: BoxFit.cover,

              ),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: assetsAudioPlayer.currentPosition,
                builder: (context, AsyncSnapshot snapShot) {
                  if (snapShot.data != null) currantDuration = snapShot.data;

                  return Text(
                    currantDuration.toString().split(".")[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  );
                },
              ),
              Text(
                //" / Helo",
                " / ${totalDuration.toString().split(".")[0]}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 1,
            ),
            child: StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, AsyncSnapshot snapShot) {
                Duration currentPosition = snapShot.data;

                return Slider(
                  value: currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: totalDuration.inSeconds.toDouble(),
                  activeColor: Colors.green,
                  inactiveColor: Colors.white.withOpacity(0.8),
                  onChanged: (val) {
                    setState(() {
                      assetsAudioPlayer.seek(
                        Duration(
                          seconds: val.toInt(),
                        ),
                      );
                      currantDuration = Duration(
                        seconds: val.toInt(),
                      );
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  log("hello", name: "Mini");
                  setState(() {
                    assetsAudioPlayer.stop();

                    puse = !puse;
                  });
                },
                icon: const Icon(Icons.stop, size: 28, color: Colors.white),
              ),
              (assetsAudioPlayer.current.hasValue)
                  ? AudioWidget.assets(
                path: "",
                play: false,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      puse = !puse;
                      assetsAudioPlayer.playOrPause();
                    });
                  },
                  icon: (puse)
                      ? const Icon(
                    (Icons.play_arrow),
                    color: Colors.white,
                    size: 33,
                  )
                      : const Icon(
                    (Icons.pause),
                    color: Colors.white,
                    size: 33,
                  ),
                  alignment: Alignment.center,
                  iconSize: 45,
                ),
              )
                  : IconButton(
                onPressed: () {
                  playAudio();
                  setState(() {});
                },
                icon: Icon(
                  (Icons.play_arrow),
                  color: Colors.white,
                  size: 50,
                ),
                alignment: Alignment.center,
                iconSize: 50,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.headphones, size: 28, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.dispose();
  }
}
