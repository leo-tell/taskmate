import 'package:flutter/material.dart';
import 'package:todo_app/data/repositories/mock_task_repository.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';

/// ViewModel responsável por controlar o estado da lista de tarefas
/// e intermediar a comunicação entre a camada de dados (Repository)
/// e a interface (UI). Utiliza ChangeNotifier para atualizar os widgets via Provider.
class TaskViewModel extends ChangeNotifier {
  /// Repositório de tarefas, injetável para testes.
  final TaskRepository _repository;

  /// Permite injetar outro repositório.
  /// Se nenhum for passado, usa o padrão `MockTaskRepository`.
  TaskViewModel({TaskRepository? repository})
      : _repository = repository ?? MockTaskRepository();

  /// Lista completa de tarefas (sem filtro).
  List<Task> _allTasks = [];

  /// Filtro atual aplicado na UI (todas, pendentes, concluídas).
  TaskFilter _filter = TaskFilter.todas;

  /// Getter que aplica o filtro sobre a lista de tarefas.
  List<Task> get tasks {
    switch (_filter) {
      case TaskFilter.pendentes:
        return _allTasks.where((t) => !t.completed).toList();
      case TaskFilter.concluidas:
        return _allTasks.where((t) => t.completed).toList();
      case TaskFilter.todas:
      default:
        return _allTasks;
    }
  }

  /// Retorna o filtro atual.
  TaskFilter get filter => _filter;

  /// Atualiza o filtro e notifica a UI.
  void setFilter(TaskFilter newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  /// Carrega todas as tarefas do repositório para a lista `_allTasks`.
  /// Chamada ao iniciar a tela ou após qualquer alteração.
  Future<void> loadTasks() async {
    _allTasks = await _repository.getTasks();
    notifyListeners();
  }

  /// Adiciona uma nova tarefa e recarrega a lista.
  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
    await loadTasks();
  }

  /// Remove uma tarefa pelo ID e recarrega a lista.
  Future<void> removeTask(String id) async {
    await _repository.removeTask(id);
    await loadTasks();
  }

  /// Alterna o status de conclusão da tarefa e recarrega.
  Future<void> toggleTaskCompletion(String id) async {
    await _repository.toggleTaskCompletion(id);
    await loadTasks();
  }

  /// Remove todas as tarefas e recarrega.
  Future<void> clearAllTasks() async {
    await _repository.clearAllTasks();
    await loadTasks();
  }

  /// Atualiza uma tarefa existente e recarrega.
  Future<void> updateTask(Task updatedTask) async {
    await _repository.updateTask(updatedTask);
    await loadTasks();
  }
}
