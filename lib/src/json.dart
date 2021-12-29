// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:json_response/src/json_array.dart';
import 'package:json_response/src/json_impl.dart';

abstract class Json {
  factory Json.from({
    required Response response,
  }) =>
      JsonImpl.from(response: response);

  factory Json.empty() => JsonImpl.fromMap(value: {});

  /// Returns the string value linked to the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  String getString({
    required String key,
    String defaultValue = '',
  });

  /// Returns the int value linked to the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  int getInt({
    required String key,
    int defaultValue = -1,
  });

  /// Returns the double value linked to the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  double getDouble({
    required String key,
    double defaultValue = -1.0,
  });

  /// Returns the bool value linked to the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  bool getBool({
    required String key,
    bool defaultValue = false,
  });

  /// Returns the child json linked to the [key], otherwise empty json object.
  Json get({required String key});

  /// Returns the child json array linked to the [key], otherwise empty json array.
  JsonArray getArray({required String key});

  /// Returns the string value list linked to the [key], otherwise empty list.
  List<String> getStringValues({required String key});

  /// Returns the int value list linked to the [key], otherwise empty list.
  List<int> getIntValues({required String key});

  /// Returns the double value list linked to the [key], otherwise empty list.
  List<double> getDoubleValues({required String key});

  /// Returns true if json contains key linked to [key] passed as an argument.
  bool containsKey({required String key});

  /// Returns the key set of this json object.
  Set<String> get keySet;

  /// Returns true if this json object is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this json object is not empty, otherwise false.
  bool get isNotEmpty;
}
