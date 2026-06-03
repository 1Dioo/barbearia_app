# Barbearia App

## Sobre o Projeto

O Barbearia App é um aplicativo mobile desenvolvido em Flutter com o objetivo de modernizar o processo de atendimento em uma barbearia, oferecendo uma experiência digital prática, intuitiva e organizada para clientes e administradores.

Este projeto foi desenvolvido como atividade acadêmica proposta pelo professor da disciplina, tendo como finalidade aplicar conceitos de desenvolvimento mobile, organização de projetos, experiência do usuário (UX/UI), persistência de dados e boas práticas de programação.

---

## Objetivos

O principal objetivo do aplicativo é permitir que clientes possam interagir com a barbearia de forma digital, realizando ações como:

* Criar uma conta.
* Realizar login.
* Editar informações pessoais.
* Adicionar foto de perfil.
* Visualizar promoções.
* Conhecer serviços oferecidos.
* Realizar agendamentos.
* Acompanhar benefícios e planos de assinatura.

Além disso, o projeto busca demonstrar conhecimentos em desenvolvimento utilizando Flutter e Dart, seguindo uma arquitetura organizada e escalável.

---

## Tecnologias Utilizadas

### Framework

* Flutter

### Linguagem

* Dart

### Persistência Local

* SharedPreferences

### Bibliotecas Utilizadas

* image_picker
* shared_preferences
* google_fonts

---

## Funcionalidades Implementadas

### Sistema de Autenticação

* Cadastro de usuários.
* Login de usuários.
* Logout.
* Armazenamento local das informações.

### Perfil do Usuário

* Visualização de dados pessoais.
* Alteração de nome.
* Alteração de telefone.
* Upload de foto de perfil.
* Persistência da imagem após fechar o aplicativo.

### Sistema de Promoções

* Exibição de banners promocionais.
* Interface preparada para futuras campanhas.
* Destaques visuais para ofertas especiais.

### Agendamento

* Seleção de serviços.
* Escolha de data.
* Escolha de horário.
* Histórico local de agendamentos.

### Clube de Assinaturas

* Exibição de plano ativo.
* Área dedicada para benefícios.
* Estrutura preparada para futuras expansões.

### Interface Moderna

* Design responsivo.
* Tema escuro personalizado.
* Tipografia personalizada com Google Fonts.
* Componentes reutilizáveis.
* Navegação intuitiva.

---

## Estrutura do Projeto

```text
lib/
│
├── core/
│   ├── app_brand.dart
│   └── app_theme.dart
│
├── models/
│   ├── app_user.dart
│   ├── promo_model.dart
│   └── appointment_model.dart
│
├── services/
│   ├── auth_storage.dart
│   ├── appointment_storage.dart
│   └── subscription_storage.dart
│
├── screens/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   ├── appointments/
│   └── subscription/
│
├── widgets/
│   ├── primary_action_button.dart
│   ├── stat_card.dart
│   └── custom_widgets.dart
│
└── main.dart
```

---

## Como Executar o Projeto

### Instalar Dependências

```bash
flutter pub get
```

### Executar em Modo Debug

```bash
flutter run
```

### Gerar APK

```bash
flutter build apk --release
```

O arquivo APK será gerado em:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## Possíveis Melhorias Futuras

* Integração com Firebase.
* Banco de dados online.
* Sistema de notificações.
* Pagamentos integrados.
* Área administrativa.
* Avaliação de serviços.
* Programa de fidelidade.
* Chat entre cliente e barbeiro.
* Agendamento em tempo real.

---

## Aprendizados Obtidos

Durante o desenvolvimento deste projeto foram trabalhados conceitos importantes de:

* Desenvolvimento Mobile.
* Flutter e Dart.
* Organização de código.
* Persistência de dados.
* Gerenciamento de estado.
* Design de interfaces.
* Experiência do usuário (UX/UI).
* Estruturação de projetos escaláveis.

---

## Equipe

Projeto desenvolvido para fins acadêmicos como atividade prática da disciplina de desenvolvimento de software, com foco em aplicação mobile utilizando Flutter.

---

## Licença

Este projeto possui finalidade exclusivamente educacional e acadêmica.
