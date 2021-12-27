// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:typed_data';

// Project imports:
import 'package:json_response/src/json_response_impl.dart';

/// This abstract class provides a simple, intuitive, and safe way to handle JSON.
///
/// This class provides a constructor that generates a [JsonResponse] instance from a JSON string,
/// a JSON map, and a byte representation of the JSON string. You can use the [JsonResponse.fromString]
/// constructor for JSON strings, the [JsonResponse.fromMap] constructor for JSON maps,
/// and the [JsonResponse.fromBytes] constructor for byte representations of JSON strings.
///
/// It also provides methods to easily and safely retrieve values from JSON objects.
/// For example, if you want to retrieve a string associated with a specific key,
/// use the [getString] method. If this key does not exist or if the value is null,
/// a non-null value set as the default value in each method will be returned. If you want
/// to set a specific default value, you can set the default value as an argument of each method.
///
/// If the values associated with a particular key are structured as a list, you can use
/// [getStringValues] for example. These methods will retrieve all the values in the list associated
/// with the specified key and return them as a list.
///
/// You can use use [getJson] if the value associated with a particular key is a JSON object
/// represented by a map. The type returned by this method is [JsonResponse], the same as this class.
/// Even if the value associated with this particular key is a JSON object expressed as a string,
/// no special procedure is required, and you can simply call the [getJson] method.
///
/// Also you can use [getJsonList] if the values associated with a particular key are multiple JSON objects.
/// This method recursively traverses all JSON objects associated with the key, so if there are nested JSON
/// objects associated with this particular key, it is okay. This method will return a list of
/// [JsonResponse] classes.
///
/// **_Example:_**
///
/// ```dart
///   // It provides constructors to get JSON from JSON string, JSON map, and JSON bytes.
///   final jsonFromString =
///       JsonResponse.fromString(value: '{"test": "something"}');
///   final jsonFromMap = JsonResponse.fromMap(value: {'test': 'something'});
///   final jsonFromBytes = JsonResponse.fromBytes(
///       value: Uint8List.fromList('{"test": "something"}'.codeUnits));
///
///   // You can use handful methods in the same interface once instance is created.
///   print(jsonFromString.getString(key: 'test'));
///   print(jsonFromMap.getString(key: 'test'));
///   print(jsonFromBytes.getString(key: 'test'));
///
///   final testJson = JsonResponse.fromMap(
///     value: {
///       'testValueList': ['value1', 'value2'],
///       'testJsonString': '{"key1": "value2"}',
///       'testJsonList': [
///         {
///           'key1': 'value1',
///           'key2': 'value2',
///         }
///       ],
///       'testRecursiveJsonList': [
///         [
///           {
///             'key1': 'value1',
///             'key2': 'value2',
///           }
///         ],
///         {
///           'key3': 'value3',
///           'key4': 'value4',
///         }
///       ]
///     },
///   );
///
///   if (testJson.isEmpty) {
///     // Do something when json is empty.
///     return;
///   }
///
///   // It provides features to safely get values from JSON.
///   print(testJson.getStringValues(key: 'testValueList'));
///
///   // You can easily get a JSON object or JSON list associated with a key.
///   // If the JSON object associated with the key is a string,
///   // it will be automatically detected and parsed into a JSON object.
///   print(testJson.getJson(key: 'testJsonString'));
///   print(testJson.getJsonList(key: 'testJsonList'));
///
///   // If your JSON list is nested, that's okay!
///   // All JSON expressions associated with a key will be returned as JSON objects.
///   print(testJson.getJsonList(key: 'testRecursiveJsonList'));
/// ```
abstract class JsonResponse {
  /// Returns the new instance of [JsonResponse] from json map.
  factory JsonResponse.fromMap({
    required Map<String, dynamic> value,
  }) =>
      JsonResponseImpl.fromMap(value: value);

  /// Returns the new instance of [JsonResponse] from json string.
  factory JsonResponse.fromString({
    required String value,
  }) =>
      JsonResponseImpl.fromString(value: value);

  /// Returns the new instance of [JsonResponse] from bytes.
  factory JsonResponse.fromBytes({
    required Uint8List value,
  }) =>
      JsonResponseImpl.fromBytes(value: value);

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
  JsonResponse getJson({required String key});

  /// Returns the child json list linked to the [key], otherwise empty json list.
  List<JsonResponse?> getJsonList({required String key});

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
