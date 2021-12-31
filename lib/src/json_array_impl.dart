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
import 'package:json_response/src/json_impl.dart';

class JsonArrayImpl implements JsonArray {
  JsonArrayImpl.from({
    required Response response,
  }) : _resources = jsonDecode(utf8.decode(response.bodyBytes));

  /// Returns the new instance of [JsonImpl] from json list.
  JsonArrayImpl.fromList({
    required List<dynamic> values,
  }) : _resources = values;

  /// The resources of this array
  final List<dynamic> _resources;

  @override
  int get length => _resources.length;

  @override
  Json get({
    required int index,
  }) =>
      JsonImpl.fromMap(value: _resources[index]);

  @override
  JsonArray getArray({
    required int index,
  }) =>
      JsonArrayImpl.fromList(values: _resources[index]);

  @override
  void forEach(void Function(Json json) action) {
    for (final resource in _resources) {
      action(
        JsonImpl.fromMap(value: resource ?? {}),
      );
    }
  }

  @override
  void enumerate(void Function(int index, Json json) action) {
    int index = 0;
    forEach((json) {
      action(index, json);
      index++;
    });
  }

  @override
  void forEachArray(void Function(JsonArray jsonArray) action) {
    for (final resource in _resources) {
      action(
        JsonArrayImpl.fromList(values: resource ?? []),
      );
    }
  }

  @override
  void enumeratArray(void Function(int index, JsonArray jsonArray) action) {
    int index = 0;
    forEachArray((jsonArray) {
      action(index, jsonArray);
      index++;
    });
  }

  @override
  JsonArray toFlat() {
    final flatted = [];

    _retrieveJsonRecursively(
      nestedJson: _resources,
      results: flatted,
    );

    return JsonArrayImpl.fromList(values: flatted);
  }

  void _retrieveJsonRecursively({
    required List nestedJson,
    required List results,
  }) {
    for (final json in nestedJson) {
      if (json == null) {
        results.add({});
        continue;
      }

      if (json is List) {
        _retrieveJsonRecursively(
          nestedJson: json,
          results: results,
        );
      } else {
        results.add(json);
      }
    }
  }

  @override
  bool get isEmpty => _resources.isEmpty;

  @override
  bool get isNotEmpty => _resources.isNotEmpty;

  @override
  String toString() => _resources.toString();
}
