import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/home/widget/widget.dart';
import 'package:unitaskpro/features/myday/provider/state.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

@immutable
class MyTaskDetailPage extends ConsumerWidget {
  const MyTaskDetailPage({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    var sizeOf = MediaQuery.sizeOf(context);
    var themeData = Theme.of(context);
    ref.watch(sectionProvider);

    var asyncValue = ref.read(sectionProvider.notifier);
    var task = asyncValue.getcurrentTaskById(taskModel.id);

    return ScaffoldWidget(
      appBar: AppBarWidget(
        actions: task == null
            ? []
            : [
                IconButton(
                    onPressed: () {
                      var copyWith = task.copyWith(isStar: !task.isStar);
                      asyncValue.updateTaskById(copyWith);
                    },
                    icon: Icon(!task.isStar ? Icons.star_border : Icons.star)),
                horizontalMargin4,
                IconButton(
                    onPressed: () {
                      var child = Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          RowItemWidget(
                            title: Text(
                              context.local.tChangetheme,
                            ),
                            icon: LucideIcons.lightbulb,
                            onTap: () {
                              var child = BcWidget(taskModel: task);
                              showSheet(context, child: child);
                            },
                          ),
                          RowItemWidget(
                              onTap: () {
                                asyncValue.removeTaskById(taskModel);
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              },
                              title: const Text('Delete'),
                              icon: LucideIcons.trash2),
                        ]),
                      );
                      showSheet(context, child: child);
                    },
                    icon: const Icon(LucideIcons.moreVertical)),
                horizontalMargin8
              ],
      ),
      body: task == null
          ? emptyWidget
          : SizedBox(
              // height: sizeOf.height - sizeOf.height * .3,
              child: StretchyHeader.listView(
                displacement: 1,
                headerData: HeaderData(
                  // highlightHeaderAlignment: HighlightHeaderAlignment.top,
                  headerHeight: sizeOf.height * .3,
                  header: CachedNetworkImage(
                      imageUrl: task.img.isNotEmpty
                          ? task.img
                          : BackgroundModel.images.first,
                      alignment: Alignment.center,
                      fit: BoxFit.cover),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(taskModel.title,
                          style: themeData.textTheme.titleLarge),
                      IconButton.outlined(
                          onPressed: () {
                            var copyWith = task.copyWith(isDone: !task.isDone);
                            asyncValue.updateTaskById(copyWith);
                          },
                          icon: Icon(!task.isDone
                              ? LucideIcons.circle
                              : LucideIcons.checkCircle)),
                    ],
                  ),
                  verticalMargin12,
                  EditorWidget(
                    taskModel: task,
                    onChange: (str) {
                      var copyWith = task.copyWith(description: str);
                      asyncValue.updateTaskById(copyWith);
                    },
                  ),
                  verticalMargin16,
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Last modufi   ${task.updatedAt}'))
                ],
              ),
            ),
    );
  }
}

@immutable
class BcWidget extends ConsumerWidget {
  const BcWidget({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context, ref) {
    var provider = ref.read(sectionProvider.notifier);

    return Column(
      children: [
        const Text(''),
        verticalMargin16,
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: [
                Row(
                  children: BackgroundModel.images.map((e) {
                    // var selected = taskModel.img == e;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          // read.setBackground(bc.requireValue.copyWith(
                          //     src: e,
                          //     isColor: false,
                          //     isCustom: false,
                          //     isImage: true));

                          provider.updateTaskById(taskModel.copyWith(img: e));
                          Navigator.maybeOf(context);
                        },
                        child: CircleAvatar(
                          maxRadius: 17,
                          backgroundImage: CachedNetworkImageProvider(e),
                          // child: !selected
                          //     ? emptyWidget
                          //     : Container(
                          //         decoration: BoxDecoration(
                          //             border: Border.all(
                          //                 color: themeData
                          //                     .colorScheme.primaryContainer,
                          //                 width: 2),
                          //             shape: BoxShape.circle,
                          //             color: Colors.transparent
                          //             // color: themeData.colorScheme.primary,
                          //             ),
                          //         height: 10,
                          //         width: 10),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                verticalMargin12,
              ],
            )),
      ],
    );
  }
}

@immutable
class EditorWidget extends StatefulWidget {
  const EditorWidget(
      {super.key, required this.taskModel, required this.onChange});

  final TaskModel taskModel;

  final void Function(String str) onChange;

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  late final TextEditingController _textController =
      TextEditingController(text: widget.taskModel.description);

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var sizeOf = MediaQuery.of(context);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        widget.onChange.call(_textController.text);
      },
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TextField(
            controller: _textController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
