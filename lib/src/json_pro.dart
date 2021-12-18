// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:json_pro/src/json.dart';

/// It provides safe and convenient features about JSON handling.
class JsonPro implements Json {
  /// Returns the new instance of [JsonPro] from json map.
  JsonPro.fromMap({
    required Map<String, dynamic> value,
  }) : jsonResource = value;

  /// Returns the new instance of [JsonPro] from json string.
  JsonPro.fromString({
    required String value,
  }) : jsonResource = jsonDecode(value);

  /// Returns the new instance of [JsonPro] from raw bytes.
  JsonPro.fromBytes({
    required Uint8List bytes,
  }) : jsonResource = jsonDecode(utf8.decode(bytes));

  /// The json
  final Map<String, dynamic> jsonResource;

  @override
  String getStringValue({
    required String key,
    String defaultValue = '',
  }) =>
      jsonResource[key] ?? defaultValue;

  @override
  int getIntValue({
    required String key,
    int defaultValue = -1,
  }) =>
      jsonResource[key] ?? defaultValue;

  @override
  double getDoubleValue({
    required String key,
    double defaultValue = -1.0,
  }) =>
      jsonResource[key] ?? defaultValue;

  @override
  bool getBoolValue({
    required String key,
    bool defaultValue = false,
  }) =>
      jsonResource[key] ?? defaultValue;

  @override
  JsonPro getJson({required String key}) {
    if (!containsKey(key: key)) {
      return JsonPro.fromMap(value: {});
    }

    final value = jsonResource[key] ?? <String, dynamic>{};

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

    for (final json in jsonResource[key]) {
      if (json is List) {
        for (final childJson in json) {
          jsonList.add(
            JsonPro.fromMap(value: childJson),
          );
        }
      } else {
        jsonList.add(
          JsonPro.fromMap(value: json),
        );
      }
    }

    return jsonList;
  }

  @override
  List<String> getStringValues({required String key}) {
    if (!containsKey(key: key)) {
      return <String>[];
    }

    final values = <String>[];

    for (final value in jsonResource[key]) {
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

    for (final value in jsonResource[key]) {
      values.add(value);
    }

    return values;
  }

  @override
  bool containsKey({required String key}) => jsonResource.containsKey(key);

  @override
  Set<String> get keySet => jsonResource.keys.toSet();

  @override
  bool get isEmpty => jsonResource.isEmpty;

  @override
  bool get isNotEmpty => jsonResource.isNotEmpty;

  @override
  String toString() => jsonResource.toString();
}
