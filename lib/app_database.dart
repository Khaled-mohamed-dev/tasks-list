import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get taskText => text()();

  TextColumn get priority => text()();

  DateTimeColumn get date => dateTime()();

  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
}



LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
    tables: [Tasks],
    daos: [TasksDao])
class MyDataBase extends _$MyDataBase {
  MyDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<MyDataBase>
    with _$TasksDaoMixin {
  final MyDataBase db;

  TasksDao(this.db) : super(db);

  Stream<List<Task>> watchTasks() => select(tasks).watch();

  Future<List<Task>> getTasks() => select(tasks).get();


  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);

  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);

  Future updateTask(Task task) => (update(tasks).replace(task));
}

