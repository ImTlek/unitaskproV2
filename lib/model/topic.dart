import 'model.dart';

class TopicModel {
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<TaskModel> messages;
  final ConfigModel configModel;

  TopicModel(
      {required this.name,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.messages,
      required this.configModel});

  TopicModel copyWith(
      {String? name,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TaskModel>? messages,
      ConfigModel? configModel}) {
    return TopicModel(
        name: name ?? this.name,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        messages: messages ?? this.messages,
        configModel: configModel ?? this.configModel);
  }
}
