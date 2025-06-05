import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/viewmodels/task_viewmodel.dart';
import '../fakes/fake_task_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TaskViewModel Test', () {
    late TaskViewModel viewModel;

    setUp(() {
      viewModel = TaskViewModel(repository: FakeTaskRepository());
    });

    test('Adiciona uma tarefa e recupera corretamente', () async {
      final task = Task(
        id: '1',
        title: 'Teste de tarefa',
        description: 'Descrição da tarefa',
        priority: TaskPriority.media,
      );

      await viewModel.addTask(task);
      expect(viewModel.tasks.length, 1);
      expect(viewModel.tasks.first.title, 'Teste de tarefa');
    });
  });
}
