/*
https://github.com/suryavip/flutter_utils
version 1
*/

import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double size;
  const VSpace(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class HSpace extends StatelessWidget {
  final double size;
  const HSpace(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}

class SliverVSpace extends StatelessWidget {
  final double size;
  const SliverVSpace(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: VSpace(size));
  }
}
