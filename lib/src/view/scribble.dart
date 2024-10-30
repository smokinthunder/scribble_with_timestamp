import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scribble_with_timestamp/src/view/notifier/scribble_notifier.dart';
import 'package:scribble_with_timestamp/src/view/painting/scribble_editing_painter.dart';
import 'package:scribble_with_timestamp/src/view/painting/scribble_painter.dart';
import 'package:scribble_with_timestamp/src/view/pan_gesture_catcher.dart';
import 'package:scribble_with_timestamp/src/view/state/scribble.state.dart';

/// {@template scribble}
/// This Widget represents a canvas on which users can draw with any pointer.
///
/// You can control its behavior from code using the [notifier] instance you
/// pass in.
/// {@endtemplate}
class Scribble extends StatelessWidget {
  /// {@macro scribble}
  const Scribble({
    /// The notifier that controls this canvas.
    required this.notifier,

    /// Whether to draw the pointer when in drawing mode
    this.drawPen = true,

    /// Whether to draw the pointer when in erasing mode
    this.drawEraser = true,
    this.simulatePressure = true,
    super.key,
  });

  /// The notifier that controls this canvas.
  final ScribbleNotifierBase notifier;

  /// Whether to draw the pointer when in drawing mode
  final bool drawPen;

  /// Whether to draw the pointer when in erasing mode
  final bool drawEraser;

  /// {@template scribble.simulate_pressure}
  /// Whether to simulate pressure when drawing lines that don't have pressure
  /// information (all points have the same pressure).
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool simulatePressure;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ScribbleState>(
      valueListenable: notifier,
      builder: (context, state, _) {
        final drawCurrentTool =
            drawPen && state is Drawing || drawEraser && state is Erasing;
        final child = SizedBox.expand(
          child: CustomPaint(
            foregroundPainter: ScribbleEditingPainter(
              state: state,
              drawPointer: drawPen,
              drawEraser: drawEraser,
              simulatePressure: simulatePressure,
            ),
            child: RepaintBoundary(
              key: notifier.repaintBoundaryKey,
              child: CustomPaint(
                painter: ScribblePainter(
                  sketch: state.sketch,
                  scaleFactor: state.scaleFactor,
                  simulatePressure: simulatePressure,
                ),
              ),
            ),
          ),
        );
        return !state.active
            ? child
            : GestureCatcher(
                pointerKindsToCatch: state.supportedPointerKinds,
                child: MouseRegion(
                  cursor: drawCurrentTool &&
                          state.supportedPointerKinds
                              .contains(PointerDeviceKind.mouse)
                      ? SystemMouseCursors.none
                      : MouseCursor.defer,
                  onExit: notifier.onPointerExit,
                  child: Listener(
                    onPointerDown: notifier.onPointerDown,
                    onPointerMove: notifier.onPointerUpdate,
                    onPointerUp: notifier.onPointerUp,
                    onPointerHover: notifier.onPointerHover,
                    onPointerCancel: notifier.onPointerCancel,
                    child: child,
                  ),
                ),
              );
      },
    );
  }
}
