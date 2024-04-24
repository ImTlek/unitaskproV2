import 'package:flutter/material.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:firebase_auth/firebase_auth.dart';

String getGreeting(String locale) {
  // Map containing greetings for different languages
  Map<String, Map<String, String>> greetings = {
    'kk': {
      'morning': 'Қайырлы таң',
      'afternoon': 'Қайырлы күн',
      'evening': 'Қайырлы кеш',
    },
    'ru': {
      'morning': 'Доброе утро',
      'afternoon': 'Добрый день',
      'evening': 'Добрый вечер',
    },
    'en': {
      'morning': 'Good morning',
      'afternoon': 'Good afternoon',
      'evening': 'Good evening',
    },
  };

  // Get the language part from the locale
  String languageCode = locale.split('_').first.toLowerCase();

  // Get the current time
  DateTime now = DateTime.now();
  int hour = now.hour;

  // Determine the part of the day
  String partOfDay = 'afternoon';
  if (hour < 12) {
    partOfDay = 'morning';
  } else if (hour < 18) {
    partOfDay = 'afternoon';
  } else {
    partOfDay = 'evening';
  }

  // Get the greeting message based on the language and time of the day
  String greeting =
      greetings[languageCode]?[partOfDay] ?? greetings['en']![partOfDay] ?? '';

  return greeting;
}

class GreetingText extends StatelessWidget {
  final String name;
  final Locale locale;

  const GreetingText({super.key, required this.name, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${getGreeting(context.local.localeName)} ',
          style: const TextStyle(
            fontSize: 16.0,
            // color: Colors.white,
          ),
        ),
        Text(
          '${FirebaseAuth.instance.currentUser?.email}',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.normal,
              fontSize: 16),
        ),
        const Text(
          ' !',
          style: TextStyle(
              // color: Colors.white,
              ),
        ),
      ],
    );
  }
}
