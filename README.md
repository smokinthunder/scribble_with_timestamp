# Scribble with time stamp

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg)](https://github.com/invertase/melos)
![coverage](./coverage.svg)

Scribble is a lightweight library for freehand drawing in Flutter supporting pressure, variable line width and more!

By intoducing the time stamp feature we could find time at which each point was created and calculate time related datas like speed, accelaration stalling time, and more!

![Scribble Demo](https://raw.githubusercontent.com/timcreatedit/scribble/main/scribble_demo.gif)

## Installation 💻

**❗ In order to start using Scribble you must have the [Dart SDK][dart_install_link] installed on your machine.**

Install via `dart pub add`:

```sh
dart pub add scribble_with_timestamp
```

---

## Features

* Variable line width
* Image Export
* Pen and touch pressure support
* Line simplification for making sketch files smaller
* Choose which pointers can draw (touch, pen, mouse, etc.)
* Lines get slimmer when the pen is moved more quickly
* Line eraser support
* Full undo/redo support using [value_notifier_tools](https://pub.dev/packages/value_notifier_tools)
* Sketches are fully serializable to JSON
* Export Sketches to PNG

## Additional Features

* Timestamp Tracking : Retrieve the timestamp of all points drawn, included in the serialized JSON output.

## Usage

> You can find a full working example in the [example](./example) directory

You can create a drawing surface by adding the `Scribble` widget to your widget tree and passing in
a `ScribbleNotifier`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scribble(
        notifier: notifier,
      ),
    );
  }
}
```

Use the public methods on `ScribbleNotifier` to control the behavior (for example from a button in the UI):

```dart
notifier = ScribbleNotifier();


// Set color
notifier.setColor(Colors.black);

// Clear
notifier.clear();

// Undo
notifier.undo();

// Export to Image
notifier.renderImage(pixelRatio: 2.0);

// Line details will be simplified to save space from now on
notifier.setSimplificationFactor(2);

// Simplify the entire existing sketch
notifier.simplify();

// And more ... 
```

## Additional information

As mentioned above, the package is still under development, but we already use it in the app we are currently
developing.

Feel free to contribute, or open issues in our [GitHub repo](https://github.com/smokinthunder/scribble_with_timestamp).


[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[mason_link]: https://github.com/felangel/mason
[very_good_ventures_link]: https://verygood.ventures
