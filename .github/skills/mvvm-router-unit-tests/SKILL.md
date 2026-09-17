---
name: mvvm-router-unit-tests
description: "Cria classes de testes unitários Swift para a arquitetura MVVM + RouterService do pod PaymentGateway (iOS). Use quando: criar ViewModelTests, ViewControllerTests, WorkerTests, Spies ou Mocks para uma cena existente; adicionar cobertura de testes a um módulo MVVM já criado."
argument-hint: "Nome da feature e camada a testar (ex: 'PaymentChoice ViewModel' ou 'PaymentTypeSelector todos os arquivos')"
---

# Skill: Criação de Testes Unitários — MVVM + RouterService

Gera classes de teste seguindo o padrão MVVM + RouterService do pod `PaymentGateway`.

## ⚠️ Aviso Importante — Infraestrutura de Testes Não Confirmada

Ao analisar o repositório, **não foi encontrado nenhum teste unitário real** para as
cenas de `PaymentGateway/Classes/` (`PaymentChoice`, `PaymentTypeSelector`,
`PaymentErrorHandler`, `PaymentValidation`). O único arquivo de teste do repositório é
`Example/Tests/Tests.swift`, que é um placeholder padrão de template CocoaPods
(`import NewFeature`, um módulo que não existe neste projeto) e não segue o padrão MVVM.

Além disso, `Example/project.yml` declara o target `ExampleTests` com
`sources: ExampleTests`, mas a pasta real no repositório se chama `Example/Tests/` —
uma inconsistência que **não deve ser corrigida por conta própria**.

**Por isso, antes de gerar qualquer arquivo, esta skill deve perguntar ao usuário:**

1. Em qual target/pasta os testes devem ser criados (ex: `ExampleTests`, um novo pod de
   testes, um target próprio dentro do podspec de `PaymentGateway`)?
2. Qual o nome do módulo a ser usado em `@testable import {Module}` (provavelmente
   `PaymentGateway`, mas depende de como o target de teste está configurado)?
3. Se esse target de teste ainda não existir, o usuário precisa criá-lo/configurá-lo
   manualmente (via `project.yml`/Xcode) — esta skill **não configura targets de
   build**, apenas gera arquivos `.swift`.

Nunca assuma essas respostas. Se o usuário não souber, apresente as opções acima e peça
para verificar com o time antes de prosseguir.

## Quando Usar

- Criar testes para uma cena MVVM já existente (`{Feature}ViewModel`, `{Feature}Worker`, `{Feature}ViewController`)
- Adicionar cobertura de testes a uma cena sem testes

## Procedure

### Passo 1 — Confirmar Infraestrutura de Testes

Siga o aviso acima. Só prossiga depois de ter: destino dos arquivos e nome do módulo para `@testable import`.

### Passo 2 — Identificar a Feature e suas Camadas

1. Localize a cena em `PaymentGateway/Classes/{Feature}/Implementation/`
2. Identifique os protocolos reais: `{Feature}ViewModelService`, `{Feature}ViewModelNotification` e, se existir, `{Feature}WorkerLogic`
3. Liste **todos** os métodos desses protocolos (não invente métodos que não existem no código)
4. Confirme se existe `{Feature}Worker` (nem toda cena tem)

### Passo 3 — Gerar os Arquivos

Com o destino confirmado no Passo 1, gere:

```
{DestinoConfirmado}/{Feature}/
├── {Feature}ViewModelTests.swift      ← templates/ViewModelTests.swift
├── {Feature}ViewControllerTests.swift ← templates/ViewControllerTests.swift
├── {Feature}WorkerTests.swift         ← templates/WorkerTests.swift (somente se existir Worker)
├── Spies/
│   ├── {Feature}ViewModelNotificationSpy.swift ← templates/ViewModelNotificationSpy.swift
│   └── {Feature}ViewModelServiceSpy.swift      ← templates/ViewModelServiceSpy.swift
└── Mocks/
    └── {Feature}WorkerMock.swift        ← templates/WorkerMock.swift (somente se existir Worker)
```

Leia os templates completos em [templates](./templates) antes de gerar os arquivos, e adapte cada método de teste aos métodos reais dos protocolos identificados no Passo 2 (nunca gere testes para métodos que não existem).

### Passo 4 — Substituir Placeholders

| Placeholder | Valor |
|-------------|-------|
| `{Feature}` | Nome da feature (ex: `PaymentChoice`) |
| `{Module}` | Módulo confirmado no Passo 1 para `@testable import` |
| `{Author}` | Nome do desenvolvedor (`git config user.name` ou perguntar) |
| `{Date}` | Data atual (`dd/MM/yy`) |
| `{Method}` | Métodos reais dos protocolos identificados no Passo 2 |

### Passo 5 — Validar

- Todo método de `{Feature}ViewModelService` tem um teste correspondente no `ViewModelTests`
- Todo método de `{Feature}ViewModelNotification` tem uma flag `{method}Called` no Spy
- `{Feature}WorkerMock` implementa `{Feature}WorkerLogic` usando `Promise` (PromiseKit), com controle de sucesso/falha (`isSuccess`)
- `setUp` instancia o `sut` com os spies/mocks injetados via `init`; `tearDown` zera tudo

## Regras do Projeto (observadas no código de produção)

1. `{Feature}ViewModel` recebe `notification` (delegate) e `worker` via `init` — os testes devem injetar spies/mocks nesses mesmos parâmetros.
2. Chamadas assíncronas usam `PromiseKit` (`.done`/`.catch`) — use `expectation(description:)` + `wait(for:timeout:)` nos testes de `ViewModel`/`Worker`.
3. `dataStore` é uma propriedade `var` setada **depois** do `init` (assim como faz `{Feature}Feature`) — configure o `dataStore` do `sut` explicitamente em cada teste que precisar dele.
4. Analytics (`tapViewEvent`/`screenViewEvent` ou `{Feature}Events`) não tem teste dedicado nas cenas observadas — só gere testes de Analytics se o usuário pedir explicitamente.
5. Padrão Given/When/Then com comentários explícitos, como no restante do projeto (ver `vip-unit-tests`).

## O Que NÃO Fazer

- Não presumir o target/módulo de teste — sempre confirme com o usuário (ver aviso no topo).
- Não "consertar" a inconsistência entre `project.yml` e a pasta `Example/Tests/` sem que o usuário peça.
- Não gerar testes para métodos que não existem nos protocolos reais da feature.
- Não gerar testes de Analytics ou de Handler/Feature (registro de rotas) — fora do escopo desta skill.
