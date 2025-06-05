import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';

/// Implementação simulada (mock) de um repositório de tarefas.
/// Salva os dados localmente usando SharedPreferences.
class MockTaskRepository implements TaskRepository {
  /// Chave usada para salvar os dados no SharedPreferences.
  static const _tasksKey = 'tasks';

  /// Lista de tarefas em memória, usada como cache.
  List<Task> _tasks = [];

  /// Getter para obter a instância do SharedPreferences.
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Retorna todas as tarefas salvas localmente.
  /// Caso exista um JSON salvo, ele será convertido para objetos TaskModel.
  @override
  Future<List<Task>> getTasks() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_tasksKey);

    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      _tasks = decoded.map((e) => TaskModel.fromMap(e)).toList();
    }

    return _tasks;
  }

  /// Salva a lista atual de tarefas no SharedPreferences, convertendo para JSON.
  Future<void> _saveTasks() async {
    final prefs = await _prefs;
    final jsonString = json.encode(
      _tasks.map((task) => TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        completed: task.completed,
      ).toMap()).toList(),
    );
    await prefs.setString(_tasksKey, jsonString);
  }

  /// Adiciona uma nova tarefa à lista e salva.
  @override
  Future<void> addTask(Task task) async {
    _tasks.add(TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      completed: task.completed,
    ));
    await _saveTasks();
  }

  /// Remove uma tarefa da lista pelo ID e salva a lista atualizada.
  @override
  Future<void> removeTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    await _saveTasks();
  }

  /// Alterna o status de conclusão de uma tarefa e salva.
  @override
  Future<void> toggleTaskCompletion(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        completed: !task.completed,
      );
      await _saveTasks();
    }
  }

  /// Remove todas as tarefas da lista e limpa o armazenamento local.
  @override
  Future<void> clearAllTasks() async {
    _tasks.clear();
    await _saveTasks();
  }

  /// Atualiza uma tarefa existente com novos dados e salva.
  @override
  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = TaskModel(
        id: updatedTask.id,
        title: updatedTask.title,
        description: updatedTask.description,
        priority: updatedTask.priority,
        completed: updatedTask.completed,
      );
      await _saveTasks();
    }
  }
}
