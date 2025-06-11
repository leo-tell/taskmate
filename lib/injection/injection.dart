import 'package:get_it/get_it.dart';
import 'package:todo_app/data/repositories/mock_task_repository.dart';
import 'package:todo_app/domain/repositories/task_repository.dart';
import 'package:todo_app/presentation/viewmodels/task_viewmodel.dart';

// Cria a instância global do get_it, usada para registrar e recuperar dependências
final getIt = GetIt.instance;

// Função que registra as dependências do projeto
void setupInjection() {
  // Registra o repositório de tarefas como uma instância única (singleton)
  // Isso significa que será criado apenas uma vez e reutilizado sempre que necessário
  getIt.registerLazySingleton<TaskRepository>(() => MockTaskRepository());

  // Registra o TaskViewModel como uma nova instância a cada solicitação
  // Ele recebe o repositório injetado automaticamente pelo get_it
  getIt.registerFactory<TaskViewModel>(() => TaskViewModel(repository: getIt()));
}
