// Copyright (c) 2021, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:json_response/src/json_impl.dart';

void main() {
  _testFromJsonString();
  _testFromJsonMap();

  _testIsEmptyWhenJsonIsNotEmpty();
  _testIsEmptyWhenJsonIsEmpty();
  _testIsNotEmptyWhenJsonIsNotEmpty();
  _testIsNotEmptyWhenJsonIsEmpty();
  _testContainsKey();
  _testKeySet();

  _testGetStringValue();
  _testGetStringValues();
  _testGetIntValue();
  _testGetIntValues();
  _testGetDoubleValue();
  _testGetDoubleValues();
  _testGetBoolValue();
  _testGetBoolValues();

  _testGetJsonFromJsonString();
  _testGetJsonFromJsonMap();

  _testXmlResponse();
  _integrationTest();
}

void _testFromJsonString() {
  test('Test fromJsonString.', () {
    final json = JsonImpl.fromString(value: '{"test": true}');
    expect(json.getBool(key: 'test'), true);
  });
}

void _testFromJsonMap() {
  test('Test fromJsonMap.', () {
    final json = JsonImpl.fromMap(value: {"test": true});
    expect(json.getBool(key: 'test'), true);
  });
}

void _testIsEmptyWhenJsonIsNotEmpty() {
  test('Test isEmpty when JSON is not empty.', () {
    final json = JsonImpl.fromMap(value: {'test': true});
    expect(json.isEmpty, false);
  });
}

void _testIsEmptyWhenJsonIsEmpty() {
  test('Test isEmpty when JSON is empty.', () {
    final json = JsonImpl.fromMap(value: {});
    expect(json.isEmpty, true);
  });
}

void _testIsNotEmptyWhenJsonIsNotEmpty() {
  test('Test isNotEmpty when JSON is not empty.', () {
    final json = JsonImpl.fromMap(value: {'test': true});
    expect(json.isNotEmpty, true);
  });
}

void _testIsNotEmptyWhenJsonIsEmpty() {
  test('Test isNotEmpty when JSON is empty.', () {
    final json = JsonImpl.fromMap(value: {});
    expect(json.isNotEmpty, false);
  });
}

void _testContainsKey() {
  test('Test containsKey', () {
    final json = JsonImpl.fromMap(value: {
      'test': {'test2': true},
      'test3': [
        {'test4': 1}
      ]
    });

    expect(json.isEmpty, false);
    expect(json.containsKey(key: 'test'), true);
    expect(json.containsKey(key: 'test2'), false);
    expect(json.containsKey(key: 'test3'), true);
    expect(json.containsKey(key: 'test4'), false);
  });
}

void _testKeySet() {
  test('Test keySet', () {
    final json = JsonImpl.fromMap(
      value: {'test1': '', 'test2': '', 'test5': ''},
    );

    final keys = json.keySet;
    expect(keys.length, 3);
  });
}

void _testGetStringValue() {
  test('Test getStringValue.', () {
    final json = JsonImpl.fromMap(value: {'test': 'success'});
    expect(json.isEmpty, false);
    expect(json.getString(key: 'test'), 'success');
    expect(json.getString(key: 'not_exist'), '');
    expect(
        json.getString(key: 'not_exist', defaultValue: 'default'), 'default');
  });
}

void _testGetIntValue() {
  test('Test getIntValue.', () {
    final json = JsonImpl.fromMap(value: {'test': 1});
    expect(json.isEmpty, false);
    expect(json.getInt(key: 'test'), 1);
    expect(json.getInt(key: 'not_exist'), -1);
    expect(json.getInt(key: 'not_exist', defaultValue: 0), 0);
  });
}

void _testGetDoubleValue() {
  test('Test getDoubleValue.', () {
    final json = JsonImpl.fromMap(value: {'test': 1.0});
    expect(json.isEmpty, false);
    expect(json.getDouble(key: 'test'), 1.0);
    expect(json.getDouble(key: 'not_exist'), -1.0);
    expect(json.getDouble(key: 'not_exist', defaultValue: 0.0), 0.0);
  });
}

void _testGetDoubleValues() {
  test('Test getDoubleValues.', () {
    final json = JsonImpl.fromMap(value: {
      'test': [1.0, -0.1, 0.0]
    });
    expect(json.isEmpty, false);
    expect(json.getDoubleValues(key: 'test'), [1.0, -0.1, 0.0]);
  });
}

void _testGetBoolValue() {
  test('Test getBoolValue.', () {
    final json = JsonImpl.fromMap(value: {'test': true});
    expect(json.isEmpty, false);
    expect(json.getBool(key: 'test'), true);
    expect(json.getBool(key: 'not_exist'), false);
    expect(json.getBool(key: 'not_exist', defaultValue: true), true);
  });
}

void _testGetBoolValues() {
  test('Test getBoolValues.', () {
    final json = JsonImpl.fromMap(value: {
      'test': [true, false, true]
    });
    expect(json.isEmpty, false);
    expect(json.getBoolValues(key: 'test'), [true, false, true]);
    expect(json.getBoolValues(key: 'not_exist'), []);
  });
}

void _testGetStringValues() {
  test('Test getStringValues.', () {
    final json = JsonImpl.fromMap(value: {
      'test': ['example_1', 'example_2']
    });

    expect(json.isEmpty, false);
    expect(json.getStringValues(key: 'test'), ['example_1', 'example_2']);
    expect(json.getStringValues(key: 'not_exist'), []);
  });
}

void _testGetIntValues() {
  test('Test getIntValues.', () {
    final json = JsonImpl.fromMap(value: {
      'test': [0, 1]
    });

    expect(json.isEmpty, false);
    expect(json.getIntValues(key: 'test'), [0, 1]);
    expect(json.getIntValues(key: 'not_exist'), []);
  });
}

void _testGetJsonFromJsonString() {
  test('Test getJson from JSON String.', () {
    final json = JsonImpl.fromMap(value: {'test1': '{"test2": true}'});
    expect(json.isEmpty, false);

    final childJson = json.get(key: 'test1');
    expect(childJson.isEmpty, false);
    expect(childJson.getBool(key: 'test2'), true);
  });
}

void _testGetJsonFromJsonMap() {
  test('Test getJson from JSON map.', () {
    final json = JsonImpl.fromMap(value: {
      'test1': {"test2": true}
    });
    expect(json.isEmpty, false);

    final childJson = json.get(key: 'test1');
    expect(childJson.isEmpty, false);
    expect(childJson.getBool(key: 'test2'), true);
  });
}

void _testXmlResponse() {
  test('Test when response body was XML.', () {
    final json = JsonImpl.from(
      response: Response('''
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
      <record>
          <key>3</key>
          <value>3</value>
      </record>
      <record>
          <key>4</key>
          <value>4</value>
      </record>
      <record>
          <key>5</key>
          <value>5</value>
      </record>
    </records>
    ''', 200),
    );

    expect(json.isEmpty, false);
    expect(json.isNotEmpty, true);

    final records = json.get(key: 'records');
    expect(records.isNotEmpty, true);

    final record = records.getArray(key: 'record');
    expect(record.isNotEmpty, true);
    expect(record.length, 5);
  });
}

void _integrationTest() {
  test('Integration test.', () {
    final json = JsonImpl.fromString(value: '''{
    "strength_bars": 1,
    "infinitive": null,
    "normalized_string": "Chuang ",
    "pos": null,
    "last_practiced_ms": 1573347371000,
    "skill": "Home 1",
    "related_lexemes": [
        "example_a",
        "example_b"
    ],
    "test_int_values": [
        1111,
        2222
    ],
    "last_practiced": "2019-11-10T00:56:11Z",
    "strength": 0.22,
    "skill_url_title": "Home-1",
    "gender": null,
    "id": "f763b975c30e465d48f3eccbbdd8843a",
    "lexeme_id": "f763b975c30e465d48f3eccbbdd8843a",
    "word_string": "窓",
    "test_bool": true
}
      ''');

    expect(json.isEmpty, false);

    expect(json.getInt(key: 'strength_bars'), 1);
    expect(json.getString(key: 'infinitive'), '');
    expect(json.getString(key: 'normalized_string'), 'Chuang ');
    expect(json.getString(key: 'pos'), '');
    expect(json.getInt(key: 'last_practiced_ms'), 1573347371000);
    expect(json.getString(key: 'skill'), 'Home 1');
    expect(
      json.getStringValues(key: 'related_lexemes'),
      [
        "example_a",
        "example_b",
      ],
    );
    expect(json.getIntValues(key: 'test_int_values'), [1111, 2222]);
    expect(json.getString(key: 'last_practiced'), '2019-11-10T00:56:11Z');
    expect(json.getDouble(key: 'strength'), 0.22);
    expect(json.getString(key: 'skill_url_title'), 'Home-1');
    expect(json.getString(key: 'gender'), '');
    expect(
      json.getString(key: 'id'),
      'f763b975c30e465d48f3eccbbdd8843a',
    );
    expect(
      json.getString(key: 'lexeme_id'),
      'f763b975c30e465d48f3eccbbdd8843a',
    );
    expect(json.getString(key: 'word_string'), '窓');
    expect(json.getBool(key: 'test_bool'), true);
  });
}
