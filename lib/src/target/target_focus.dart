import 'package:flutter/widgets.dart';
import 'package:tutorial_coach_mark/src/target/target_content.dart';
import 'package:tutorial_coach_mark/src/target/target_position.dart';
import 'package:tutorial_coach_mark/src/util.dart';

class TargetFocus {
  TargetFocus({
    this.identify,
    this.keyTarget,
    this.targetPosition,
    this.tappableTarget,
    this.contents,
    this.shape = ShapeLightFocus.Circle,
    this.tappableShape = ShapeLightFocus.Circle,
    this.radius,
    this.tappableRadius,
    this.borderSide,
    this.tappableBorderSide,
    this.color,
    this.enableOverlayTab = false,
    this.enableTargetTab = true,
    this.alignSkip,
    this.paddingFocus,
    this.tappablePaddingFocus,
    this.focusAnimationDuration,
    this.unFocusAnimationDuration,
    this.pulseVariation,
  }) : assert(keyTarget != null || targetPosition != null);

  final dynamic identify;

  /// 目標, 優先於[targetPosition]
  final GlobalKey? keyTarget;

  /// 可點擊的目標, 若沒指定此目標, 點擊範圍將會以[keyTarget], [targetPosition] 為主
  final GlobalKey? tappableTarget;

  /// 目標範圍
  final TargetPosition? targetPosition;
  final List<TargetContent>? contents;
  final ShapeLightFocus shape;
  final ShapeLightFocus tappableShape;
  final double? radius;
  final double? tappableRadius;
  final BorderSide? borderSide;
  final BorderSide? tappableBorderSide;
  final bool enableOverlayTab;
  final bool enableTargetTab;
  final Color? color;
  final AlignmentGeometry? alignSkip;
  final double? paddingFocus;
  final double? tappablePaddingFocus;
  final Duration? focusAnimationDuration;
  final Duration? unFocusAnimationDuration;
  final Tween<double>? pulseVariation;

  @override
  String toString() {
    return 'TargetFocus{identify: $identify, keyTarget: $keyTarget, tappableTarget: $tappableTarget, targetPosition: $targetPosition, contents: $contents, shape: $shape}';
  }
}
