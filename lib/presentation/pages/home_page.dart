import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/viewmodels/task_viewmodel.dart';
import 'package:todo_app/presentation/widgets/add_task_bottom_sheet.dart';

/// Página principal que exibe a lista de tarefas, com opções de filtro,
/// adicionar, editar, marcar como concluída e limpar tudo.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Carrega as tarefas ao iniciar a página.
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).loadTasks();
  }

  /// Retorna uma cor associada à prioridade da tarefa.
  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.baixa:
        return Colors.green;
      case TaskPriority.media:
        return Colors.orange;
      case TaskPriority.alta:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskViewModel>();
    final tasks = viewModel.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [
          /// Menu de opções com botão para "Limpar tudo"
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'limpar') {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Limpar todas as tarefas?'),
                    content: const Text('Esta ação não pode ser desfeita.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          viewModel.clearAllTasks();
                          Navigator.pop(context);
                        },
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'limpar',
                child: Text('Limpar tudo'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            /// Dropdown para filtrar tarefas (todas, pendentes, concluídas)
            DropdownButton<TaskFilter>(
              value: viewModel.filter,
              onChanged: (value) {
                if (value != null) {
                  viewModel.setFilter(value);
                }
              },
              items: TaskFilter.values.map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter.name.toUpperCase()),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            /// Lista de tarefas ou mensagem de vazio
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma tarefa encontrada',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),

                            /// Indicador de cor baseado na prioridade
                            leading: Container(
                              width: 10,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: _getPriorityColor(task.priority),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),

                            /// Título e estilo baseado na conclusão
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: task.completed
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(task.description),

                            /// Checkbox para marcar como concluída
                            trailing: Checkbox(
                              value: task.completed,
                              onChanged: (_) {
                                viewModel.toggleTaskCompletion(task.id);
                              },
                            ),

                            /// Tocar para editar
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) =>
                                    AddTaskBottomSheet(existingTask: task),
                              );
                            },

                            /// Segurar para remover
                            onLongPress: () {
                              viewModel.removeTask(task.id);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      /// Botão flutuante para adicionar nova tarefa
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskBottomSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
