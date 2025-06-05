# 📝 Flutter ToDo App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Status](https://img.shields.io/badge/Status-Finalizado-success)
![License](https://img.shields.io/badge/License-MIT-green)
![Tested](https://img.shields.io/badge/Testes-Unit%C3%A1rio%20ok-informational)

> Aplicativo Flutter moderno para gerenciamento de tarefas com foco em produtividade, persistência local e arquitetura escalável.

---

## ✨ Funcionalidades

- ✅ Criar novas tarefas com título, descrição e prioridade
- ✏️ Editar tarefas já cadastradas
- ☑️ Marcar como concluída ou pendente
- 🔍 Filtrar tarefas por status: **Todas**, **Pendentes** ou **Concluídas**
- 🗑️ Apagar individualmente (long press)
- 🚨 Limpar todas com confirmação
- 💾 Persistência local com `SharedPreferences`
- 🎯 Interface responsiva com Material Design 3
- 🧪 Testes unitários em `ViewModel`

---

## 🧱 Arquitetura

Camadas bem definidas, baseadas no case study oficial da Flutter:

```
lib/
├── data/         # Repositórios e modelos (camada de dados)
├── domain/       # Entidades e contratos (camada de domínio)
├── presentation/ # Telas, widgets e ViewModel (camada de UI)
└── core/         # Helpers reutilizáveis (se necessário)
```

🔗 Referência: [Flutter App Architecture Case Study](https://docs.flutter.dev/app-architecture/case-study)

---

## 🛠️ Tecnologias utilizadas

| Tecnologia           | Uso principal                         |
|----------------------|----------------------------------------|
| Flutter              | Framework UI multiplataforma           |
| Provider             | Gerenciamento de estado                |
| SharedPreferences    | Persistência local (JSON)              |
| flutter_test         | Testes unitários                       |
| Dart                 | Linguagem de programação               |

---

## ▶️ Como executar o projeto

### 💻 Windows Desktop
```bash
flutter run -d windows
```

### 📱 Android
```bash
flutter run -d <dispositivo ou emulador>
```

---

## 🧪 Testes

Teste unitário incluído para o `TaskViewModel` utilizando um repositório fake:

```bash
flutter test
```

Arquivo:  
```
test/viewmodels/task_viewmodel_test.dart
```

---

## 📌 Objetivo do projeto

Este aplicativo foi desenvolvido com foco em:

- 🧼 Código limpo e organizado
- 📐 Arquitetura desacoplada e escalável
- 🧠 Aplicação prática de boas práticas Flutter
- 📊 Apresentação acadêmica com testes e persistência

---

## 👨‍💻 Autor

**Leonardo Telles**  

---

## ⚖️ Licença

Distribuído sob licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.
