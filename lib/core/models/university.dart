import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class University {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String location;
  @HiveField(3)
  String description;
  @HiveField(4)
  int rate;
  @HiveField(5)
  List<String> pros;
  @HiveField(6)
  List<String> cons;
  @HiveField(7)
  String specialization;
  @HiveField(8)
  String priority;
  @HiveField(9)
  int tuition;
  @HiveField(10)
  int studyYears;

  University({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.rate,
    required this.pros,
    required this.cons,
    required this.specialization,
    required this.priority,
    required this.tuition,
    required this.studyYears,
  });
}

class UniversityAdapter extends TypeAdapter<University> {
  @override
  final typeId = 0;

  @override
  University read(BinaryReader reader) {
    return University(
      id: reader.read(),
      name: reader.read(),
      location: reader.read(),
      description: reader.read(),
      rate: reader.read(),
      pros: reader.read(),
      cons: reader.read(),
      specialization: reader.read(),
      priority: reader.read(),
      tuition: reader.read(),
      studyYears: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, University obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.location);
    writer.write(obj.description);
    writer.write(obj.rate);
    writer.write(obj.pros);
    writer.write(obj.cons);
    writer.write(obj.specialization);
    writer.write(obj.priority);
    writer.write(obj.tuition);
    writer.write(obj.studyYears);
  }
}
