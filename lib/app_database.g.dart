// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String taskText;
  final String priority;
  final DateTime date;
  final bool isChecked;
  const Task(
      {required this.id,
      required this.taskText,
      required this.priority,
      required this.date,
      required this.isChecked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_text'] = Variable<String>(taskText);
    map['priority'] = Variable<String>(priority);
    map['date'] = Variable<DateTime>(date);
    map['is_checked'] = Variable<bool>(isChecked);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      taskText: Value(taskText),
      priority: Value(priority),
      date: Value(date),
      isChecked: Value(isChecked),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      taskText: serializer.fromJson<String>(json['taskText']),
      priority: serializer.fromJson<String>(json['priority']),
      date: serializer.fromJson<DateTime>(json['date']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskText': serializer.toJson<String>(taskText),
      'priority': serializer.toJson<String>(priority),
      'date': serializer.toJson<DateTime>(date),
      'isChecked': serializer.toJson<bool>(isChecked),
    };
  }

  Task copyWith(
          {int? id,
          String? taskText,
          String? priority,
          DateTime? date,
          bool? isChecked}) =>
      Task(
        id: id ?? this.id,
        taskText: taskText ?? this.taskText,
        priority: priority ?? this.priority,
        date: date ?? this.date,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('taskText: $taskText, ')
          ..write('priority: $priority, ')
          ..write('date: $date, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskText, priority, date, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.taskText == this.taskText &&
          other.priority == this.priority &&
          other.date == this.date &&
          other.isChecked == this.isChecked);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> taskText;
  final Value<String> priority;
  final Value<DateTime> date;
  final Value<bool> isChecked;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.taskText = const Value.absent(),
    this.priority = const Value.absent(),
    this.date = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String taskText,
    required String priority,
    required DateTime date,
    this.isChecked = const Value.absent(),
  })  : taskText = Value(taskText),
        priority = Value(priority),
        date = Value(date);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? taskText,
    Expression<String>? priority,
    Expression<DateTime>? date,
    Expression<bool>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskText != null) 'task_text': taskText,
      if (priority != null) 'priority': priority,
      if (date != null) 'date': date,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? taskText,
      Value<String>? priority,
      Value<DateTime>? date,
      Value<bool>? isChecked}) {
    return TasksCompanion(
      id: id ?? this.id,
      taskText: taskText ?? this.taskText,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskText.present) {
      map['task_text'] = Variable<String>(taskText.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('taskText: $taskText, ')
          ..write('priority: $priority, ')
          ..write('date: $date, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _taskTextMeta = const VerificationMeta('taskText');
  @override
  late final GeneratedColumn<String> taskText = GeneratedColumn<String>(
      'task_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _isCheckedMeta = const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
      'is_checked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("is_checked" IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskText, priority, date, isChecked];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_text')) {
      context.handle(_taskTextMeta,
          taskText.isAcceptableOrUnknown(data['task_text']!, _taskTextMeta));
    } else if (isInserting) {
      context.missing(_taskTextMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      taskText: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}task_text'])!,
      priority: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isChecked: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_checked'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

abstract class _$MyDataBase extends GeneratedDatabase {
  _$MyDataBase(QueryExecutor e) : super(e);
  late final $TasksTable tasks = $TasksTable(this);
  late final TasksDao tasksDao = TasksDao(this as MyDataBase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TasksDaoMixin on DatabaseAccessor<MyDataBase> {
  $TasksTable get tasks => attachedDatabase.tasks;
}
