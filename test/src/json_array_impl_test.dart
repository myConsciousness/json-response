// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// Project imports:
import 'package:json_response/src/json_array_impl.dart';

void main() {
  test('Test when JSON array is empty.', () {
    final jsonArray = JsonArrayImpl.fromList(values: []);
    expect(jsonArray.isEmpty, true);
    expect(jsonArray.isNotEmpty, false);
  });

  test('Test when JSON array is not empty', () {
    final jsonArray = JsonArrayImpl.fromList(
      values: [
        {'key1': 'value1', 'key2': 'value2'},
        {'key1': 'value1', 'key2': 'value2'},
        {'key1': 'value1', 'key2': 'value2'},
      ],
    );

    expect(jsonArray.isEmpty, false);
    expect(jsonArray.isNotEmpty, true);

    jsonArray.forEach((json) {
      expect(json.isNotEmpty, true);
      expect(json.getString(key: 'key1'), 'value1');
      expect(json.getString(key: 'key2'), 'value2');
    });

    int testIndex = 0;
    jsonArray.enumerate((index, json) {
      expect(json.isNotEmpty, true);
      expect(json.getString(key: 'key1'), 'value1');
      expect(json.getString(key: 'key2'), 'value2');
      expect(index, testIndex);
      testIndex++;
    });

    expect(jsonArray.get(index: 1).getString(key: 'key2'), 'value2');
  });
}
