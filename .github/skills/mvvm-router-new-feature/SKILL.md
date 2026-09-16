---
name: mvvm-router-new-feature
description: "Cria a estrutura básica de arquivos Swift para uma nova cena/feature usando a arquitetura MVVM + RouterService, a partir de templates. Use quando: iniciar o desenvolvimento de uma nova cena; gerar o boilerplate (Feature, Handler, ViewModel, ViewController, Model, DataStore, Route, Resources e, opcionalmente, Worker/Provider) de um novo módulo do pod PaymentGateway."
argument-hint: "Nome da feature e se ela faz chamada de API (ex: 'PaymentSummary, com Worker/Provider')"
---

# Skill: Criação de Estrutura Básica MVVM + RouterService (Novo Feature/Cena)

Gera os arquivos básicos de uma nova cena Swift seguindo o padrão **MVVM orientado a cena, com navegação via `RouterService`** usado no pod `PaymentGateway`, tendo como referência o módulo `PaymentGateway/Classes/PaymentChoice`.

Esta NÃO é a arquitetura VIP/Clean Swift (ver skills `vip-*`). Consulte [architecture-reference.md](./architecture-reference.md) para o detalhamento completo do padrão real observado no código.

## Quando Usar

- Iniciar o desenvolvimento de uma nova feature/cena dentro do pod `PaymentGateway`
- Gerar o boilerplate padrão (sem lógica de negócio específica) para acelerar o início de um módulo

## Regras Importantes

1. **Nunca invente informação.** Se houver qualquer dúvida (nome da feature, se ela faz chamada de API, nomes de campos de negócio, endpoint, etc.), **pergunte ao usuário** antes de prosseguir.
2. **Gere somente os arquivos definidos pelo template** — nada de Analytics ou testes unitários, apenas o código base necessário para começar a implementação. `{Feature}View.swift` é sempre gerado (a `ViewController` instancia e usa `screenView` via `loadView()`).
3. A pasta `Provider/` e o arquivo `{Feature}Worker.swift` só devem ser criados se o usuário confirmar explicitamente que a cena precisa fazer chamada de API.
4. `{Feature}DataStore.swift` e `{Feature}Route.swift` **sempre** vão para o pod `PaymentGatewayInterface` (público), seguindo o padrão de `PaymentChoice` — mesmo que a cena só seja navegada internamente. Isso foi confirmado com o time como o padrão a seguir.
5. O `{Feature}Handler` deve **sempre** ser registrado automaticamente em `Example/Example/ModulesRegistration/PaymentGatewayRegistration.swift`.
6. A pasta gerada para os arquivos deve ter exatamente o nome da feature (PascalCase).

## Procedure

### Passo 1 — Obter o Nome da Feature

- Se o nome já foi informado no pedido do usuário, use-o.
- Caso contrário, **pergunte** o nome da feature (ex: `PaymentSummary`).
- Garanta PascalCase. Se houver ambiguidade, confirme com o usuário antes de prosseguir.
- Esse nome será usado como `{Feature}` em todos os templates, no nome da pasta e no `tableName` do `Localizable`.

### Passo 2 — Perguntar sobre Chamada de API (Worker/Provider)

- **Pergunte** ao usuário: "Esta cena precisa chamar uma API (Worker + Provider)?"
- Se **sim**:
  - Crie `Implementation/{Feature}Worker.swift` (template `Worker.swift`), `Implementation/{Feature}Contract.swift` (template `Contract.swift`) e `Provider/{Feature}Provider.swift` (template `Provider.swift`).
  - `{Feature}Contract.swift` contém `{Feature}Request` e `{Feature}Response` juntos, com campos vazios e `// TODO:` — nunca invente os campos de negócio, apenas o esqueleto.
  - `{Feature}Feature.swift` e `{Feature}ViewModel.swift` incluem a integração com o Worker.
- Se **não**:
  - Não crie `Provider/` nem `{Feature}Worker.swift`.
  - Gere `{Feature}Feature.swift` e `{Feature}ViewModel.swift` sem o parâmetro `worker` (remova as linhas correspondentes dos templates ao gerar os arquivos).

### Passo 3 — Determinar Autor e Data

- Autor: tente obter com `git config user.name` no terminal. Se não for possível, pergunte ao usuário.
- Data: use a data atual no formato `dd/MM/yy` (mesmo padrão usado nos arquivos existentes do projeto).

### Passo 4 — Gerar a Estrutura de Arquivos

Crie a seguinte estrutura fixa (dentro do workspace já existente, não crie um novo pod):

```
PaymentGateway/Classes/{Feature}/
├── Implementation/
│   ├── {Feature}Feature.swift        ← templates/Feature.swift
│   ├── {Feature}Handler.swift        ← templates/Handler.swift
│   ├── {Feature}Model.swift          ← templates/Model.swift
│   ├── {Feature}View.swift           ← templates/View.swift
│   ├── {Feature}ViewController.swift ← templates/ViewController.swift
│   ├── {Feature}ViewModel.swift      ← templates/ViewModel.swift
│   ├── {Feature}Worker.swift         ← templates/Worker.swift (somente se Passo 2 = sim)
│   └── {Feature}Contract.swift       ← templates/Contract.swift (somente se Passo 2 = sim; {Feature}Request + {Feature}Response)
├── Provider/                         ← somente se Passo 2 = sim
│   └── {Feature}Provider.swift       ← templates/Provider.swift
└── Resources/
    ├── {Feature}.strings             ← templates/Strings.strings
    └── {Feature}Keys.swift           ← templates/Keys.swift

PaymentGatewayInterface/Classes/
├── Model/{Feature}DataStore.swift    ← templates/DataStore.swift
└── Route/{Feature}Route.swift        ← templates/Route.swift
```

Leia o conteúdo de cada template na pasta [templates](./templates) e crie o arquivo correspondente no destino, substituindo os placeholders. Não é necessário editar os `.podspec` — ambos usam `source_files = 'Classes/**/*'`.

### Passo 5 — Substituir Placeholders

| Placeholder | Valor |
|-------------|-------|
| `{Feature}` | Nome da feature em PascalCase (ex: `PaymentSummary`) |
| `{Author}` | Nome obtido via `git config user.name` ou informado pelo usuário |
| `{Date}` | Data atual no formato `dd/MM/yy` |

### Passo 6 — Registrar o Handler

Edite `Example/Example/ModulesRegistration/PaymentGatewayRegistration.swift` e adicione a nova linha dentro de `makePaymentGateway`, seguindo o padrão já existente:

```swift
extension DependencyInjection.RouteHandlerFactory {
    public static func makePaymentGateway(with routerService: RouterService) {
        routerService.register(routeHandler: PaymentChoiceHandler())
        routerService.register(routeHandler: PaymentTypeSelectorHandler())
        routerService.register(routeHandler: PaymentPersonalLoanValidationHandler())
        routerService.register(routeHandler: {Feature}Handler()) // nova linha
    }
}
```

### Passo 7 — Confirmar com o Usuário

- Liste os arquivos criados e o caminho final.
- Informe se `Worker`/`Provider`/`Contract` foram criados ou não.
- Lembre o usuário de preencher os campos de `{Feature}Request`/`{Feature}Response` em `{Feature}Contract.swift`, se aplicável (Passo 2) — a skill só gera o esqueleto vazio.
- Lembre que a navegação para/desta cena (métodos `routeTo...` nos `ViewController`s envolvidos) precisa ser implementada manualmente — o template só cria o placeholder de navegação.

## Estrutura de Referência (Módulo Real)

O módulo usado como modelo para estes templates é `PaymentGateway/Classes/PaymentChoice` (o mais completo: possui `Worker`, `Provider` e `DataStore`/`Route` públicos no pod `PaymentGatewayInterface`). Para uma variação mais simples (sem Worker), veja `PaymentGateway/Classes/PaymentTypeSelector`.

Consulte [architecture-reference.md](./architecture-reference.md) para o detalhamento de cada camada, com base em código real do repositório.

## O Que NÃO Fazer

- Não criar arquivos de Analytics — não faz parte deste padrão de scaffolding (algumas cenas do projeto têm `Analytics/`, outras não; a skill não gera essa pasta).
- Não criar pasta `Views/` compartilhada própria — componentes reaproveitáveis entre features continuam em `PaymentGateway/Classes/Views/`; `{Feature}View.swift` é a view exclusiva desta cena e sempre fica dentro de `Implementation/`.
- Não criar `Provider`/`Worker`/`Contract` sem confirmação explícita do usuário.
- Não inventar campos de `DataStore`, `{Feature}Request`/`{Feature}Response` (em `{Feature}Contract.swift`) ou lógica de negócio — apenas comentários `// TODO:` indicando onde o desenvolvedor deve completar.
- Não esquecer de registrar o `Handler` em `PaymentGatewayRegistration.swift`.
