

import 'package:album_animation/album_model.dart';
import 'package:album_animation/disc_header.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Animated Header
          SliverPersistentHeader(
            delegate: MyDiscHeader(),
            pinned: true,
          ),
          // content of album
          const _TextDescription(),
        ],
      ),
    );
  }
}

class _TextDescription extends StatelessWidget {
  const _TextDescription();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Text(
            AlbumModel.currentAlbum.description,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          )),
    );
  }
}
