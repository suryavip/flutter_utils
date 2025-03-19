/*
https://github.com/suryavip/flutter_utils
version 2
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class CustomChangeNotifier extends ChangeNotifier {
  bool _disposed = false;
  bool get disposed => _disposed;

  @override
  @mustCallSuper
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  bool _isFirstPostFrameTriggered = false;

  void _onFirstPostFrameGate(BuildContext context) {
    if (_isFirstPostFrameTriggered) return;
    _isFirstPostFrameTriggered = true;
    onFirstPostFrame(context);
  }

  void onFirstPostFrame(BuildContext context) {}
}

extension BindFirstPostFrame on BuildContext {
  void bindFirstPostFrame<T extends CustomChangeNotifier>() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      read<T>()._onFirstPostFrameGate(this);
    });
  }
}
