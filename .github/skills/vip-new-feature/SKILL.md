---
name: vip-new-feature
description: "Cria a estrutura básica de arquivos Swift para uma nova cena/feature usando arquitetura VIP no projeto iOS, a partir de templates. Use quando: iniciar o desenvolvimento de uma nova cena VIP; gerar o boilerplate (Interactor, Presenter, ViewController, Router, Worker, Models, View, Resources e, opcionalmente, Providers) de um novo módulo."
argument-hint: "Nome da feature, pasta de destino e se deseja a pasta Providers (ex: 'CardBlockConfirmation em App/Modules/Card, sem Providers')"
---

# Skill: Criação de Estrutura Básica VIP (Novo Feature/Cena)

Gera os arquivos básicos de uma nova cena Swift seguindo o padrão VIP do projeto iOS, tendo como referência o módulo `App/Modules/Profile/ProductClosings/ClosingAccount/ClosingAccountConfirmation`.

## Quando Usar

- Iniciar o desenvolvimento de uma nova feature/cena com arquitetura VIP
- Gerar o boilerplate padrão (sem lógica de negócio específica) para acelerar o início de um módulo

## Regras Importantes

1. **Nunca invente informação.** Se houver qualquer dúvida (nome da feature, pasta de destino, necessidade da pasta `Providers`, ou se a pasta de destino já existir/tiver conflito), **pergunte ao usuário** antes de prosseguir.
2. **Gere somente os arquivos definidos pelo template** — nada de arquivos extras (sem Analytics, sem testes, sem SceneDelegate, etc.), apenas o código base necessário para começar a implementação.
3. A pasta `Providers/` só deve ser criada se o usuário confirmar explicitamente que deseja acesso a API/rede nesta cena.
4. A pasta gerada para os arquivos deve ter exatamente o nome da feature (PascalCase).

## Procedure

### Passo 1 — Obter o Nome da Feature

- Se o nome da feature já foi informado no pedido do usuário, use-o.
- Caso contrário, **pergunte** o nome da feature (ex: `CardBlockConfirmation`).
- Garanta que o nome esteja em PascalCase (ex: `cardBlockConfirmation` → `CardBlockConfirmation`). Se houver ambiguidade na formatação, confirme com o usuário antes de prosseguir.
- Esse nome será usado como `{Feature}` em todos os templates e como nome da pasta da feature.

### Passo 2 — Obter a Pasta de Destino

- **Pergunte** ao usuário em qual pasta a feature deve ser salva (ex: `App/Modules/Card/CardBlock`).
- Não assuma um caminho padrão. Se o usuário não souber, mostre a estrutura de `App/Modules/` (via listagem de diretório) para ajudá-lo a escolher.
- Verifique se já existe uma pasta com o nome da feature no destino informado. Se existir, **avise o usuário e pergunte** como proceder (sobrescrever, escolher outro nome, cancelar) — nunca sobrescreva automaticamente.

### Passo 3 — Perguntar sobre a Pasta `Providers`

- **Pergunte** ao usuário: "Deseja criar a pasta `Providers` com um Provider de API para esta feature?"
- Essa resposta controla **apenas** a criação do arquivo `Providers/{Feature}Provider.swift` (a partir do template `Provider.swift`).
- Se **sim**: crie `Providers/{Feature}Provider.swift`.
- Se **não**: não crie a pasta `Providers`.
- Em ambos os casos, o `{Feature}Worker.swift` é sempre gerado a partir do único template `Worker.swift` (que contém, em comentário, um exemplo de como integrar com o Provider caso ele tenha sido criado).

### Passo 4 — Determinar Autor e Data

- Autor: tente obter com `git config user.name` no terminal. Se não for possível obter, pergunte ao usuário.
- Data: use a data atual no formato `dd/MM/yy` (mesmo padrão usado nos arquivos existentes do projeto).

### Passo 5 — Gerar a Estrutura de Arquivos

Crie a pasta `{Destino}/{Feature}/` com a seguinte estrutura fixa:

```
{Feature}/
├── {Feature}Interactor.swift        ← templates/Interactor.swift
├── {Feature}Models.swift            ← templates/Models.swift
├── {Feature}Presenter.swift         ← templates/Presenter.swift
├── {Feature}Router.swift            ← templates/Router.swift
├── {Feature}ViewController.swift    ← templates/ViewController.swift
├── {Feature}Worker.swift            ← templates/Worker.swift
├── Resources/
│   ├── {Feature}.strings            ← templates/Strings.strings
│   └── {Feature}Keys.swift          ← templates/Keys.swift
├── Views/
│   └── {Feature}View.swift          ← templates/View.swift
└── Providers/                       ← somente se confirmado no Passo 3
    └── {Feature}Provider.swift      ← templates/Provider.swift
```

Leia o conteúdo de cada template na pasta [templates](./templates) e crie o arquivo correspondente no destino, substituindo os placeholders.

### Passo 6 — Substituir Placeholders

| Placeholder | Valor |
|-------------|-------|
| `{Feature}` | Nome da feature em PascalCase (ex: `CardBlockConfirmation`) |
| `{Author}` | Nome obtido via `git config user.name` ou informado pelo usuário |
| `{Date}` | Data atual no formato `dd/MM/yy` |

### Passo 7 — Confirmar com o Usuário

- Liste os arquivos criados e o caminho final.
- Informe se a pasta `Providers` foi criada ou não, conforme a resposta do usuário no Passo 3.

## Estrutura de Referência (Módulo Real)

O módulo usado como modelo para estes templates é:
`App/Modules/Profile/ProductClosings/ClosingAccount/ClosingAccountConfirmation/`

Ele contém: `Interactor`, `Models`, `Presenter`, `Router`, `ViewController`, `Worker`, `Providers/`, `Resources/` (`.strings` + `Keys.swift`) e `Views/`. Os templates desta skill seguem a mesma nomenclatura, imports e organização (`// MARK: -`), mas somente com o código base necessário — sem lógica de negócio específica.

## O Que NÃO Fazer

- Não criar arquivos de Analytics, testes unitários ou Mocks — isso é escopo de outras skills (ex: `vip-unit-tests`).
- Não criar a pasta `Providers` sem confirmação explícita do usuário.
- Não escolher a pasta de destino por conta própria.
- Não preencher os templates com lógica de negócio fictícia — apenas os comentários `// TODO:` indicando onde o desenvolvedor deve completar.
