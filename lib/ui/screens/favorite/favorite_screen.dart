import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w6_homework/model/song.dart';
import 'package:w6_homework/ui/states/settings_state.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import '../../theme/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the global song repository
    SongRepository songRepository = context.read<SongRepository>();
    List<Song> songs = songRepository.fetchSongs();

    // 3 - Watch the global player state
    PlayerState playerState = context.watch<PlayerState>();

    // 4 - Watch the global settings state
    AppSettingsState appSettingsState = context.watch<AppSettingsState>();

    return Container(
      color: appSettingsState.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Favorite", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongTile(
                onTap: () {
                  if (songs[index] == playerState.currentSong) {
                    playerState.stop();
                  } else {
                    playerState.start(songs[index]);
                  }
                },
                song: songs[index],
                isPlaying: playerState.currentSong == songs[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // 1 - Watch the global settings state
    AppSettingsState appSettingsState = context.watch<AppSettingsState>();

    return ListTile(
      title: Text(song.title),
      onTap: onTap,
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: TextStyle(color: appSettingsState.theme.color),
      ),
    );
  }
}
