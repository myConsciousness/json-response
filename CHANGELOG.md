# Release Note

## 2.1.1

- Improved documentation.
- Fixed typo in `enumerateArray` method.
- Renamed the `toFlat` method of the `JsonArray` class to `flatten`.

## 2.1.0

- Improved documentation.
- Fixed the `forEach` method of `JsonArray` so that it returns an empty `Json` if the value it iterates over is null.
- Fixed the `forEachArray` method of `JsonArray` so that it returns an empty `JsonArray` if the value it iterates over is null.

## 2.0.0

- The data structure has been refactored and there are some destructive changes.

1. In the previous method, all states were managed by `JsonResponse`, but `JsonResponse` was abolished and `Json`, which represents a single JSON, and `JsonArray`, which represents a set of multiple JSONs, were added.

2. The process of creating instances in the constructor has changed due to the above changes, but improvements have also been made in this regard so that `Json` and `JsonArray` can be easily created by simply passing `Response` from the http package as an argument to the constructor.

## 1.0.2

- Fixes added in `1.0.1` to be able to determine if the JsonResponse object is empty instead of null check.

## 1.0.1

- Fixed the feature to include null in the JSON list returned by `getJsonList`. Null may be meaningful depending on the data structure

## 1.0.0

- Migrated from the JsonPro package and it is a first release.
