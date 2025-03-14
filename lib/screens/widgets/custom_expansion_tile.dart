import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    this.enabled = true,
    this.decoration,
    this.padding,
    required this.expandedChildren,
    required this.child,
    super.key,
  });

  final bool enabled;
  final Widget child;
  final List<Widget> expandedChildren;
  final Decoration? decoration;
  final EdgeInsets? padding;

  @override
  createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.all(8.0),
      decoration: widget.decoration,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.enabled) {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                });
              }
            },
            child: Column(
              children: [
                widget.child,
                SizeTransition(
                  sizeFactor: _animation,
                  child: Column(
                    children: [
                      ...widget.expandedChildren,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
