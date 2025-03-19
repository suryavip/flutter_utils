/*
https://github.com/suryavip/flutter_utils
version 2
*/

/// Usage examples:
/// ```
/// const pattern = 'products/{productId}/variants/{variantId}';
/// const productId = 'product123';
/// const variantId = 'variant321';
/// final route = pattern.getRouteWithParameters({
///   'productId': productId,
///   'variantId': variantId,
/// });
/// final isAPatternForRoute = pattern.isAPatternForRoute(route);
/// final isARouteForPattern = route.isARouteForPattern(pattern);
/// final params = route.getParametersWithPattern(pattern);
/// ```
extension RouteCodec on String? {
  static bool _matchPatternWithRoute(String? pattern, String? route) {
    final patternSegments = (pattern ?? '').split('?').first.split('/');
    final routeSegments = (route ?? '').split('?').first.split('/');

    if (patternSegments.length != routeSegments.length) return false;

    for (int i = 0; i < patternSegments.length; i++) {
      final patternSegment = patternSegments[i];
      if (patternSegment.startsWith('{') && patternSegment.endsWith('}')) {
        // is a parameter
        continue;
      }
      final routeSegement = routeSegments[i];
      if (patternSegment != routeSegement) return false;
    }

    return true;
  }

  /// Check if [this] is a pattern for the given [route].
  bool isAPatternForRoute(String? route) => _matchPatternWithRoute(this, route);

  /// Check if [this] is a route for the given [pattern].
  bool isARouteForPattern(String? pattern) =>
      _matchPatternWithRoute(pattern, this);

  bool isARouteForOneOfPatterns(List<String?> patterns) =>
      patterns.any((e) => isARouteForPattern(e));

  /// Get the parameters embeded on [this] route.
  /// The parameter names came from [pattern].
  /// Null [pattern] simply returns empty map.
  Map<String, String> getParametersWithPattern(String? pattern) {
    assert(pattern.isAPatternForRoute(this));

    final patternSegments = (pattern ?? '').split('?').first.split('/');
    final routeSegments = (this ?? '').split('?').first.split('/');

    Map<String, String> output = {};
    for (int i = 0; i < patternSegments.length; i++) {
      final patternSegment = patternSegments[i];
      if (patternSegment.startsWith('{') && patternSegment.endsWith('}')) {
        final routeSegement = routeSegments[i];
        final parameterName = patternSegment.substring(
          1,
          patternSegment.length - 1,
        );
        output[parameterName] = Uri.decodeComponent(routeSegement);
      }
    }

    return output;
  }

  Map<String, String> getParametersWithOneOfPatterns(List<String?> patterns) =>
      getParametersWithPattern(
        patterns.where((e) => isARouteForPattern(e)).firstOrNull,
      );

  /// Make route from [this] pattern by filling the pattern with [parameters].
  String getRouteWithParameters(Map<String, String> parameters) => (this ?? '')
      .split('/')
      .map((patternSegment) {
        if (patternSegment.startsWith('{') && patternSegment.endsWith('}')) {
          final parameterName = patternSegment.substring(
            1,
            patternSegment.length - 1,
          );
          return Uri.encodeComponent(parameters[parameterName] ?? '');
        }
        return patternSegment;
      })
      .join('/');
}
