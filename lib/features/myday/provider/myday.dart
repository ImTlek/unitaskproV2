import 'package:unitaskpro/model/list.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:unitaskpro/provider/section.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<TaskModel> getMydayTasks(WidgetRef ref) {
  var read = ref.read(sectionProvider.notifier);


  Map<dynamic, ListModel> datas = read.data;

  List<TaskModel> myDayTasks = datas.values
      .expand((listModel) => listModel.tasks)
      .where((task) => task.isMyDay)
      .toList();

  return myDayTasks;
}
