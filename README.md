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
void main() async {
  final response = await http.get(Uri.parse('something'));
  final json = jsonDecode(response.body);
  print(json['key'] ?? '');
}
```

The above process is not only redundant, but also unsafe from an implementation standpoint, as it requires writing a process for when the value associated with the key does not exist. It becomes even more complicated in the case of a list structure with multiple JSONs.

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
import 'package:http/http.dart';
import 'package:json_response/json_response.dart';

void main() {
  final jsonResponse = Response(
    '{"key1": "value", "key2": 1, "key3": true, "key4": {"nested_key1": "nested_value"}}',
    200,
  );

  final jsonArrayResponse = Response(
    '''[
        {"key1": "value", "key2": 1, "key3": true},
        {"key1": "value", "key2": 1, "key3": true},
        {"key1": "value", "key2": 1, "key3": true}
      ]
    ''',
    200,
  );

  // Json represents a single JSON structure,
  // and the JsonArray class represents a multiple JSON structure.
  //
  // Instantiation of either class is very simple,
  // just pass the Response class returned when HTTP communication is
  // performed with the http package.
  final json = Json.from(response: jsonResponse);
  final jsonArray = JsonArray.from(response: jsonArrayResponse);

  // Intuitively and safely retrieve data from dedicated methods
  // that correspond to data types.
  print(json.getString(key: 'key1'));
  print(json.getInt(key: 'key2'));
  print(json.getBool(key: 'key3'));

  // You can also easily retrieve JSON that is nested within JSON.
  print(json.get(key: 'key4'));

  // The forEach method makes it easy to handle repetitive processes.
  jsonArray.forEach((json) {
    print(json);
  });

  // If you are iterating and want the current index as well,
  // the enumerate method is useful.
  jsonArray.enumerate((index, json) {
    print(index);
    print(json);
  });

  // JSON can be retrieved by specifying a specific index,
  // but be aware that an exception will be thrown
  // if a non-existent index number is specified.
  print(jsonArray.get(index: 0));
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
