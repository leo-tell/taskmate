# 📋 ToDo App — Gerenciador de Tarefas em Flutter

Este é um aplicativo Flutter desenvolvido como trabalho avaliativo, que permite ao usuário **criar, editar, concluir, filtrar e excluir tarefas**, com **persistência local** utilizando `SharedPreferences`.

---

## 🎯 Funcionalidades

- ✅ Adicionar novas tarefas com título, descrição e prioridade
- ✏️ Editar tarefas existentes
- 🟢 Marcar tarefas como concluídas
- 🗂️ Filtrar tarefas por status: Todas | Pendentes | Concluídas
- 🗑️ Apagar uma tarefa por toque longo
- 🚨 Limpar todas as tarefas com confirmação
- 💾 Persistência local com `SharedPreferences`
- 🧠 Arquitetura em camadas (UI, ViewModel, Repository, Domain)
- ⚙️ Gerenciamento de estado com `Provider`
- ✅ Teste unitário para `TaskViewModel`

---

## 📂 Estrutura de Pastas

```
lib/
├── core/                # Widgets genéricos (opcional)
├── data/                # Modelos e repositórios
│   ├── models/
│   └── repositories/
├── domain/              # Entidades e interfaces (contratos)
│   ├── entities/
│   └── repositories/
├── presentation/        # UI, páginas, widgets e ViewModel
│   ├── pages/
│   ├── widgets/
│   └── viewmodels/
└── injection/           # (opcional) Configuração de dependências
```

---

## 🧪 Testes

O projeto possui teste unitário para validar a lógica de negócio do ViewModel:

```bash
flutter test
```

---

## ▶️ Como rodar o app

### 💻 Windows Desktop:
```bash
flutter run -d windows
```

### 📱 Android:
```bash
flutter run -d <emulador ou dispositivo>
```

---

## ✍️ Tecnologias utilizadas

- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)
- Dart
- Material Design 3


## 👨‍💻 Autor

Desenvolvido por **Leonardo Telles**
