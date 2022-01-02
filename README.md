![json_response](https://user-images.githubusercontent.com/13072231/147863753-20d9c8ef-f221-48df-8071-e53835faab51.png)

**_A most easily usable JSON response wrapper library in Dart!_**

[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/myConsciousness/json-response)
[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](https://mail.google.com/mail/u/0/?to=kato.shinya.dev@gmail.com&fs=1&tf=cm)
[![Line](https://img.shields.io/badge/Line-00C300?style=for-the-badge&logo=line&logoColor=white)](https://line.me/ti/p/YP2nycjVCb)
[![Twitter](https://img.shields.io/badge/Twitter-%231DA1F2.svg?style=for-the-badge&logo=Twitter&logoColor=white)](https://twitter.com/ThinkitShinya)

[![pub package](https://img.shields.io/pub/v/json_response.svg)](https://pub.dev/packages/json_response)
[![codecov](https://codecov.io/gh/myConsciousness/json-response/branch/main/graph/badge.svg?token=MFRO47D2DG)](https://codecov.io/gh/myConsciousness/json-response)
[![Analyzer](https://github.com/myConsciousness/json-response/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/json-response/actions/workflows/analyzer.yml)
[![Test](https://github.com/myConsciousness/json-response/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/json-response/actions/workflows/test.yml)

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Motivation](#11-motivation)
  - [1.2. Introduction](#12-introduction)
    - [1.2.1. Install Library](#121-install-library)
    - [1.2.2. Import It](#122-import-it)
    - [1.2.3. Use JsonResponse](#123-use-jsonresponse)
  - [1.3. Details](#13-details)
    - [1.3.1. Json](#131-json)
      - [1.3.1.1. Create Instance](#1311-create-instance)
      - [1.3.1.2. Get Value](#1312-get-value)
      - [1.3.1.3. Get Multiple Values](#1313-get-multiple-values)
      - [1.3.1.4. Get Child JSON](#1314-get-child-json)
      - [1.3.1.5. Get JSON Array](#1315-get-json-array)
      - [1.3.1.6. Iteration](#1316-iteration)
    - [1.3.2. JsonArray](#132-jsonarray)
      - [1.3.2.1. Create Instance](#1321-create-instance)
      - [1.3.2.2. Get JSON](#1322-get-json)
      - [1.3.2.3. Get Nested JSON Array](#1323-get-nested-json-array)
      - [1.3.2.4. Iteration](#1324-iteration)
      - [1.3.2.5. Flatten A Nested JSON Array](#1325-flatten-a-nested-json-array)
  - [1.4. License](#14-license)
  - [1.5. More Information](#15-more-information)

<!-- /TOC -->

# 1. About

`JsonResponse` is an open-sourced Dart library.</br>
With `JsonResponse`, you can easily and safely handle JSON response on your application.

This library was created with the goal of making JSON response easier, more intuitive, and safer to use in the Dart language.

## 1.1. Motivation

For example, as a result of the communication process with the Web API, JSON is returned from the [http](https://pub.dev/packages/http) package and you have ever written the following process when the JSON is set to [Response](https://pub.dev/documentation/http/latest/http/Response-class.html), right?

```dart
void main() async {
  final response = await http.get(Uri.parse('something'));
  final json = jsonDecode(response.body);
  print(json['key'] ?? '');
}
```

The above process is not only redundant, but also unsafe from an implementation standpoint, as it requires writing a process for when the value associated with the key does not exist. It becomes even more complicated in the case of a list structure with multiple JSONs. **_With `JsonResponse`, the above implementation is no longer necessary!_**

In addition to `JsonResponse`, various other JSON-related libraries have been developed, and there are many interesting techniques that use annotations and type inference. **_However, I feel that those libraries are just complicating a simple problem with too many implementations and configuration files just to process the response returned from the API._**

Therefore, `JsonResponse` does not require any tricky annotations or new configuration files. This library can be used in the same sense as the well-worn `JSONObject` in Java. **_It is a horizontal thinking of a dead technology, but it is the easiest and safest algorithm when dealing with JSON response._**

## 1.2. Introduction

### 1.2.1. Install Library

**_With Dart:_**

```terminal
 dart pub add json_response
```

**_With Flutter:_**

```terminal
 flutter pub add json_response
```

### 1.2.2. Import It

```dart
import 'package:json_response/json_response.dart';
```

### 1.2.3. Use JsonResponse

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
  // You can get this json as a map format.
  print(json.toMap());

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

  // If you don't like the structure of several nested lists,
  // you can use the flatten method to make the nested structure flat.
  // This method returns a new flattened JsonArray.
  print(jsonArray.flatten());
}
```

## 1.3. Details

### 1.3.1. Json

The `Json` class represents a single JSON structure like below.

```json
{
  "key1": "string_value",
  "key2": 0,
  "key3": 0.0,
  "key4": true,
  "key5": {
    "nested_key1": "string_value"
  },
  "key6": [
    {
      "nested_key2": "string_value",
      "nested_key3": 1
    },
    {
      "nested_key2": "string_value",
      "nested_key3": 1
    }
  ],
  "key7": ["value1", "value2"]
}
```

Also, the `Json` class can automatically detect and convert the following XML format responses into JSON format inside the `from` constructor. It uses a third party library [xml2json](https://pub.dev/packages/xml2json) to perform this automatic XML to JSON conversion.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<records>
  <record>
      <key>1</key>
      <value>1</value>
  </record>
  <record>
      <key>2</key>
      <value>2</value>
  </record>
</records>
```

> **_Note_**</br>
> When xml2json converts XML to JSON, it uses the [Parker](https://pub.dev/packages/xml2json#parker) method.

#### 1.3.1.1. Create Instance

`Json` class provides 2 patterns for creating instances.

| Constructor                                                                                                                |
| -------------------------------------------------------------------------------------------------------------------------- |
| [from({required Response response})](https://pub.dev/documentation/json_response/latest/json_response/Json/Json.from.html) |
| [empty()](https://pub.dev/documentation/json_response/latest/json_response/Json/Json.empty.html)                           |

The `from` constructor takes the `Response` object returned from the `http` package as an argument and safely parses the JSON string contained in the response. JSON strings will be parsed in UTF-8 format.

If you need an empty `Json`, you can get an empty `Json` object from the `empty` constructor instead of null.

#### 1.3.1.2. Get Value

The `Json` class provides safe and convenient ways to retrieve values set in JSON.

| Method                                                                                                                                               |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| [getString({required String key, String defaultValue = ''})](https://pub.dev/documentation/json_response/latest/json_response/Json/getString.html)   |
| [getInt({required String key, String defaultValue = -1})](https://pub.dev/documentation/json_response/latest/json_response/Json/getInt.html)         |
| [getDouble({required String key, String defaultValue = -1.0})](https://pub.dev/documentation/json_response/latest/json_response/Json/getDouble.html) |
| [getBool({required String key, String defaultValue = false})](https://pub.dev/documentation/json_response/latest/json_response/Json/getBool.html)    |

By using the above methods, you can safely retrieve values with guaranteed types.

If the specified key does not exist or the value is null, the default value will be returned beforehand, but if you want to specify an arbitrary default value, set the `defaultValue` for each method.

#### 1.3.1.3. Get Multiple Values

JSON may have an array of values associated with the keys, and the `Json` class provides features for retrieving all the values in such an array at once in a list format.

If there is no value associated with the key, an empty list will be returned.

| Method                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------ |
| [getStringValues({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/getStringValues.html) |
| [getIntValues({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/getIntValues.html)       |
| [getDoubleValues({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/getDoubleValues.html) |
| [getBoolValues({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/getBoolValues.html)     |

#### 1.3.1.4. Get Child JSON

JSON may be set to the child's JSON as the value associated with the key, and the `Json` class provides a safe and easy way to retrieve the nested JSON associated with a key.

If there is no value associated with the key, an empty `Json` will be returned.

| Method                                                                                                       |
| ------------------------------------------------------------------------------------------------------------ |
| [get({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/get.html) |

#### 1.3.1.5. Get JSON Array

JSON may be set to an array with multiple JSON as the value associated with the key, and the `Json` class provides a safe and easy way to retrieve the nested JSON Array associated with a key.

If there is no value associated with the key, an empty `JsonArray` will be returned.

| Method                                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------- |
| [getArray({required String key})](https://pub.dev/documentation/json_response/latest/json_response/Json/getArray.html) |

#### 1.3.1.6. Iteration

The `Json` class provides convenient features for iterating over JSON objects.

| Property / Method                                                                                                                      |
| -------------------------------------------------------------------------------------------------------------------------------------- |
| [keySet](https://pub.dev/documentation/json_response/latest/json_response/Json/keySet.html)                                            |
| [forEach(void action(String key, dynamic value)) ](https://pub.dev/documentation/json_response/latest/json_response/Json/forEach.html) |

### 1.3.2. JsonArray

The `JsonArray` class represents a multiple JSON structure like below.

```json
[
  {
    "nested_key2": "string_value",
    "nested_key3": 1
  },
  {
    "nested_key2": "string_value",
    "nested_key3": 1
  }
]
```

#### 1.3.2.1. Create Instance

`JsonArray` class provides 2 patterns for creating instances.

| Constructor                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------------------ |
| [from({required Response response})](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/JsonArray.from.html) |
| [empty()](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/JsonArray.empty.html)                           |

The `from` constructor takes the `Response` object returned from the `http` package as an argument and safely parses the JSON string contained in the response. JSON strings will be parsed in UTF-8 format.

If you need an empty `JsonArray`, you can get an empty `JsonArray` object from the `empty` constructor instead of null.

#### 1.3.2.2. Get JSON

When a JSON Array contains multiple JSON, the `get` method can be used to get the JSON associated with the index specified in the argument as a `Json` object.

> **_Note:_**</br>
> Whenever a non-existent index number is specified as an argument, an exception will be raised indicating that the specified index is out of range.

| Method                                                                                                           |
| ---------------------------------------------------------------------------------------------------------------- |
| [get({required int index})](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/get.html) |

#### 1.3.2.3. Get Nested JSON Array

When a JSON Array contains nested JSON Array, the `getArray` method can be used to get the JSON associated with the index specified in the argument as a `JsonArray` object.

> **_Note:_**</br>
> Whenever a non-existent index number is specified as an argument, an exception will be raised indicating that the specified index is out of range.

| Method                                                                                                                     |
| -------------------------------------------------------------------------------------------------------------------------- |
| [getArray({required int index})](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/getArray.html) |

#### 1.3.2.4. Iteration

The `JsonArray` class provides convenient features for iterating over JSON Array objects.

| Method                                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [forEach(void action(Json json))](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/forEach.html)                                    |
| [forEachArray(void action(JsonArray jsonArray))](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/forEachArray.html)                |
| [enumerate(void action(int index, Json json)](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/enumerate.html))                     |
| [enumerateArray(void action(int index, JsonArray jsonArray)](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/enumerateArray.html)) |

You can use the `forEach` method if the object contained in the JSON Array is a JSON object, and you can use the `forEachArray` method if it is a nested JSON Array.

If you also need the index number in the iteration process, you can use `enumerate` or `enumerateArray` methods.

#### 1.3.2.5. Flatten A Nested JSON Array

The JSON Array may have multiple nested JSON Arrays. And if you don't like the nested structure of that JSON Array, you can use the `flatten` method to flatten the nested structure.

| Method                                                                                               |
| ---------------------------------------------------------------------------------------------------- |
| [flatten()](https://pub.dev/documentation/json_response/latest/json_response/JsonArray/flatten.html) |

## 1.4. License

```license
Copyright (c) 2021, Kato Shinya. All rights reserved.
Use of this source code is governed by a
BSD-style license that can be found in the LICENSE file.
```

## 1.5. More Information

`JsonResponse` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/json-response/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/json_response/latest/json_response/json_response-library.html)
- [Release Note](https://github.com/myConsciousness/json-response/releases)
- [Bug Report](https://github.com/myConsciousness/json-response/issues)
