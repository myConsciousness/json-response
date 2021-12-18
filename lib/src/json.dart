// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:typed_data';

// Project imports:
import 'package:json_pro/src/json_pro.dart';

abstract class Json {
  /// Returns the new instance of [Json] from json map.
  factory Json.fromMap({
    required Map<String, dynamic> value,
  }) =>
      JsonPro.fromMap(value: value);

  /// Returns the new instance of [Json] from json string.
  factory Json.fromString({
    required String value,
  }) =>
      JsonPro.fromString(value: value);

  /// Returns the new instance of [Json] from raw bytes.
  factory Json.fromBytes({
    required Uint8List bytes,
  }) =>
      JsonPro.fromBytes(bytes: bytes);

  /// Returns the string value linked to the [key], otherwise [defaultValue].
  String getStringValue({
    required String key,
    String defaultValue = '',
  });

  /// Returns the int value linked to the [key], otherwise [defaultValue].
  int getIntValue({
    required String key,
    int defaultValue = -1,
  });

  /// Returns the double value linked to the [key], otherwise [defaultValue].
  double getDoubleValue({
    required String key,
    double defaultValue = -1.0,
  });

  /// Returns the bool value linked to the [key], otherwise [defaultValue].
  bool getBoolValue({
    required String key,
    bool defaultValue = false,
  });

  /// Returns the child json linked to the [key], otherwise empty json object.
  Json getJson({required String key});

  /// Returns the child json list linked to the [key], otherwise empty json list.
  List<Json> getJsonList({required String key});

  /// Returns the string value list linked to the [key], otherwise empty list.
  List<String> getStringValues({required String key});

  /// Returns the int value list linked to the [key], otherwise empty list.
  List<int> getIntValues({required String key});

  /// Returns true if json contains key linked to [key] passed as an argument.
  bool containsKey({required String key});

  /// Returns the key set of this json object.
  Set<String> get keySet;

  /// Returns true if this json object is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this json object is not empty, otherwise false.
  bool get isNotEmpty;
}
