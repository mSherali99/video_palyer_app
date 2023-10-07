import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_palyer_app/data/model/video_data.dart';
import 'package:video_palyer_app/presentation/screen/play/play_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../components/shimmer_component.dart';
import '../../components/video_item.dart';

class PlayScreen extends StatefulWidget {
  final VideoData video;
  final VideosStatus status;

  const PlayScreen(this.video, this.status, {super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final block = PlayBloc();

  @override
  Widget build(BuildContext context) {
    block.add(Load(status: widget.status, videoData: widget.video));
    final controller = YoutubePlayerController(
      initialVideoId: widget.video.videoId!,
      flags: const YoutubePlayerFlags(
        isLive: false,
        mute: false,
        autoPlay: true,
        loop: false,
      ),
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        progressColors: ProgressBarColors(
            backgroundColor: Colors.grey,
            playedColor: Colors.red,
            handleColor: Colors.red.shade400),
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return BlocProvider.value(
          value: block,
          child: BlocBuilder<PlayBloc, PlayState>(
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      player,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(widget.video.title ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${getTimeAgo(widget.video.uploadDate ?? "")} ago",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Recommended for you",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          )),
                      const SizedBox(height: 8),
                      if (state.status == EnumStatus.loading)
                        const ShimmerComponent()
                      else if (state.status == EnumStatus.success)
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: state.videosList.length,
                                itemBuilder: (_, i) {
                                  return VideoItem(
                                    lessonData: state.videosList[i],
                                    onClick: (videoData) {
                                      block.add(ChangeVideo(
                                          videoData: state.videosList[i],
                                          context: context,
                                          status: widget.status));
                                    },
                                  );
                                }),
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
    /* },
      ),
    );*/
  }

  String getTimeAgo(String inputDate) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    try {
      DateTime parsedDate = dateFormat.parse(inputDate);
      DateTime currentDate = DateTime.now();

      int years = currentDate.year - parsedDate.year;
      int months = currentDate.month - parsedDate.month;
      int days = currentDate.day - parsedDate.day;

      if (days < 0) {
        months--;
        days += DateTime(currentDate.year, currentDate.month - 1, 0).day;
      }
      if (months < 0) {
        years--;
        months += 12;
      }

      String result = "";
      if (years > 0) {
        result += "$years year ";
      }
      if (months > 0) {
        result += "$months month ";
      }
      if (days > 0) {
        result += "$days day";
      }
      return result;
    } catch (e) {
      return 'Wrong format';
    }
  }
}
