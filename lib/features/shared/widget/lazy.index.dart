import 'package:flutter/material.dart';
 

@immutable
class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    super.key,
    this.index = 0,
    this.children = const [],
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  /// The index of the child to display.
  final int index;

  /// The list of children that can be displayed.
  final List<Widget> children;

  /// How to align the children in the stack.
  final AlignmentGeometry alignment;

  /// The direction to use for resolving [alignment].
  final TextDirection? textDirection;

  /// How to size the non-positioned children in the stack.
  final StackFit sizing;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedChildren;

  @override
  void initState() {
    super.initState();
    _activatedChildren = List.filled(
      widget.children.length,
      false,
      growable: false,
    )..[widget.index] = true;
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) _activateChild(widget.index);
  }

  void _activateChild(int index) {
    if (!_activatedChildren[index]) {
      setState(() {
        _activatedChildren[index] = true;
      });
    }
  }

  List<Widget> get _children {
    return [
      for (int i = 0; i < widget.children.length; i++)
        if (_activatedChildren[i])
          widget.children[i]
        else
          const SizedBox.shrink(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      index: widget.index,
      children: _children,
    );
  }
}
