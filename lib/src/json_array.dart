// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:json_response/src/json.dart';
import 'package:json_response/src/json_array_impl.dart';

abstract class JsonArray {
  /// Returns the new instance of [JsonArray] based on [response].
  factory JsonArray.from({
    required Response response,
  }) =>
      JsonArrayImpl.from(response: response);

  /// Returns the new instance of empty [JsonArray].
  factory JsonArray.empty() => JsonArrayImpl.fromList(values: []);

  /// Returns the length of this json array.
  int get length;

  /// Returns the [Json] associated with [index].
  ///
  /// If the value associated with the specified index does not exist,
  /// an exception will be raised.
  Json get({required int index});

  /// Returns the [JsonArray] associated with [index].
  ///
  /// If the value associated with the specified index does not exist,
  /// an exception will be raised.
  JsonArray getArray({required int index});

  /// Invokes [action] on each [json] of this json array in iteration order.
  void forEach(void Function(Json json) action);

  /// Invokes [action] on each [index] and [json] of this json array in iteration order.
  void enumerate(void Function(int index, Json json) action);

  /// Invokes [action] on each [jsonArray] of this json array in iteration order.
  void forEachArray(void Function(JsonArray jsonArray) action);

  /// Invokes [action] on each [index] and [jsonArray] of this json array in iteration order.
  void enumeratArray(void Function(int index, JsonArray jsonArray) action);

  /// Returns the new instance of flattened [JsonArray] from this [JsonArray].
  JsonArray toFlat();

  /// Returns true if this json array is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this json array is not empty, otherwise false.
  bool get isNotEmpty;
}
