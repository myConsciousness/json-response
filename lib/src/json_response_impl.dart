// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:json_response/src/json_response.dart';

/// This class is an implementation of the [JsonResponse] class.
class JsonResponseImpl implements JsonResponse {
  /// Returns the new instance of [JsonResponseImpl] from json map.
  JsonResponseImpl.fromMap({
    required Map<String, dynamic> value,
  }) : _resource = value;

  /// Returns the new instance of [JsonResponseImpl] from json string.
  JsonResponseImpl.fromString({
    required String value,
  }) : _resource = jsonDecode(value);

  /// Returns the new instance of [JsonResponseImpl] from raw bytes.
  JsonResponseImpl.fromBytes({
    required Uint8List value,
  }) : _resource = jsonDecode(utf8.decode(value));

  /// The json
  final Map<String, dynamic> _resource;

  @override
  String getString({
    required String key,
    String defaultValue = '',
  }) =>
      _resource[key] ?? defaultValue;

  @override
  int getInt({
    required String key,
    int defaultValue = -1,
  }) =>
      _resource[key] ?? defaultValue;

  @override
  double getDouble({
    required String key,
    double defaultValue = -1.0,
  }) =>
      _resource[key] ?? defaultValue;

  @override
  bool getBool({
    required String key,
    bool defaultValue = false,
  }) =>
      _resource[key] ?? defaultValue;

  @override
  JsonResponseImpl getJson({required String key}) {
    if (!containsKey(key: key)) {
      return JsonResponseImpl.fromMap(value: {});
    }

    final value = _resource[key] ?? <String, dynamic>{};

    if (value is String) {
      return JsonResponseImpl.fromString(value: value);
    }

    return JsonResponseImpl.fromMap(value: value);
  }

  @override
  List<JsonResponseImpl> getJsonList({required String key}) {
    if (!containsKey(key: key)) {
      return [];
    }

    final jsonList = <JsonResponseImpl>[];

    _getJsonListRecursively(
      childJsonList: _resource[key],
      jsonList: jsonList,
    );

    return jsonList;
  }

  void _getJsonListRecursively({
    required dynamic childJsonList,
    required List<JsonResponseImpl> jsonList,
  }) {
    for (final json in childJsonList) {
      if (json == null) {
        jsonList.add(
          JsonResponseImpl.fromMap(value: {}),
        );

        continue;
      }

      if (json is List) {
        _getJsonListRecursively(
          childJsonList: json,
          jsonList: jsonList,
        );
      } else {
        jsonList.add(
          JsonResponseImpl.fromMap(value: json),
        );
      }
    }
  }

  @override
  List<String> getStringValues({required String key}) {
    if (!containsKey(key: key)) {
      return <String>[];
    }

    final values = <String>[];

    for (final value in _resource[key]) {
      values.add(value);
    }

    return values;
  }

  @override
  List<int> getIntValues({required String key}) {
    if (!containsKey(key: key)) {
      return <int>[];
    }

    final values = <int>[];

    for (final value in _resource[key]) {
      values.add(value);
    }

    return values;
  }

  @override
  List<double> getDoubleValues({required String key}) {
    if (!containsKey(key: key)) {
      return <double>[];
    }

    final values = <double>[];

    for (final value in _resource[key]) {
      values.add(value);
    }

    return values;
  }

  @override
  bool containsKey({required String key}) => _resource.containsKey(key);

  @override
  Set<String> get keySet => _resource.keys.toSet();

  @override
  bool get isEmpty => _resource.isEmpty;

  @override
  bool get isNotEmpty => _resource.isNotEmpty;

  @override
  String toString() => _resource.toString();
}
