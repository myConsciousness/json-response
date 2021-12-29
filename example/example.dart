// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
