// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:json_response/src/json.dart';
import 'package:json_response/src/json_array_impl.dart';

abstract class JsonArray {
  factory JsonArray.from({
    required Response response,
  }) =>
      JsonArrayImpl.from(response: response);

  factory JsonArray.empty() => JsonArrayImpl.fromList(values: []);

  int get length;

  Json get({required int index});

  void forEach(void Function(Json json) action);

  void enumerate(void Function(int index, Json json) action);

  /// Returns true if this json array is empty, otherwise false.
  bool get isEmpty;

  /// Returns true if this json array is not empty, otherwise false.
  bool get isNotEmpty;
}
