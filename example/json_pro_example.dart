// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:json_pro/json_pro.dart';

void main() {
  // It provides constructors to get JSON from JSON string, JSON map, and JSON bytes.
  final jsonFromString = Json.fromString(value: '{"test": "something"}');
  final jsonFromMap = Json.fromMap(value: {'test': 'something'});
  final jsonFromBytes = Json.fromBytes(
      bytes: Uint8List.fromList('{"test": "something"}'.codeUnits));

  // You can use handful methods in the same interface once instance is created.
  print(jsonFromString.getString(key: 'test'));
  print(jsonFromMap.getString(key: 'test'));
  print(jsonFromBytes.getString(key: 'test'));

  final testJson = Json.fromMap(
    value: {
      'testValueList': ['value1', 'value2'],
      'testJsonString': '{"key1": "value2"}',
      'testJsonList': [
        {
          'key1': 'value1',
          'key2': 'value2',
        }
      ],
      'testRecursiveJsonList': [
        [
          {
            'key1': 'value1',
            'key2': 'value2',
          }
        ],
        {
          'key3': 'value3',
          'key4': 'value4',
        }
      ]
    },
  );

  // It provides features to safely get values from JSON.
  print(testJson.getStringValues(key: 'testValueList'));

  // You can easily get a JSON object or JSON list associated with a key.
  // If the JSON object associated with the key is a string,
  // it will be automatically detected and parsed into a JSON object.
  print(testJson.getJson(key: 'testJsonString'));
  print(testJson.getJsonList(key: 'testJsonList'));

  // If your JSON list is nested, that's okay!
  // All JSON expressions associated with a key will be returned as JSON objects.
  print(testJson.getJsonList(key: 'testRecursiveJsonList'));
}
