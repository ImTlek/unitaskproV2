import 'dart:ui';
import 'widget/bc.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unitaskpro/features/home/widget/widget.dart';
import 'package:unitaskpro/features/myday/provider/myday.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
 

ScreenshotController _screenshotController = ScreenshotController();

class MydayPage extends StatefulWidget {
  const MydayPage({super.key});

  static IconData get icon => LucideIcons.checkCircle2;

  @override
  State<MydayPage> createState() => _MydayPageState();
}

class _MydayPageState extends State<MydayPage> {
  @override
  Widget build(BuildContext context) {
    return Screenshot(
        controller: _screenshotController, child: const _MydayPage());
  }
}

@immutable
class _MydayPage extends ConsumerWidget {
  const _MydayPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(sectionProvider);
    var mydayTasks = getMydayTasks(ref);
    var provider = ref.read(sectionProvider.notifier);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          heroTag: 'x',
          onPressed: () async {
            var child = AddTaskWidget(
                onAdd: (value) {}, onMyDayAdd: provider.addTask, isMyday: true);
            showSheet(context, child: child);
          },
          child: const Icon(LucideIcons.plus),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundWid(),
            FadeInDown(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    expandedHeight: 130.0,
                    actions: [
                      Btn(
                          onTap: () {
                            var child = const SettingWidget();
                            showSheet(context, child: child);
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(LucideIcons.moreVertical))),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      titlePadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GreetingText(
                                  locale: Locale(context.local.localeName),
                                  name: FirebaseAuth
                                          .instance.currentUser?.email ??
                                      ''),
                              const LocalizedDateTimeDisplay(),
                              verticalMargin8
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverList.separated(
                      separatorBuilder: (context, index) => verticalMargin4,
                      itemCount: mydayTasks.length,
                      itemBuilder: (context, index) {
                        var mydayTask = mydayTasks[index];
                        return TaskItem(
                          mydayTask: mydayTask,
                          onDoneChanged: (isDone) {
                            provider.updateTaskById(
                                mydayTask.copyWith(isDone: isDone));
                          },
                          onIsStarChanged: (isStar) {
                            provider.updateTaskById(
                                mydayTask.copyWith(isStar: isStar));
                          },
                          delte: () {
                            provider.removeTaskById(mydayTask);
                          },
                          remove: () {
                            provider.updateTaskById(
                                mydayTask.copyWith(isMyDay: false));
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

@immutable
class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(children: [
        const MydayBcWid(),
        RowItemWidget(
          title: Text(context.local.tShareacopy),
          icon: LucideIcons.share2,
          onTap: () async {
            final directory = (await getApplicationDocumentsDirectory()).path;
            _screenshotController.captureAndSave(directory).then((path) {
              if (path != null) {
                final imageFile = XFile(path);
                Share.shareXFiles([imageFile], text: context.local.tMyday)
                    .whenComplete(() {
                  Navigator.maybeOf(context);
                });
              }
            });
          },
        ),
        RowItemWidget(
          title: Text(context.local.tPrintlist),
          icon: LucideIcons.printer,
          onTap: () {},
        ),
        verticalMargin12
      ]),
    );
  }
}
