class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;


  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,

  });

  static List<Song> songs =[
    Song(
      title:'Rick roll',
      description:'rick asley',
      url:'assets/music/2.mp3',
      coverUrl:'assets/images/rick.jpg',
    ),
    Song(
      title:'hieuthuhai',
      description:'hieuthuhai',
      url:'assets/music/1.mp4',
      coverUrl:'assets/images/1.png',
    ),
    Song(
      title:'Sơn Tùng MTP',
      description:'Sơn Tùng MTP',
      url:'assets/music/3.mp4',
      coverUrl:'assets/images/3.png',
    ),
  ];
}