import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:unitaskpro/features/home/widget/widget.dart';
import 'package:unitaskpro/features/myday/provider/state.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unitaskpro/services/theme/constant/app.color.dart';
import 'package:unitaskpro/features/myday/provider/background.dart';

@immutable
class BackgroundWid extends ConsumerWidget {
  const BackgroundWid({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Consumer(
      builder: (context, ref, child) {
        var watch = ref.watch(bcProvider);
        return watch.when(
          data: (data) {
            var isColor = data.src.contains('#');
            return SizedBox(
              child: isColor
                  ? Container(
                      decoration: BoxDecoration(color: data.src.toColor),
                    )
                  : SingleChildScrollView(
                      child: SizedBox(
                        width: sizeOf.width,
                        height: sizeOf.height,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: watch.requireValue.src,
                          placeholder: (context, url) => emptyWidget,
                          errorWidget: (context, url, error) => emptyWidget,
                        ),
                      ),
                    ),
            ).animate(key: ValueKey(watch.requireValue.src)).fadeIn();
          },
          error: (error, stackTrace) => const LoadingWid(),
          loading: () => const LoadingWid(),
        );
      },
    );
  }
}

class MydayBcWid extends StatelessWidget {
  const MydayBcWid({super.key});

  @override
  Widget build(BuildContext context) {
    return RowItemWidget(
      title: Text(context.local.tChangetheme),
      icon: LucideIcons.lightbulb,
      onTap: () {
        var child = const _ThemeSelectionWid();
        showSheet(context, child: child);
      },
    );
  }
}

class _ThemeSelectionWid extends StatelessWidget {
  const _ThemeSelectionWid({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    final bool isLight = themeData.brightness == Brightness.light;
    return Consumer(
      builder: (context, ref, child) {
        var bc = ref.watch(bcProvider);
        var read = ref.read(bcProvider.notifier);
        return Column(
          children: [
            const Text(''),
            verticalMargin16,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Btn(
                    onTap: () {
                      read.setBcType(false);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: bc.requireValue.isColor
                                  ? themeData.colorScheme.primary
                                  : Colors.transparent),
                          color: bc.requireValue.isColor
                              ? themeData.colorScheme.primaryContainer
                                  .withOpacity(.5)
                              : themeData.disabledColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(LucideIcons.palette),
                    ),
                  ),
                  Btn(
                    onTap: () {
                      read.setBcType(true);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: bc.requireValue.isImage
                                  ? themeData.colorScheme.primary
                                  : Colors.transparent),
                          color: bc.requireValue.isImage
                              ? themeData.colorScheme.primaryContainer
                                  .withOpacity(.5)
                              : themeData.disabledColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(LucideIcons.image),
                    ),
                  ),
                ],
              ),
            ),
            verticalMargin8,
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    bc.requireValue.isColor
                        ? Row(
                            children: AppColor.customSchemes.map((e) {
                              var color =
                                  isLight ? e.light.primary : e.dark.primary;
                              var selected = bc.requireValue.src == color.hex;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InkWell(
                                  onTap: () {
                                    read.setBackground(bc.requireValue.copyWith(
                                        src: color.hex,
                                        isColor: true,
                                        isCustom: false,
                                        isImage: false));
                                  },
                                  child: CircleAvatar(
                                      maxRadius: 17,
                                      backgroundColor: color,
                                      child: !selected
                                          ? emptyWidget
                                          : Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: themeData
                                                      .colorScheme.background),
                                              height: 10,
                                              width: 10)),
                                ),
                              );
                            }).toList(),
                          )
                        : Row(
                            children: BackgroundModel.images.map((e) {
                              var selected = bc.requireValue.src == e;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InkWell(
                                  onTap: () {
                                    read.setBackground(bc.requireValue.copyWith(
                                        src: e,
                                        isColor: false,
                                        isCustom: false,
                                        isImage: true));
                                  },
                                  child: CircleAvatar(
                                      maxRadius: 17,
                                      backgroundImage:
                                          CachedNetworkImageProvider(e),
                                      child: !selected
                                          ? emptyWidget
                                          : Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: themeData
                                                          .colorScheme
                                                          .primaryContainer,
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                  color: themeData
                                                      .colorScheme.primary),
                                              height: 10,
                                              width: 10)),
                                ),
                              );
                            }).toList(),
                          ),
                    verticalMargin12,
                  ],
                )),
          ],
        );
      },
    );
  }
}
