// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:json_response/src/json_array.dart';
import 'package:json_response/src/json_impl.dart';

/// This abstract class represents the data structure of JSON,
/// and provides convenient, easy, and safe features for handling JSON.
///
/// Instantiation of [Json] class is very simple,
/// just pass the [Response](https://pub.dev/documentation/http/latest/http/Response-class.html) class
/// returned when HTTP communication is performed with the [http](https://pub.dev/packages/http) package.
///
/// It also provides methods to easily and safely retrieve values from JSON object.
///
/// For example, if you want to retrieve a string associated with a specific key,
/// use the [getString] method. If this key does not exist or if the value is null,
/// a non-null value set as the default value in each method will be returned. If you want
/// to set a specific default value, you can set the default value as an argument of each method.
///
/// If the values associated with a specific key are structured as a list, you can use
/// [getStringValues] for example. These methods will retrieve all the values in the list associated
/// with the specified key and return them as a list.
///
/// You can use use [get] if the value associated with a specific key is a JSON object
/// represented by a map. The type returned by this method is [Json], the same as this class.
/// Even if the value associated with this specific key is a JSON object expressed as a string,
/// no special procedure is required, and you can simply call the [get] method.
///
/// Also you can use [getArray] if the values associated with a specific key are multiple JSON objects.
/// See the [JsonArray] class documentation for details.
///
/// **_Example:_**
///
/// ```dart
/// void main() {
///   final response = Response(
///     '{"key1": "value", "key2": 1, "key3": true, "key4": {"nested_key1": "nested_value"}}',
///     200,
///   );
///
///   final json = Json.from(response: response);
///
///   print(json.getString(key: 'key1'));
///   print(json.getInt(key: 'key2'));
///   print(json.getBool(key: 'key3'));
///
///   print(json.get(key: 'key4'));
///   print(json.toMap());
/// }
/// ```
abstract class Json {
  /// Returns the new instance of [Json] based on [response].
  factory Json.from({
    required Response response,
  }) =>
      JsonImpl.from(response: response);

  /// Returns the new instance of empty [Json].
  factory Json.empty() => JsonImpl.fromMap(value: {});

  /// Returns the length of this json.
  int get length;

  /// Returns the string value associated with the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  String getString({
    required String key,
    String defaultValue = '',
  });

  /// Returns the int value associated with the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  int getInt({
    required String key,
    int defaultValue = -1,
  });

  /// Returns the double value associated with the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  double getDouble({
    required String key,
    double defaultValue = -1.0,
  });

  /// Returns the bool value associated with the [key], otherwise [defaultValue].
  ///
  /// If [key] does not exist in the JSON object, or if there is a specific default value that
  /// you want to return when the value associated with [key] is null, set it to the
  /// argument [defaultValue].
  bool getBool({
    required String key,
    bool defaultValue = false,
  });

  /// Returns the child json associated with the [key], otherwise empty json object.
  Json get({required String key});

  /// Returns the child json array associated with the [key], otherwise empty json array.
  JsonArray getArray({required String key});

  /// Returns the string value list associated with the [key], otherwise empty list.
  List<String> getStringValues({required String key});

  /// Returns the int value list associated with the [key], otherwise empty list.
  List<int> getIntValues({required String key});

  /// Returns the double value list associated with the [key], otherwise empty list.
  List<double> getDoubleValues({required String key});

  /// Returns the bool value list associated with the [key], otherwise empty list.
  List<bool> getBoolValues({required String key});

  /// Returns true if json contains key associated with [key] passed as an argument.
  bool containsKey({required String key});

  /// Returns the key set of this json object.
  Set<String> get keySet;

  /// Applies [action] to each key/value pair of the json.
  void forEach(void Function(String key, dynamic value) action);

  /// Returns this json as a map format.
  Map<String, dynamic> toMap();

  /// Returns true if this json object is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this json object is not empty, otherwise false.
  bool get isNotEmpty;
}
