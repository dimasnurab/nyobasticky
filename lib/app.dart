import 'dart:ui';

import 'package:flutter/material.dart';

class NYOBAAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NYOBA STICKY'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _buildGrid(),
          _buildSticky(),
          _buildSliverList(),
        ],
      ),
    );
  }

  Widget _buildGrid() => SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 4, right: 4, left: 4, bottom: 4),
            color: Colors.teal,
            height: 40.0,
          );
        }, childCount: 8),
      );

  Widget _buildSliverList() {
    return SliverFixedExtentList(
      itemExtent: 150,
      delegate: SliverChildListDelegate(
        [
          for (var i = 0; i < 10; i++)
            _buildContainer2(
              Colors.cyan[100 * (i % 9)],
            ),
        ],
      ),
    );
  }

  Container _buildContainer2(Color color) {
    return Container(
        margin: EdgeInsets.only(bottom: 4), color: color, height: 150.0);
  }

  Widget _buildSticky() {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppcustom(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              )),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < 6; i++)
                  _buildContainer1(
                    i.toString(),
                    Colors.teal[100 * (i % 9)],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildContainer1(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 8),
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          "Item $text",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SliverAppcustom extends SliverPersistentHeaderDelegate {
  SliverAppcustom({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppcustom oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
