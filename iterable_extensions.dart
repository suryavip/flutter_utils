/*
https://github.com/suryavip/flutter_utils
version 2
*/

import 'package:flutter/widgets.dart';

List<E> _addInBetween<E>(Iterable<E> iterable, E inBetween) {
  List<E> result = [];
  for (E e in iterable) {
    result.add(e);
    result.add(inBetween);
  }
  if (result.isNotEmpty) {
    result.removeLast();
  }
  return result;
}

List<E> _addInFront<E>(Iterable<E> iterable, E inFront) {
  List<E> result = iterable.toList();
  result.insert(0, inFront);
  return result;
}

List<E> _addToEnd<E>(Iterable<E> iterable, E atEnd) {
  List<E> result = iterable.toList();
  result.add(atEnd);
  return result;
}

List<E> _flatten<E>(Iterable<dynamic> iterable) {
  List<E> clean = [];
  for (dynamic i in iterable) {
    if (i is Iterable<E>) {
      clean.addAll(i);
    } else if (i is E) {
      clean.add(i);
    }
  }
  return clean;
}

extension AddToIterable<E> on Iterable<E> {
  Iterable<E> addInBetween(E inBetween) => _addInBetween<E>(this, inBetween);
  Iterable<E> addInFront(E inFront) => _addInFront<E>(this, inFront);
  Iterable<E> addToEnd(E atEnd) => _addToEnd<E>(this, atEnd);
}

extension AddToList<E> on List<E> {
  List<E> addInBetween(E inBetween) => _addInBetween<E>(this, inBetween);
  List<E> addInFront(E inFront) => _addInFront<E>(this, inFront);
  List<E> addToEnd(E atEnd) => _addToEnd<E>(this, atEnd);
}

extension FlattenIterable<E> on Iterable<E> {
  Iterable<E> flatten() => _flatten(this);

  /// LOW: [List] of [Widget]s
  List<Widget> flattenToLOW() => _flatten(this);
}

extension FlattenList<E> on List<E> {
  Iterable<E> flatten() => _flatten(this);

  /// LOW: [List] of [Widget]s
  List<Widget> flattenToLOW() => _flatten(this);
}
