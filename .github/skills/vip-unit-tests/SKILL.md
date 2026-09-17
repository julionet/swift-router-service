---
name: vip-unit-tests
description: "Cria classes de testes unitários Swift para arquitetura VIP no projeto iOS. Use quando: criar InteractorTests, PresenterTests, ViewControllerTests, WorkerTests, Spies ou Mocks para um novo módulo VIP; adicionar cobertura de testes a módulo existente; gerar boilerplate de testes VIP conforme o padrão do projeto."
argument-hint: "Nome do módulo e camada a testar (ex: 'PixPayment Interactor' ou 'Summary todos os arquivos')"
---

# Skill: Criação de Testes Unitários VIP

Gera classes de testes unitários Swift seguindo o padrão estabelecido no projeto iOS com arquitetura VIP.

## Quando Usar

- Criar testes para um módulo novo
- Adicionar testes a um módulo existente sem cobertura
- Gerar Spies ou Mocks para dependências de um módulo

## Procedure

### Passo 1 — Identificar o Módulo

1. Localize o módulo na pasta de produção (ex: `App/Modules/{Module}/`)
2. Identifique os protocolos: `{Module}BusinessLogic`, `{Module}PresentationLogic`, `{Module}DisplayLogic`, `{Module}RoutingLogic`, `{Module}DataPassing`, `{Module}WorkerLogic`
3. Mapeie todos os métodos de cada protocolo
4. Confirme se existe `{Module}Interactor`, `{Module}Presenter`, `{Module}ViewController`, `{Module}Worker`

### Passo 2 — Confirmar Destino

Crie os arquivos em:
```
AppTests/Modules/{Path}/{Module}/
├── {Module}InteractorTests.swift
├── {Module}PresenterTests.swift
├── {Module}ViewControllerTests.swift
├── {Module}WorkerTests.swift        (somente se existir Worker)
├── Spies/
│   ├── {Module}InteractorTestsSpy.swift
│   ├── {Module}PresenterTestsSpy.swift
│   └── {Module}ViewControllerTestsSpy.swift
└── Mocks/
    └── {Module}WorkerMock.swift      (somente se existir Worker)
```

### Passo 3 — Gerar os Arquivos

Use os templates abaixo como base. Leia os templates completos em:
- [InteractorTests](./templates/InteractorTests.swift)
- [PresenterTests](./templates/PresenterTests.swift)
- [ViewControllerTests](./templates/ViewControllerTests.swift)
- [WorkerTests](./templates/WorkerTests.swift)
- [InteractorTestsSpy](./templates/InteractorTestsSpy.swift)
- [PresenterTestsSpy](./templates/PresenterTestsSpy.swift)
- [ViewControllerTestsSpy](./templates/ViewControllerTestsSpy.swift)
- [WorkerMock](./templates/WorkerMock.swift)

### Passo 4 — Substituir Placeholders

Substitua nos templates:
| Placeholder | Valor |
|-------------|-------|
| `{Module}` | Nome do módulo (ex: `PixPayment`) |
| `{module}` | Nome em camelCase (ex: `pixPayment`) |
| `{Author}` | Nome do desenvolvedor |
| `{Year}` | Ano atual |
| `{MethodN}` | Métodos reais do protocolo |
| `{ParamType}` | Tipo real do parâmetro |
| `{ResponseType}` | Tipo real da resposta |

### Passo 5 — Validar

- Confirme que todos os métodos dos protocolos foram incluídos nos Spies
- Cada método do protocolo deve ter uma variável `{method}Called = false` e implementação que seta para `true`
- Verifique os imports necessários (`DSKit`, `BDPix`, `PromiseKit`, etc.)

## Regras do Projeto

1. **Spies são extensões da classe de teste** — O arquivo `Spies/{Module}InteractorTestsSpy.swift` contém `extension {Module}InteractorTests { class ... }`
2. **RouterSpy herda de NSObject** e implementa dois protocolos: `{Module}RoutingLogic` e `{Module}DataPassing`
3. **WorkerMock usa PromiseKit** — `isSuccess: Bool = true` controla sucesso/falha
4. **setUp e tearDown** — `setUp` inicializa tudo e chama `setupSut()`. `tearDown` seta tudo como `nil`
5. **Padrão Given/When/Then** — Use comentários `// Given:`, `// When:`, `// Then:`
6. **Imports** — Sempre `@testable import App`. Adicione outros conforme necessário
7. **APIServiceLogicMock** — Para WorkerTests, use `apiServiceMock.fetchResponse` para sucesso e `apiServiceMock.fetchError` para falha

## Exemplos de Referência no Projeto

- **InteractorTests completo:** `AppTests/Modules/Home/Summary/SummaryInteractorTests.swift`
- **PresenterTests completo:** `AppTests/Modules/Home/Summary/SummaryPresenterTests.swift`
- **ViewControllerTests completo:** `AppTests/Modules/Home/Summary/SummaryViewControllerTests.swift`
- **WorkerTests com async:** `AppTests/Modules/Home/Summary/NotificationCenter/SummaryNotificationCenterWorkerTests.swift`
- **WorkerMock com PromiseKit:** `AppTests/Modules/Home/Summary/Mocks/SummaryWorkerMock.swift`
- **Spy Interactor (extensão):** `AppTests/Modules/Home/Summary/Spies/SummaryInteractorTestsSpy.swift`
- **Spy Presenter (extensão):** `AppTests/Modules/Home/Summary/Spies/SummaryPresenterTestsSpy.swift`
- **Spy ViewController (extensão):** `AppTests/Modules/Home/Summary/Spies/SummaryViewControllerTestsSpy.swift`
- **Spy top-level (independente):** `AppTests/Modules/Home/Spies/ActivationFlowPresentationLogicSpy.swift`
