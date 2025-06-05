import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/viewmodels/task_viewmodel.dart';
import 'package:uuid/uuid.dart';

/// Widget que exibe um modal (BottomSheet) para criar ou editar uma tarefa.
/// Se uma tarefa existente for passada, os campos vêm preenchidos.
class AddTaskBottomSheet extends StatefulWidget {
  final Task? existingTask;

  const AddTaskBottomSheet({super.key, this.existingTask});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos de título e descrição.
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  // Armazena a prioridade da tarefa.
  late TaskPriority _priority;

  @override
  void initState() {
    super.initState();

    // Se estivermos editando, preenche os campos com os dados da tarefa.
    final task = widget.existingTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');
    _priority = task?.priority ?? TaskPriority.media;
  }

  /// Envia o formulário. Se for edição, atualiza. Senão, adiciona uma nova tarefa.
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.existingTask != null;

      final task = Task(
        id: widget.existingTask?.id ?? const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _priority,
        completed: widget.existingTask?.completed ?? false,
      );

      final viewModel = Provider.of<TaskViewModel>(context, listen: false);
      if (isEditing) {
        viewModel.updateTask(task);
      } else {
        viewModel.addTask(task);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingTask != null;

    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título do modal: "Nova Tarefa" ou "Editar Tarefa"
              Text(
                isEditing ? 'Editar Tarefa' : 'Nova Tarefa',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Campo: Título
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite um título' : null,
              ),
              const SizedBox(height: 12),

              // Campo: Descrição
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              // Dropdown: Prioridade
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Prioridade',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFF1E1E1E),
                ),
                onChanged: (value) => setState(() => _priority = value!),
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.name.toUpperCase()),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Botão: Salvar ou Atualizar
              ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(isEditing ? Icons.save : Icons.check),
                label: Text(isEditing ? 'Salvar Alterações' : 'Salvar Tarefa'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
