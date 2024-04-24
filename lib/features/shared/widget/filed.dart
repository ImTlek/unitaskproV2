import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

@immutable
class AddFiledWidget extends StatefulWidget {
  const AddFiledWidget(
      {super.key, required this.show, this.hintText = 'Message',required this.onAdd});
  final bool show;
  final String hintText;
  final ValueChanged<String> onAdd;
  @override
  State<AddFiledWidget> createState() => _AddFiledWidgetState();
}

class _AddFiledWidgetState extends State<AddFiledWidget> {
  late final TextEditingController controller = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      controller.addListener(editListener);
    });
  }

  void editListener() {
    isEdit = controller.text.isNotEmpty;
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(editListener);
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Card(
      color: themeData.cardColor,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            horizontalMargin12,
            Expanded(
              child: TextField(
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: const TextStyle(),
                    hintText: widget.hintText),
              ),
            ),
            !isEdit
                ? emptyWidget
                : Padding(
                    padding: const EdgeInsets.only(right: 1, top: 2),
                    child: Btn(
                      onTap: () {
                        widget.onAdd(controller.text);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 38,
                        width: 38,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: themeData.hoverColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(LucideIcons.arrowUpFromDot),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

class FiledWidget extends StatefulWidget {
  const FiledWidget({super.key});

  @override
  State<FiledWidget> createState() => FiledWidgetState();
}

class FiledWidgetState extends State<FiledWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onAppPrivateCommand: (action, data) {},
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {}, icon: const Icon(LucideIcons.shieldClose)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        constraints: BoxConstraints.tight(const Size.fromHeight(44)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              // color: Colors.greenAccent,
              ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              // color: Colors.red,
              ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              // color: Colors.red,
              ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget(
      {super.key, required this.items, this.hintText = '', this.onChanged});

  final List<T>? items;
  final String hintText;
  final Function(T)? onChanged;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return CustomDropdown<T>(
        decoration: CustomDropdownDecoration(
            listItemDecoration: ListItemDecoration(
                selectedIconBorder: BorderSide.none,
                splashColor: themeData.splashColor,
                highlightColor: themeData.hoverColor),
            closedBorder: Border.all(),
            expandedBorder: Border.all(),
            closedErrorBorder: Border.all(),
            closedErrorBorderRadius: BorderRadius.circular(30),
            closedFillColor: Colors.transparent,
            closedBorderRadius: BorderRadius.circular(30),
            expandedBorderRadius: BorderRadius.circular(30),
            expandedFillColor: themeData.cardColor),
        hintText: hintText,
        items: items,
        initialItem: items?[0],
        onChanged: onChanged);
  }
}




@immutable
class SearchFiledWisget extends StatefulWidget {
  const SearchFiledWisget(
      {super.key,
      this.onChange,
      this.initStr,
      this.onSearch,
      this.lable,
      this.onClear});
  final ValueChanged<String>? onChange;
  final String? initStr;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onClear;
  final String? lable;

  @override
  State<SearchFiledWisget> createState() => _SearchFiledWisgetState();
}

class _SearchFiledWisgetState extends State<SearchFiledWisget> {
  TextEditingController? controller;
  late ValueNotifier<bool> clearIcon;
  @override
  void initState() {
    super.initState();
    clearIcon = ValueNotifier(false);
    controller = TextEditingController(text: widget.initStr);
  }

  @override
  void dispose() {
    controller?.dispose();
    clearIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10)
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  onSaved: (s) {
                    controller?.clear();
                    widget.onClear?.call();
                    if (s != null && s.isEmpty) {
                      widget.onSearch?.call('');
                    }
                  },
                  onChanged: (str) {
                    clearIcon.value = true;
                    widget.onChange?.call(str);
                    clearIcon.value = str.isNotEmpty;

                    if (str.isEmpty) {
                      widget.onSearch?.call('');
                    }
                  },
                  onFieldSubmitted: (str) {
                    widget.onSearch?.call(str);
                    if (str.isEmpty) {
                      widget.onSearch?.call('');
                    }
                  },
                  decoration: InputDecoration(
                      label: Text(widget.lable ?? ''),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      errorStyle: const TextStyle(height: -.1),
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      // prefixIconColor: Colors.black26,
                      // suffixIconColor: Colors.black26,
                      suffixIcon: ValueListenableBuilder<bool>(
                          valueListenable: clearIcon,
                          builder: (context, value, child) => value
                              ? _clearBtn(() {
                                  widget.onClear?.call();
                                  controller?.text = '';
                                  controller?.clear();
                                  clearIcon.value = false;
                                  widget.onChange?.call('');
                                  widget.onSearch?.call('');
                                })
                              : const SizedBox.shrink())),
                ),
              ],
            ),
          ),
          horizontalMargin4,
          IconButton.filledTonal(
              onPressed: () {
                widget.onSearch?.call(controller!.text);
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

@immutable
class TextfiledBigWidget extends StatelessWidget {
  const TextfiledBigWidget(
      {super.key,
      this.hintText = '',
      this.label = '',
      this.maxLines = 3,
      required this.onChange,
      this.maxLength,
      this.initialValue,
      this.mustValidate = false});

  final String hintText;
  final String label;
  final int maxLines;
  final ValueChanged<String> onChange;
  final int? maxLength;
  final String? initialValue;
  final bool mustValidate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        onChanged: onChange,
        validator: mustValidate
            ? (str) {
                if (str!.isEmpty) {
                  return '';
                }
                return null;
              }
            : null,
        maxLength: maxLength,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          // prefixIcon:
          // widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          // errorStyle: const TextStyle(height: -.1),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(4.0),
          ),
          prefixIconColor: Colors.black26,
          suffixIconColor: Colors.black26,
        ));
  }
}

@immutable
class StandartTextField extends StatefulWidget {
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final double vertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final bool expands;
  final int? maxLines;
  final bool? mustValidate;
  final Color? fillColor;

  const StandartTextField({
    Key? key,
    this.fillColor,
    this.expands = false,
    this.maxLength,
    this.style,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.autocorrect = true,
    this.inputFormatters,
    this.vertical = 0,
    this.onFieldSubmitted,
    this.focusNode,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.label,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.maxLines = 1,
    this.mustValidate,
  }) : super(key: key);

  @override
  State<StandartTextField> createState() => _StandartTextFieldState();
}

class _StandartTextFieldState extends State<StandartTextField> {
  final TextEditingController controller = TextEditingController();
  late ValueNotifier<bool> clearIcon;
  @override
  void initState() {
    super.initState();
    clearIcon = ValueNotifier(false);

    // if (widget.hintText != null) {
    //   controller.text = widget.hintText!;
    // }
  }

  @override
  void dispose() {
    controller.dispose();
    clearIcon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      fit: StackFit.expand,
      children: [
        TextFormField(
            focusNode: widget.focusNode,
            controller: controller,
            style: widget.style,
            maxLength: widget.maxLength,
            textInputAction: widget.textInputAction,
            onSaved: (s) {
              controller.clear();
            },
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onFieldSubmitted,
            autocorrect: widget.autocorrect,
            textAlign: widget.textAlign,
            onChanged: (str) {
              if (str.isNotEmpty) {
                clearIcon.value = true;
                if (widget.onChanged != null) widget.onChanged!(str);
              } else {
                clearIcon.value = false;
              }
            },
            onEditingComplete: widget.onEditingCompleted,
            autofocus: widget.autofocus ?? false,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
                border: InputBorder.none,
                alignLabelWithHint: true,
                errorStyle: const TextStyle(height: -.01),
                // contentPadding: const EdgeInsets.symmetric(
                //     horizontal: 10, vertical: 15),
                filled: true,
                fillColor: Colors.green,
                hintText: widget.hintText,
                prefixIcon: widget.prefixIcon),
            onTap: widget.onTap,
            enabled: widget.enabled,
            readOnly: widget.readOnly!,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType,
            textAlignVertical: TextAlignVertical.center,
            validator: (str) {
              if (str!.isEmpty) {
                return "";
              } else {
                return null;
              }
            }),
        IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                    valueListenable: clearIcon,
                    builder: (context, value, child) => value
                        ? _clearBtn(() {
                            controller.text = '';
                            controller.clear();

                            clearIcon.value = false;
                          })
                        : const SizedBox()),
              ],
            ),
          ),
        )
      ],
    );
  }
}

GestureDetector _clearBtn(VoidCallback onTap) {
  return GestureDetector(onTap: onTap, child: const Icon(Icons.clear));
}

@immutable
class TextFiledWidget extends StatefulWidget {
  const TextFiledWidget(
      {Key? key,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.onEditingCompleted,
      this.keyboardType,
      this.onChanged,
      this.isMulti = false,
      this.autofocus,
      this.enabled,
      this.errorText,
      this.label,
      this.suffix,
      this.prefix,
      this.hintText,
      this.prefixIcon,
      this.focusNode,
      this.onFieldSubmitted,
      this.vertical = 0,
      this.inputFormatters,
      this.autocorrect = false,
      this.style,
      this.textInputAction,
      this.textAlign = TextAlign.left,
      this.maxLength,
      this.expands = false,
      this.maxLines,
      this.mustValidate,
      this.controller,
      this.borderRadius,
      this.fillColor,
      this.initStr})
      : super(key: key);
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final double vertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final bool expands;
  final int? maxLines;
  final bool? mustValidate;
  final IconData? prefixIcon;
  final String? initStr;

  @override
  State<TextFiledWidget> createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  TextEditingController? controller;
  late ValueNotifier<bool> clearIcon;
  @override
  void initState() {
    super.initState();
    clearIcon = ValueNotifier(false);

    if (widget.controller == null) {
      controller = TextEditingController(text: widget.initStr);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    clearIcon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isMulti ? 228 : 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.1),
          //   spreadRadius: 1,
          //   blurRadius: 10,
          // ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1, //spread radius
            blurRadius: 10, // blur radius
          ),
        ],
      ),
      child: Stack(
        // alignment: Alignment.center,
        fit: StackFit.expand,

        children: [
          TextFormField(
              focusNode: widget.focusNode,
              controller: controller,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              onSaved: (s) {
                controller?.clear();
              },
              inputFormatters: widget.inputFormatters,
              onFieldSubmitted: widget.onFieldSubmitted,
              autocorrect: widget.autocorrect,
              textAlign: widget.textAlign,
              onChanged: (str) {
                if (str.isNotEmpty) {
                  clearIcon.value = true;
                  if (widget.onChanged != null) widget.onChanged!(str);
                } else {
                  clearIcon.value = false;
                }
              },
              onEditingComplete: widget.onEditingCompleted,
              autofocus: widget.autofocus ?? false,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                  filled: false,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon)
                      : null,
                  errorStyle: const TextStyle(height: -.1),
                  hintText: widget.hintText?.trim(),
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: widget.label,
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  prefixIconColor: Colors.black26,
                  suffixIconColor: Colors.black26,
                  suffixIcon: ValueListenableBuilder<bool>(
                      valueListenable: clearIcon,
                      builder: (context, value, child) => value
                          ? _clearBtn(() {
                              controller?.text = '';
                              controller?.clear();
                              clearIcon.value = false;
                            })
                          : const SizedBox.shrink())),
              // cursor ,
              onTap: widget.onTap,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              validator: (str) {
                if (str!.isEmpty) {
                  return ' '; //'${widget.label} !';
                } else {
                  return null;
                }
              }),
        ],
      ),
    );
  }
}

@immutable
class DroBtnFormFieldWidget extends StatelessWidget {
  const DroBtnFormFieldWidget(
      {super.key, this.hintText, this.label, this.prefixIcon});

  final IconData? prefixIcon;
  final String? hintText;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        errorStyle: const TextStyle(height: -.1),
        hintText: hintText?.trim(),
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(4.0),
        ),
        prefixIconColor: Colors.black26,
        suffixIconColor: Colors.black26,
      ),
      value: 'enable',
      items: ['enable', 'diable']
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (value) {},
    );
  }
}

@immutable
class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  // final bool? isPassword;
  final IconData? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final double vertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final int? maxLength;
  final bool expands;
  final int? maxLines;
  final bool? mustValidate;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final String? initStr;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.fillColor,
    this.expands = false,
    this.maxLength,
    this.style,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.autocorrect = true,
    this.inputFormatters,
    this.vertical = 0,
    this.onFieldSubmitted,
    this.focusNode,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = true,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.label,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.maxLines = 1,
    this.mustValidate,
    this.validator,
    this.initStr,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<PasswordTextField> {
  TextEditingController? controller;

  late ValueNotifier<bool> ovalueListenable;

  @override
  void initState() {
    super.initState();
    ovalueListenable = ValueNotifier(true);
    if (widget.controller == null) {
      controller = TextEditingController(text: widget.initStr);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    ovalueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1, //spread radius
            blurRadius: 10, // blur radius
          ),
        ],
      ),
      child: ValueListenableBuilder(
        valueListenable: ovalueListenable,
        builder: (context, v, child) => TextFormField(
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          obscureText: v,
          controller: widget.controller ?? controller,
          textInputAction: widget.textInputAction,
          autovalidateMode: AutovalidateMode.disabled,
          maxLength: widget.maxLength,
          // cursor ,
          decoration: InputDecoration(
              filled: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              errorStyle: const TextStyle(height: -.1),
              hintText: widget.hintText?.trim(),
              hintStyle: const TextStyle(color: Colors.grey),
              labelText: widget.label,
              labelStyle: const TextStyle(
                color: Colors.grey,
              ),

              // error: Icon(Icons.abc),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(4.0),
              ),
              // prefixIconColor: Colors.black26,
              // suffixIconColor: Colors.black26,
              suffixIcon: GestureDetector(
                  onTap: () {
                    ovalueListenable.value = !ovalueListenable.value;
                  },
                  child: Icon(
                    v ? Icons.visibility : Icons.visibility_off,
                  ))),
          cursorHeight: 23,
          onSaved: (s) {
            (widget.controller ?? controller)?.clear();
          },
          validator: widget.validator ??
              (s) {
                if (s!.isEmpty) {
                  return ' '; //'${widget.label}';
                } else {
                  return null;
                }
              },
          onChanged: (str) {
            if (str.isNotEmpty) {
              if (widget.onChanged != null) widget.onChanged!(str);
            }
          },
        ),
      ),
    );
  }
}
