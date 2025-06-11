// Importações principais do Flutter e de pacotes usados no projeto
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Gerenciador de estado
import 'package:todo_app/injection/injection.dart'; // Setup de injeção de dependência
import 'package:todo_app/presentation/pages/home_page.dart'; // Tela principal
import 'package:todo_app/presentation/viewmodels/task_viewmodel.dart'; // ViewModel que gerencia o estado das tarefas

// Função principal que inicia o app
void main() {
  setupInjection(); // Configura a injeção de dependência usando o get_it
  runApp(const MyApp()); // Inicia o app com o widget raiz
}

// Widget principal do app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Injeta o TaskViewModel usando get_it (injeção de dependência)
        ChangeNotifierProvider(create: (_) => getIt<TaskViewModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove a faixa "debug" do canto da tela
        title: 'ToDo App',
        theme: ThemeData(
          useMaterial3: true, // Ativa o Material 3
          brightness: Brightness.dark, // Define o tema escuro
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal, // Cor base para o tema
            brightness: Brightness.dark,
          ),
          // Define o estilo de texto usado no app
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 16),
          ),
          // Estilo global para a AppBar
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        home: const HomePage(), // Define a tela inicial do app
      ),
    );
  }
}
