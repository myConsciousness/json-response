**_A most easily usable JSON response wrapper library in Dart!_**

[![pub package](https://img.shields.io/pub/v/json_response.svg)](https://pub.dev/packages/json_response)
[![codecov](https://codecov.io/gh/myConsciousness/json-response/branch/main/graph/badge.svg?token=MFRO47D2DG)](https://codecov.io/gh/myConsciousness/json-response)
[![Analyzer](https://github.com/myConsciousness/json-response/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/json-response/actions/workflows/analyzer.yml)
[![Test](https://github.com/myConsciousness/json-response/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/json-response/actions/workflows/test.yml)

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Introduction](#11-introduction)
    - [1.1.1. Install Library](#111-install-library)
    - [1.1.2. Import It](#112-import-it)
    - [1.1.3. Use JsonResponse](#113-use-jsonresponse)
  - [1.2. License](#12-license)
  - [1.3. More Information](#13-more-information)

<!-- /TOC -->

# 1. About

`JsonResponse` is an open-sourced Dart library.</br>
With `JsonResponse`, you can easily and safely handle JSON response on your application.

This library was created with the goal of making JSON response easier, more intuitive, and safer to use in the Dart language. For example, as a result of the communication process with the Web API, JSON is returned from the [http](https://pub.dev/packages/http) package and you have ever written the following process when the JSON is set to [Response](https://pub.dev/documentation/http/latest/http/Response-class.html), right?

```dart
final json = jsonDecode(response.body);
final something = json['key'] ?? '';
```

With `JsonResponse`, the above implementation is no longer necessary!

## 1.1. Introduction

### 1.1.1. Install Library

**_With Dart:_**

```terminal
 dart pub add json_response
```

**_With Flutter:_**

```terminal
 flutter pub add json_response
```

### 1.1.2. Import It

```dart
import 'package:json_response/json_response.dart';
```

### 1.1.3. Use JsonResponse

```dart
import 'dart:typed_data';
import 'package:json_response/json_response.dart';

void main() {
  // It provides constructors to get JSON from JSON string, JSON map, and JSON bytes.
  final jsonFromString = JsonResponse.fromString(value: '{"test": "something"}');
  final jsonFromMap = JsonResponse.fromMap(value: {'test': 'something'});
  final jsonFromBytes = JsonResponse.fromBytes(
      value: Uint8List.fromList('{"test": "something"}'.codeUnits));

  // You can use handful methods in the same interface once instance is created.
  print(jsonFromString.getString(key: 'test'));
  print(jsonFromMap.getString(key: 'test'));
  print(jsonFromBytes.getString(key: 'test'));

  final testJson = JsonResponse.fromMap(
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

  if (testJson.isEmpty) {
    // Do something when json is empty.
    return;
  }

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
```

## 1.2. License

```license
Copyright (c) 2021, Kato Shinya. All rights reserved.
Use of this source code is governed by a
BSD-style license that can be found in the LICENSE file.
```

## 1.3. More Information

`JsonResponse` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/json-response/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/json_response/latest/json_response/json_response-library.html)
- [Release Note](https://github.com/myConsciousness/json-response/releases)
- [Bug Report](https://github.com/myConsciousness/json-response/issues)
