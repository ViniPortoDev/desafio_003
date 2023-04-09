import 'package:app/repositories/task_repositories.dart';
import 'package:app/service/prefs_service.dart';
import 'package:app/states/task_state.dart';
import 'package:flutter/material.dart';

import '../src/models/task_model.dart';

class TaskStore extends ValueNotifier<TaskState> {
  final List<TaskModel> _tasks = [];
  final TaskDataBaseRepository _taskRepository =
      TaskDataBaseRepository(PrefsLocalStorageService());
  TaskStore() : super(TaskInitialState());

  Future loadTasks() async {
    value = TaskLoadingState();
    await Future.delayed(const Duration(seconds: 1));
    try {
      final taskLoad = await _taskRepository.loadTask();
      _tasks.addAll(taskLoad);
      value = TaskSucessState(taskLoad);
    } catch (e) {
      value = TaskErrorState(e.toString());
    }
  }

  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
    final orderedTaskList = _sortList(_tasks);
    await _taskRepository.saveTask(orderedTaskList);
    value = TaskSucessState(_tasks);
  }

  Future<void> completeTask({
    required int index,
    required bool isDone,
  }) async {
    final status = !isDone;
    final taskModel = _tasks[index].copyWith(isDone: status);
    _tasks[index] = taskModel;
    await _taskRepository.saveTask(_tasks);
    value = TaskSucessState(_tasks);
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
    await _taskRepository.saveTask(_tasks);
    value = TaskSucessState(_tasks);
  }

  List<TaskModel> _sortList(List<TaskModel> list) {
    if (list.length >= 2) {
      list.sort((TaskModel a, TaskModel b) {
        return a.date.compareTo(b.date);
      });
      return list;
    }
    return list;
  }

  Color overdueTask(DateTime date) {
    if (date.compareTo(DateTime.now()) == -1) {
      return Colors.red;
    }
    return Colors.white;
  }

  String dateAndTime(DateTime date) {
    final dateAndTime =
        '${date.day}/${date.month}/${date.year}\n${date.hour}:${date.minute}';
    return dateAndTime;
  }
}
