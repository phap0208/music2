import 'song_model.dart';

class Playlist{
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist( {
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists =[
    Playlist(
      title: 'Hip-hop',
      songs: Song.songs,
      imageUrl: 'https://i.scdn.co/image/ab67616d0000b273f40a9293e96f3096e95344ca'
    ),
    Playlist(
        title:'Rock & Roll',
        songs: Song.songs,
        imageUrl:'https://i.scdn.co/image/ab67616d0000b273f40a9293e96f3096e95344ca'
    ),
    Playlist(
        title: 'Techno',
        songs: Song.songs,
        imageUrl: 'https://i.scdn.co/image/ab67616d0000b273f40a9293e96f3096e95344ca'
    ),
  ];
}