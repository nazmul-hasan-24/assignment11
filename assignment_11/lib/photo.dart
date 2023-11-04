class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  Photo(
       this.id,
       this.title,
      this.thumbnailUrl,
     this.url);

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
     json['id'] ??'',
      json['title'] ??'',
     json['thumbnailUrl'] ??'',
  json['url'] ??'',
    );
  }
}