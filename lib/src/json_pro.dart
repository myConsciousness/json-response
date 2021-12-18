// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:json_pro/src/json.dart';

/// This class is an implementation of the [Json] class.
class JsonPro implements Json {
  /// Returns the new instance of [JsonPro] from json map.
  JsonPro.fromMap({
    required Map<String, dynamic> value,
  }) : _resource = value;

  /// Returns the new instance of [JsonPro] from json string.
  JsonPro.fromString({
    required String value,
  }) : _resource = jsonDecode(value);

  /// Returns the new instance of [JsonPro] from raw bytes.
  JsonPro.fromBytes({
    required Uint8List bytes,
  }) : _resource = jsonDecode(utf8.decode(bytes));

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
  JsonPro getJson({required String key}) {
    if (!containsKey(key: key)) {
      return JsonPro.fromMap(value: {});
    }

    final value = _resource[key] ?? <String, dynamic>{};

    if (value is String) {
      return JsonPro.fromString(value: value);
    }

    return JsonPro.fromMap(value: value);
  }

  @override
  List<JsonPro> getJsonList({required String key}) {
    if (!containsKey(key: key)) {
      return [];
    }

    final jsonList = <JsonPro>[];

    for (final json in _resource[key]) {
      if (json is List) {
        _getJsonListRecursively(
          childJsonList: json,
          jsonList: jsonList,
        );
      } else {
        jsonList.add(
          JsonPro.fromMap(value: json),
        );
      }
    }

    return jsonList;
  }

  void _getJsonListRecursively({
    required dynamic childJsonList,
    required List<JsonPro> jsonList,
  }) {
    for (final json in childJsonList) {
      if (json is List) {
        _getJsonListRecursively(
          childJsonList: json,
          jsonList: jsonList,
        );
      } else {
        jsonList.add(
          JsonPro.fromMap(value: json),
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
