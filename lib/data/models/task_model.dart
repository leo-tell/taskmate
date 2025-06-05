import 'package:todo_app/domain/entities/task.dart';

/// Modelo que representa uma Tarefa serializável.
/// Estende a entidade `Task` e adiciona suporte para conversão
/// de e para Map, necessário para persistência com SharedPreferences.
class TaskModel extends Task {
  /// Construtor que herda todos os campos da entidade base `Task`.
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.priority,
    super.completed = false,
  });

  /// Construtor de fábrica que cria um `TaskModel` a partir de um Map.
  /// Usado na leitura de dados salvos com SharedPreferences.
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: TaskPriority.values[map['priority']],
      completed: map['completed'],
    );
  }

  /// Converte o objeto `TaskModel` em Map<String, dynamic>.
  /// Necessário para salvar os dados com SharedPreferences.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.index,
      'completed': completed,
    };
  }
}
