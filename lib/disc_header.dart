import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'album_model.dart';
import 'core/responsive.dart';

const _colorHeader = Color(0xFFECECEA);

const _maxHeaderExtent = kToolbarHeight * 6;
const _minHeadrerExtent = kToolbarHeight * 2;

//Margin
const _minTopMarginAlbum = 20.0;
const _maxTopMarginAlbum = 160.0;
const _minTopMarginAlbumTablet = 20.0;
const _maxTopMarginAlbumTablet = 200.0;

const _minTopMarginDisk = 35.0;
const _maxTopMarginDisk = 160.0;
const _minTopMarginDiskTablet = 30.0;
const _maxTopMarginDiskTablet = 200.0;
const _minLeftMarginDisk = 35.0;
const _maxLeftMarginDisk = 100.0;

const _minTopMarginText = 20.0;
const _maxTopMarginText = 80.0;
const _minTopMarginTextTablet = 20.0;
const _maxTopMarginTextTablet = 60.0;

const _minLeftMarginText = 130.0;
const _maxLeftMarginText = 150.0;
const _minLeftMarginTextTablet = 250.0;
const _maxLeftMarginTextTablet = 400.0;

//Height
const _minHeightAlbum = 80.0;
const _maxHeighAlbum = 150.0;
const _minHeightAlbumTablet = 95.0;
const _maxHeighAlbumTablet = 250.0;

const _minHeightDisk = 50.0;
const _maxHeightDisk = 150.0;
const _minHeightDiskTablet = 65.0;
const _maxHeightDiskTablet = 250.0;

// Size
const _minSubTitleSize = 16.0;
const _maxSubTitleSize = 20.0;
const _minSubTitleSizeTablet = 25.0;
const _maxSubTitleSizeTablet = 30.0;

const _minTitleSize = 20.0;
const _maxTitleSize = 26.0;
const _minTitleSizeTablet = 30.0;
const _maxTitleSizeTablet = 40.0;

class MyDiscHeader extends SliverPersistentHeaderDelegate {
  final bool isTablet;
  MyDiscHeader({required this.isTablet});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    return Container(
      color: _colorHeader,
      child: Stack(
        children: <Widget>[
          _AnimatedTitle(percent: percent),
          _DiskImage(percent: percent),
          _AlbumImage(percent: percent),
        ],
      ),
    );
  }

  @override
  double get maxExtent => isTablet ? _maxHeaderExtent * 1.5 : _maxHeaderExtent;

  @override
  double get minExtent =>
      isTablet ? _minHeadrerExtent * 1.5 : _minHeadrerExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _AnimatedTitle extends StatelessWidget {
  const _AnimatedTitle({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final topMargin = isTablet
        ? (_maxTopMarginTextTablet * (1 - percent))
            .clamp(_minTopMarginTextTablet, _maxTopMarginTextTablet)
        : (_maxTopMarginText * (1 - percent))
            .clamp(_minTopMarginText, _maxTopMarginText);

    final leftMarginText = isTablet
        ? (_maxLeftMarginTextTablet * (1 - percent))
            .clamp(_minLeftMarginTextTablet, _maxLeftMarginTextTablet)
        : (_maxLeftMarginText * (1 - percent))
            .clamp(_minLeftMarginText, _maxLeftMarginText);

    final titleSize = isTablet
        ? (_maxTitleSizeTablet * (1 - percent))
            .clamp(_minTitleSizeTablet, _maxTitleSizeTablet)
        : (_maxTitleSize * (1 - percent)).clamp(_minTitleSize, _maxTitleSize);

    final subTitleSize = isTablet
        ? (_maxSubTitleSizeTablet * (1 - percent))
            .clamp(_minSubTitleSizeTablet, _maxSubTitleSizeTablet)
        : (_maxSubTitleSize * (1 - percent))
            .clamp(_minSubTitleSize, _maxSubTitleSize);
    final opacity = (percent / 0.5).clamp(0.0, 1.0);
    return Positioned(
      top: topMargin,
      left: leftMarginText,
      child: Opacity(
        opacity: 1 - opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              AlbumModel.currentAlbum.albumArtist,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleSize,
                letterSpacing: -0.5,
              ),
            ),
            // SubTitle
            Text(
              AlbumModel.currentAlbum.albumName,
              style: TextStyle(
                fontSize: subTitleSize,
                letterSpacing: -0.5,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiskImage extends StatelessWidget {
  const _DiskImage({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final topMarginDisk = isTablet
        ? (_maxTopMarginDiskTablet * (1 - percent))
            .clamp(_minTopMarginDiskTablet, _maxTopMarginDiskTablet)
        : (_maxTopMarginDisk * (1 - percent))
            .clamp(_minTopMarginDisk, _maxTopMarginDisk);
    final left = (percent / 0.5).clamp(0.0, 1.0);
    final leftMarginDisk = (_maxLeftMarginDisk * (1 - left))
        .clamp(_minLeftMarginDisk, _maxLeftMarginDisk);

    final heightDisk = isTablet
        ? (_maxHeightDiskTablet * (1 - percent))
            .clamp(_minHeightDiskTablet, _maxHeightDiskTablet)
        : (_maxHeightDisk * (1 - percent))
            .clamp(_minHeightDisk, _maxHeightDisk);

    return Positioned(
      top: topMarginDisk,
      left: leftMarginDisk,
      height: heightDisk,
      child: Transform.rotate(
        angle: vector.radians(360 * percent),
        child: Image.asset(AlbumModel.currentAlbum.imageDisk),
      ),
    );
  }
}

class _AlbumImage extends StatelessWidget {
  const _AlbumImage({required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final topMarginAlbum = isTablet
        ? (_maxTopMarginAlbumTablet * (1 - percent))
            .clamp(_minTopMarginAlbumTablet, _maxTopMarginAlbumTablet)
        : (_maxTopMarginAlbum * (1 - percent))
            .clamp(_minTopMarginAlbum, _maxTopMarginAlbum);

    final heightAlbum = isTablet
        ? (_maxHeighAlbumTablet * (1 - percent))
            .clamp(_minHeightAlbumTablet, _maxHeighAlbumTablet)
        : (_maxHeighAlbum * (1 - percent))
            .clamp(_minHeightAlbum, _maxHeighAlbum);
    return Positioned(
      top: topMarginAlbum,
      left: 35.0,
      height: heightAlbum,
      child: Image.asset(AlbumModel.currentAlbum.imageAlbum),
    );
  }
}
