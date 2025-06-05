/// Enum que representa os níveis de prioridade que uma tarefa pode ter.
enum TaskPriority { baixa, media, alta }

/// Enum utilizado para definir os filtros de exibição das tarefas na interface.
enum TaskFilter { todas, pendentes, concluidas }

/// Entidade principal que representa uma tarefa no sistema.
/// Essa classe faz parte da camada de domínio (domain).
class Task {
  /// Identificador único da tarefa.
  final String id;

  /// Título da tarefa (resumo ou nome).
  final String title;

  /// Descrição detalhada da tarefa.
  final String description;

  /// Prioridade da tarefa (baixa, média ou alta).
  final TaskPriority priority;

  /// Define se a tarefa já foi concluída ou não.
  final bool completed;

  /// Construtor da classe `Task`.
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.completed = false,
  });

  /// Método que retorna uma cópia da tarefa atual,
  /// permitindo alterar apenas os campos desejados.
  ///
  /// Muito útil para alterar o status `completed` ou editar dados de forma imutável.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
    );
  }
}
