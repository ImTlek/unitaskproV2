import 'animated.switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Btn extends StatelessWidget {
  const Btn({super.key, required this.child, this.onTap});
  final VoidCallback? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // var themeData = Theme.of(context);
    return CupertinoButton(
      onPressed: onTap,
      // color: themeData.canvasColor
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      alignment: Alignment.center,
      // borderRadius: BorderRadius.circular(6),
      // padding: EdgeInsets.zero,
      child: child,
    );
  }
}

class RectangleBtn extends StatelessWidget {
  const RectangleBtn(
      {super.key, this.onTap, this.child, this.title, this.fill = true});
  final VoidCallback? onTap;
  final Widget? child;
  final String? title;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Btn(
      onTap: onTap,
      child: Container(
        // alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: themeData.highlightColor,
            border: Border.all(color: themeData.dividerColor)),
        child: child ?? Text(title ?? 'No title'),
      ),
    );
  }
}

class CirculerBtn extends StatelessWidget {
  const CirculerBtn({super.key, this.onTap, this.child, this.title});
  final VoidCallback? onTap;

  final Widget? child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Btn(
      onTap: onTap,
      child: Container(
        height: 44.0,
        width: 44.0,
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: themeData.highlightColor),
        child: FittedBox(child: child ?? Text(title ?? 'no title')),
      ),
    );
  }
}

@immutable
class BtnWidget extends StatelessWidget {
  final Color? backgroundColor;
  const BtnWidget(
      {super.key,
      this.onTap,
      this.backgroundColor,
      required this.child,
      this.minSize});

  final VoidCallback? onTap;
  final Widget child;
  final double? minSize;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: backgroundColor,
      alignment: Alignment.center,
      onPressed: onTap,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      minSize: minSize,
      child: child,
    );
  }
}

CupertinoButton btn(Widget i, VoidCallback? onPressed) => CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      child: i,
    );

Widget buttonWidget({
  required String title,
  void Function()? onTap,
  bool isPositive = true,
  bool isExpanded = true,
  TextStyle? textStyle,
}) {
  if (!isExpanded) {
    return Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPositive ? const Color(0xff1C64EE) : const Color(0xffEEF2F6),
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: SizedBox(
                height: 52,
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      TextStyle(
                          color: isPositive ? Colors.white : Colors.black),
                )))));
  }
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isPositive ? const Color(0xff1C64EE) : Colors.grey),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: textStyle ??
              TextStyle(color: isPositive ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}

@immutable
class PositiveButtonWidget extends StatelessWidget {
  const PositiveButtonWidget(
      {super.key,
      this.isExpanded = false,
      required this.onTap,
      required this.title,
      this.textStyle});
  final String title;
  final VoidCallback onTap;
  final bool isExpanded;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    if (!isExpanded) {
      return Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: themeData.colorScheme.primaryContainer),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: SizedBox(
            height: 52,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: themeData.primaryColor),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle,
              // style: textStyle ??
              //     TextStyle(color: isPositive ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class NegativeButtonWidget extends StatelessWidget {
  const NegativeButtonWidget(
      {super.key,
      this.isExpanded = false,
      required this.onTap,
      required this.title});
  final String title;
  final VoidCallback onTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    if (!isExpanded) {
      return Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: themeData.secondaryHeaderColor),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: SizedBox(
            height: 52,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                // style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: themeData.secondaryHeaderColor),
            child: Text(
              title,
              textAlign: TextAlign.center,
              // style: textStyle ??
              //     TextStyle(color: isPositive ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class LoadingBtnWidget extends StatelessWidget {
  const LoadingBtnWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
    this.disabled = false,
    // this.bgColor,
  });
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final bool disabled;
  // final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: loading || disabled
            ? themeData.primaryColor.withOpacity(.5)
            : themeData.primaryColor,
      ),
      duration: const Duration(milliseconds: 300),
      height: 48,
      alignment: Alignment.center,
      child: AnimatedSwitchWidget(
        duration: 200,
        child: SizedBox(
          key: ValueKey(loading),
          child: loading
              ? SizedBox(
                  width: 44,
                  child: CupertinoActivityIndicator(
                      color: themeData.scaffoldBackgroundColor))
              : Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: disabled ? null : onTap,
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: themeData.scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
