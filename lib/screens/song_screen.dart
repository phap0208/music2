// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart' as rxdart;
// import '../models/song_model.dart';
// import '../widgets/player_buttons.dart';
// import '../widgets/seekbar.dart';
// import '../widgets/widgets.dart';
//
// class SongScreen extends StatefulWidget {
//   const SongScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SongScreen> createState() => _SongScreenState();
// }
//
// class _SongScreenState extends State<SongScreen> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   Song song = Get.arguments ?? Song.songs[0];
//
//   @override
//   void initState() {
//     super.initState();
//
//     audioPlayer.setAudioSource(
//       ConcatenatingAudioSource(
//         children: [
//           AudioSource.uri(
//             Uri.parse('asset:///${song.url}'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   Stream<SeekBarData> get _seekBarDataStream =>
//       rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
//           audioPlayer.positionStream, audioPlayer.durationStream, (
//           Duration position,
//           Duration? duration,
//           ) {
//         return SeekBarData(
//           position,
//           duration ?? Duration.zero,
//         );
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             song.coverUrl,
//             fit: BoxFit.cover,
//           ),
//           const _BackgroundFilter(),
//           _MusicPlayer(
//             song: song,
//             seekBarDataStream: _seekBarDataStream,
//             audioPlayer: audioPlayer,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MusicPlayer extends StatelessWidget {
//   const _MusicPlayer({
//     Key? key,
//     required this.song,
//     required Stream<SeekBarData> seekBarDataStream,
//     required this.audioPlayer,
//   })  : _seekBarDataStream = seekBarDataStream,
//         super(key: key);
//
//   final Song song;
//   final Stream<SeekBarData> _seekBarDataStream;
//   final AudioPlayer audioPlayer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20.0,
//         vertical: 50.0,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             song.title,
//             style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             song.description,
//             maxLines: 2,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodySmall!
//                 .copyWith(color: Colors.white),
//           ),
//           const SizedBox(height: 30),
//           StreamBuilder<SeekBarData>(
//             stream: _seekBarDataStream,
//             builder: (context, snapshot) {
//               final positionData = snapshot.data;
//               return SeekBar(
//                 position: positionData?.position ?? Duration.zero,
//                 duration: positionData?.duration ?? Duration.zero,
//                 onChangeEnd: audioPlayer.seek,
//               );
//             },
//           ),
//           PlayerButtons(audioPlayer: audioPlayer),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 iconSize: 35,
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.settings,
//                   color: Colors.white,
//                 ),
//               ),
//               IconButton(
//                 iconSize: 35,
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.cloud_download,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _BackgroundFilter extends StatelessWidget {
//   const _BackgroundFilter({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (rect) {
//         return LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.white,
//               Colors.white.withOpacity(0.5),
//               Colors.white.withOpacity(0.0),
//             ],
//             stops: const [
//               0.0,
//               0.4,
//               0.6
//             ]).createShader(rect);
//       },
//       blendMode: BlendMode.dstOut,
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.deepPurple.shade200,
//               Colors.deepPurple.shade800,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import '../models/song_model.dart';
import '../widgets/player_buttons.dart';
import '../widgets/seekbar.dart';
import '../widgets/widgets.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  late Song song;

  @override
  void initState() {
    super.initState();
    song = Get.arguments ?? Song.songs[0];

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playNextSong() {
    int currentIndex = Song.songs.indexOf(song);
    int nextIndex = (currentIndex + 1) % Song.songs.length;
    setState(() {
      song = Song.songs[nextIndex];
    });
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}'),
          ),
        ],
      ),
    );
    audioPlayer.play();
  }

  void playPreviousSong() {
    int currentIndex = Song.songs.indexOf(song);
    int previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = Song.songs.length - 1;
    }
    setState(() {
      song = Song.songs[previousIndex];
    });
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}'),
          ),
        ],
      ),
    );
    audioPlayer.play();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
            (
            Duration position,
            Duration? duration,
            ) {
          return SeekBarData(
            position,
            duration ?? Duration.zero,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),
          const _BackgroundFilter(),
          _MusicPlayer(
            song: song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
            playNextSong: playNextSong,
            playPreviousSong: playPreviousSong,
          ),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatefulWidget {
  const _MusicPlayer({
    Key? key,
    required this.song,
    required this.seekBarDataStream,
    required this.audioPlayer,
    required this.playNextSong,
    required this.playPreviousSong,
  }) : super(key: key);

  final Song song;
  final Stream<SeekBarData> seekBarDataStream;
  final AudioPlayer audioPlayer;
  final VoidCallback playNextSong;
  final VoidCallback playPreviousSong;

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<_MusicPlayer> {
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    isPlaying = widget.audioPlayer.playing;
    widget.audioPlayer.playerStateStream.listen((event) {
      setState(() {
        isPlaying = event.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.song.description,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 70),
          StreamBuilder<SeekBarData>(
            stream: widget.seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangeEnd: widget.audioPlayer.seek,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: widget.playPreviousSong,
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 80,
                onPressed: () {
                  if (isPlaying) {
                    widget.audioPlayer.pause();
                  } else {
                    widget.audioPlayer.play();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: widget.playNextSong,
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.4, 0.6],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
      ),
    );
  }
}




