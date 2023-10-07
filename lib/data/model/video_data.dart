class VideoData {
  String? url= "";
  String? title= "";
  String? showName= "";
  String? videoId= "";
  int? indexNo=0;
  String? thumbnail= "";
  String? uploadDate= "";

  VideoData( {
    this.url,
    this.title,
    this.showName,
    this.videoId,
    this.indexNo,
    this.thumbnail,
    this.uploadDate,
  });

  VideoData.fromJson(Map<String, dynamic> json) {
    url = json['URL'];
    title = json['Title'];
    showName = json['Showname'];
    videoId = json['Video_id'];
    indexNo = json['index_no'];
    thumbnail = json['Thumbnail'];
    uploadDate = json['Upload_date'];
  }
}
