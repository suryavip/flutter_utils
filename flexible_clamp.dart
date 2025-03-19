/*
https://github.com/suryavip/flutter_utils
version 1
*/

T _atMost<T extends num>(T original, T? upperLimit) {
  if (upperLimit == null) return original;
  if (original > upperLimit) return upperLimit;
  return original;
}

T _atLeast<T extends num>(T original, T? lowerLimit) {
  if (lowerLimit == null) return original;
  if (original < lowerLimit) return lowerLimit;
  return original;
}

extension FlexibleClampOnDouble on double {
  double atMost(double? upperLimit) => _atMost<double>(this, upperLimit);
  double atLeast(double? lowerLimit) => _atLeast<double>(this, lowerLimit);
}

extension FlexibleClampOnInt on int {
  int atMost(int? upperLimit) => _atMost<int>(this, upperLimit);
  int atLeast(int? lowerLimit) => _atLeast<int>(this, lowerLimit);
}
