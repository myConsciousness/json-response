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
      'test': ['test1', 'test2'],
      'test3': '{"tes4": "test5"}',
      'test6': [
        {
          'test1': 'something',
          'test2': 'something2',
        }
      ],
    },
  );

  print(testJson.getStringValues(key: 'test'));
  print(testJson.getJson(key: 'test3'));
  print(testJson.getJsonList(key: 'test6'));
}
