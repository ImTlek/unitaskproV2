import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

@immutable
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  static IconData get icon => LucideIcons.calendarDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          heroTag: 'f',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScheduleDetailPage()));
          },
          child: const Icon(LucideIcons.plus),
        ),
        body: CustomScrollView(
          slivers: [
            SlieverAppBar(title: context.local.tSchedule),
            const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: ScheduleList(itemCount: 20)),
            const SliverToBoxAdapter(child: verticalMargin32)
          ],
        ));
  }
}

class ScheduleList extends StatefulWidget {
  final int itemCount; // Number of random items to generate

  const ScheduleList({super.key, required this.itemCount});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  late List<EventModel> items;

  @override
  void initState() {
    super.initState();
    items = generateRandomItems(widget.itemCount);
  }

  List<EventModel> generateRandomItems(int count) {
    final random = Random();
    final titles = [
      'Meeting with Team A',
      'Coffee Break',
      'Presentation Review',
      'Lunch Break',
      'Gym Session',
      'Client Call',
    ];
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];

    return List.generate(count, (index) {
      final hour = random.nextInt(24);
      final minute = random.nextInt(60);
      final time =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
      return EventModel(
        title: titles[random.nextInt(titles.length)],
        time: time,
        color: colors[random.nextInt(colors.length)],
        columnIndex: 0, // Assuming initial column index is 0 (adjust if needed)
        rowIndex: index, // Each item gets its own row index
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: item.color ??
                Colors.white, // Use color if provided in EventModel
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  color: Colors.grey.withOpacity(0.2))
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  item.time ?? "", // Display empty string if time is null
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? "", // Display empty string if title is null
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ScheduleDetailPage extends StatefulWidget {
  const ScheduleDetailPage({super.key});

  @override
  State<ScheduleDetailPage> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetailPage> {
  late final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);

    List<EventModel> eventList = [
      EventModel(
        title: "Math",
        columnIndex:
            0, // columnIndex is columnTitle's index (Monday : 0 or Day 1 : 0)
        rowIndex: 2, // rowIndex is rowTitle's index (08:00 : 0 or Time 1 : 0)
        color: Colors.orange,
      ),
      EventModel(
        title: "History",
        columnIndex: 1,
        rowIndex: 5,
        color: Colors.pink,
      ),
      EventModel(
        title: "Guitar & Piano Course",
        columnIndex: 4,
        rowIndex: 8,
        color: Colors.green,
      ),
      EventModel(
        title: "Meeting",
        columnIndex: 3,
        rowIndex: 1,
        color: Colors.deepPurple,
      ),
      EventModel(
        title: "Guitar and Piano Course",
        columnIndex: 2,
        rowIndex: 9,
        color: Colors.blue,
      )
    ];
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Event Schedule",
      ),
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   useMaterial3: false,
      // ),
      body: TimeSchedulerTable(
        cellHeight: 72,
        cellWidth: 72,

        columnTitles: const [
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun"
        ], // columnTitles is growable : you can add as much as you want
        // columnTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
        // currentColumnTitleIndex: 2,      --> if currentColumnTitleIndex is 2 then selected day is 3.
        currentColumnTitleIndex: DateTime.now().weekday - 1,
        rowTitles: const [
          '08:00 - 09:00',
          '09:00 - 10:00',
          '10:00 - 11:00',
          '11:00 - 12:00',
          '12:00 - 13:00',
          '13:00 - 14:00',
          '14:00 - 15:00',
          '15:00 - 16:00',
          '16:00 - 17:00',
          '17:00 - 18:00',
          '18:00 - 19:00',
          '19:00 - 20:00',
          '20:00 - 21:00',
        ],
        // You can assign any value to rowTitles. For Example : ['1','2','3']

        // titleStyle: const TextStyle(
        //     fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        // eventTitleStyle: const TextStyle(color: Colors.white, fontSize: 8),
        isBack: false, // back button
        eventList: eventList,
        scrollColor: Colors.deepOrange.withOpacity(0.7),
        isScrollTrackingVisible: true,
        eventAlert: EventAlert(
          alertTextController: textController,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          addAlertTitle: "Add Event",
          editAlertTitle: "Edit",
          addButtonTitle: "ADD",
          deleteButtonTitle: "DELETE",
          updateButtonTitle: "UPDATE",
          hintText: "Event Name",
          textFieldEmptyValidateMessage: "Cannot be empty!",
          addOnPressed: (event) {}, // when an event added to your list
          updateOnPressed: (event) {}, // when an event updated from your list
          deleteOnPressed: (event) {}, // when an event deleted from your list
        ),
      ),
    );
  }
}
