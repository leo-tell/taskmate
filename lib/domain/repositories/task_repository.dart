import '../entities/task.dart';

/// Interface (contrato) que define as operações esperadas para o repositório de tarefas.
///
/// Essa abstração permite que a aplicação use diferentes implementações
/// (por exemplo, uma local com SharedPreferences ou uma futura com API).
abstract class TaskRepository {
  /// Retorna a lista de tarefas armazenadas.
  Future<List<Task>> getTasks();

  /// Adiciona uma nova tarefa ao repositório.
  Future<void> addTask(Task task);

  /// Remove uma tarefa com base no seu ID.
  Future<void> removeTask(String id);

  /// Alterna o status de conclusão da tarefa (true ↔ false).
  Future<void> toggleTaskCompletion(String id);

  /// Remove todas as tarefas do repositório.
  Future<void> clearAllTasks();

  /// Atualiza os dados de uma tarefa existente.
  Future<void> updateTask(Task task);
}
