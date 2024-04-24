import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unitaskpro/l10n/lan.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:unitaskpro/features/auth/login/view/login.page.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:unitaskpro/features/auth/register/view/register.page.dart';

@immutable
class OnboardingPage extends StatelessWidget {
  const OnboardingPage._({super.key});
  static const routeName = '/onboarding';

  static Route<void> route() {
    return PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation<double> animation, Animation<double> secondaryAnimation) {
      return FadeTransition(
          opacity: animation, child: const OnboardingPage._());
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    var appLocalizations = AppLocalizations.of(context)!;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    return Material(
        child: Stack(
      children: [
        if (canPop)
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      alignment: Alignment.center,
                      onPressed: () => Navigator.of(context).maybePop(),
                      iconSize: 24,
                      icon: const Icon(Icons.arrow_back_ios_sharp))),
            ),
          ),
        Align(
          alignment: const Alignment(0, -0.5),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Unitask Pro',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: themeData.primaryColor)
                  .animate()
                  .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                  .slide()),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
                child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 200, child: Animationwidget()),
                    verticalMargin16,
                    NegativeButtonWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())
                            // LoginPage.route(),
                            );
                      },
                      title: appLocalizations.tLogin,
                    ),
                    verticalMargin16,
                    PositiveButtonWidget(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const RegisterPage())
                            // RegisterPage.route(),
                            );
                      },
                      title: appLocalizations.tRigister,
                    ),
                  ],
                ),
              ),
            ))),
      ],
    ));
  }
}

@immutable
class Animationwidget extends StatelessWidget {
  const Animationwidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    var themeData = Theme.of(context);
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects(
                                blur: const Offset(0, 4),
                                offset: const Offset(0, -250),
                                delay: const Duration(milliseconds: 500),
                                curve: Curves.decelerate),
                            child: Container(
                              alignment: Alignment.center,
                              key: const ValueKey('b'),
                              height: 195,
                              decoration: BoxDecoration(
                                  color: themeData.colorScheme.primary,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4))),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextAnimator(
                                      appLocalizations.tSafe,
                                      initialDelay:
                                          const Duration(milliseconds: 1000),
                                      spaceDelay:
                                          const Duration(milliseconds: 300),
                                      characterDelay:
                                          const Duration(milliseconds: 0),
                                      incomingEffect: WidgetTransitionEffects
                                          .incomingSlideInFromBottom(),
                                    ),
                                    TextAnimator(
                                      // 'Fast',
                                      appLocalizations.tFast,
                                      initialDelay:
                                          const Duration(milliseconds: 1200),
                                      spaceDelay:
                                          const Duration(milliseconds: 0),
                                      characterDelay:
                                          const Duration(milliseconds: 180),
                                      incomingEffect: WidgetTransitionEffects(
                                          rotation: pi / 3, scale: 2),
                                    ),
                                    TextAnimator(
                                      // 'Less',
                                      appLocalizations.tEffective,
                                      spaceDelay:
                                          const Duration(milliseconds: 0),
                                      characterDelay:
                                          const Duration(milliseconds: 180),
                                      incomingEffect: WidgetTransitionEffects
                                          .incomingSlideInFromLeft(),
                                      atRestEffect: WidgetRestingEffects.pulse(
                                          effectStrength: 0.8),
                                      initialDelay:
                                          const Duration(milliseconds: 1900),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                    Expanded(
                        child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects(
                                blur: const Offset(0, 4),
                                offset: const Offset(0, -250),
                                delay: const Duration(milliseconds: 700),
                                curve: Curves.decelerate),
                            outgoingEffect: WidgetTransitionEffects(
                                blur: const Offset(0, 4),
                                offset: const Offset(0, -250),
                                delay: const Duration(milliseconds: 700),
                                curve: Curves.easeIn),
                            child: Container(
                                height: 195,
                                key: const ValueKey('d'),
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.secondary,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(4))),
                                child: WidgetAnimator(
                                    incomingEffect: WidgetTransitionEffects
                                        .incomingSlideInFromTop(
                                            duration:
                                                const Duration(seconds: 1),
                                            delay: const Duration(
                                                milliseconds: 2750),
                                            curve: Curves.bounceOut),
                                    atRestEffect: WidgetRestingEffects.rotate(
                                        effectStrength: 1,
                                        curve: Curves.linear),
                                    child: const Icon(CupertinoIcons.alarm,
                                        size: 48))))),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects(
                                blur: const Offset(0, 4),
                                offset: const Offset(0, 250),
                                delay: const Duration(milliseconds: 1100),
                                curve: Curves.decelerate),
                            outgoingEffect: WidgetTransitionEffects(
                                blur: const Offset(0, 4),
                                offset: const Offset(0, 250),
                                delay: const Duration(milliseconds: 1100),
                                curve: Curves.easeIn),
                            child: Container(
                                height: 195,
                                key: const ValueKey('z'),
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.inversePrimary,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(4))),
                                child: WidgetAnimator(
                                    incomingEffect: WidgetTransitionEffects
                                        .incomingSlideInFromBottom(
                                            duration:
                                                const Duration(seconds: 2),
                                            delay: const Duration(
                                                milliseconds: 4750),
                                            curve: Curves.elasticOut),
                                    atRestEffect: WidgetRestingEffects(
                                        effectStrength: 0.5,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        builder: (WidgetRestingEffects effects,
                                            AnimationController
                                                animationController) {
                                          AnimationSettings animationSettings =
                                              AnimationSettings(
                                                  animationController:
                                                      animationController);

                                          double rotationAmount = 18;
                                          rotationAmount = (-rotationAmount *
                                                  (effects.effectStrength!))
                                              .clamp(-300, 300);

                                          animationSettings.offsetYAnimation =
                                              TweenSequence<double>(
                                            <TweenSequenceItem<double>>[
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin: 0, end: 6)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                                weight: 50.0,
                                              ),
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin: 6, end: 0)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.bounceOut)),
                                                weight: 50.0,
                                              ),
                                            ],
                                          ).animate(CurvedAnimation(
                                                  parent: animationController,
                                                  curve: Curves.linear));

                                          animationSettings.rotationAnimation =
                                              TweenSequence<double>(
                                            <TweenSequenceItem<double>>[
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin: 0, end: 0)
                                                    .chain(CurveTween(
                                                        curve: Curves.linear)),
                                                weight: 65.0,
                                              ),
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin: 0,
                                                        end:
                                                            pi / rotationAmount)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                                weight: 25.0,
                                              ),
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin:
                                                            pi / rotationAmount,
                                                        end: -pi /
                                                            rotationAmount)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                                weight: 50.0,
                                              ),
                                              TweenSequenceItem<double>(
                                                tween: Tween<double>(
                                                        begin: -pi /
                                                            rotationAmount,
                                                        end: 0)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                                weight: 25.0,
                                              ),
                                            ],
                                          ).animate(CurvedAnimation(
                                                  parent: animationController,
                                                  curve: Curves.linear));

                                          return animationSettings;
                                        }),
                                    child: const Icon(
                                      LucideIcons.calendarCheck,
                                      size: 48,
                                    ))))),
                    Expanded(
                        child: WidgetAnimator(
                            incomingEffect: WidgetTransitionEffects(
                                blur: const Offset(4, 0),
                                offset: const Offset(250, 0),
                                delay: const Duration(milliseconds: 900),
                                curve: Curves.decelerate),
                            outgoingEffect: WidgetTransitionEffects(
                                blur: const Offset(4, 0),
                                offset: const Offset(250, 0),
                                delay: const Duration(milliseconds: 900),
                                curve: Curves.easeIn),
                            child: Container(
                                key: const ValueKey('h'),
                                height: 195,
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.surfaceVariant,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(4))),
                                child: WidgetAnimator(
                                    incomingEffect: WidgetTransitionEffects
                                        .incomingSlideInFromBottom(
                                            duration:
                                                const Duration(seconds: 3),
                                            delay: const Duration(seconds: 2)),
                                    atRestEffect: WidgetRestingEffects.size(
                                        effectStrength: 1),
                                    child: const Icon(
                                      LucideIcons.checkCircle,
                                      size: 48,
                                    ))))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
