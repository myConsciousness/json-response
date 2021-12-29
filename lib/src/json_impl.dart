// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:json_response/src/json.dart';
import 'package:json_response/src/json_array.dart';
import 'package:json_response/src/json_array_impl.dart';

class JsonImpl implements Json {
  JsonImpl.from({
    required Response response,
  }) : _resource = jsonDecode(utf8.decode(response.bodyBytes));

  /// Returns the new instance of [JsonImpl] from json map.
  JsonImpl.fromMap({
    required Map<String, dynamic> value,
  }) : _resource = value;

  /// Returns the new instance of [JsonImpl] from json string.
  JsonImpl.fromString({
    required String value,
  }) : _resource = jsonDecode(value);

  /// The json
  final Map<String, dynamic> _resource;

  @override
  int get length => _resource.length;

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
  Json get({required String key}) {
    if (!containsKey(key: key)) {
      return JsonImpl.fromMap(value: {});
    }

    final value = _resource[key] ?? <String, dynamic>{};

    if (value is String) {
      return JsonImpl.fromString(value: value);
    }

    return JsonImpl.fromMap(value: value);
  }

  @override
  JsonArray getArray({required String key}) {
    if (!containsKey(key: key)) {
      return JsonArray.empty();
    }

    return JsonArrayImpl.fromList(values: _resource[key]);
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
  void forEach(void Function(String key, dynamic value) action) {
    for (final key in keySet) {
      action(key, _resource[key]);
    }
  }

  @override
  Map<String, dynamic> toMap() => _resource;

  @override
  bool get isEmpty => _resource.isEmpty;

  @override
  bool get isNotEmpty => _resource.isNotEmpty;

  @override
  String toString() => _resource.toString();
}
