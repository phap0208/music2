import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music2/models/playlist_model.dart';
import 'package:music2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:music2/screens/song_screen.dart';

import 'screens/playlist_screen.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp ({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'futter Demo',
      theme:ThemeData(
        textTheme:Theme.of(context).textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen() ),
        GetPage(name: '/song', page: () => const SongScreen() ),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
      ],
    );
  }

}