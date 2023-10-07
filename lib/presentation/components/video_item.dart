import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_palyer_app/data/model/video_data.dart';

class VideoItem extends StatefulWidget {
  final VideoData lessonData;
  final Function(VideoData) onClick;

  const VideoItem({super.key, required this.lessonData, required this.onClick});

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.onClick(widget.lessonData),
          child: Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.lessonData.thumbnail!,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Center(
                        child: SizedBox(
                            height: 70,
                            width: 70,
                            child: CircularProgressIndicator(
                                color: Colors.black))),
                  ),
                ),
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
                Opacity(
                  opacity: 0.7,
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/ic_play.png")),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: /*RichText(

              text: TextSpan(children: [
                TextSpan(
                    text: widget.lessonData.title,
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                const WidgetSpan(child: Spacer()),
                TextSpan(
                    text: widget.lessonData.uploadDate,
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ]),
            )*/
              Text(
            widget.lessonData.title ?? "",
            maxLines: 2,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Uploaded",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                Text("${getTimeAgo(widget.lessonData.uploadDate ?? "")} ago",
                    textAlign: TextAlign.end, style: TextStyle(fontSize: 16, color: Colors.red)),
              ],
            )),
        SizedBox(height: 16)
      ],
    );
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
