---
name: mvvm-router-code-review
description: "Code review de funcionalidades iOS usando a arquitetura MVVM + RouterService do pod PaymentGateway iOS. Use para revisar novas cenas/módulos, verificar conformidade com Feature/Handler/ViewModel/ViewController/Worker, DataStore/Route, registro de rotas e convenções do projeto."
argument-hint: "Caminho ou nome da feature a revisar (ex: PaymentGateway/Classes/PaymentSummary)"
---

# Code Review — MVVM + RouterService (PaymentGateway)

## Quando Usar Esta Skill

- Revisar uma nova cena/módulo criado com o padrão MVVM + RouterService deste pod
- Verificar se os padrões observados em `PaymentChoice`/`PaymentTypeSelector`/`PaymentValidation` foram seguidos
- Avaliar qualidade e consistência antes de abrir PR

Esta arquitetura **não é VIP/Clean Swift** — use as skills `vip-*` apenas se o módulo revisado realmente seguir aquele outro padrão.

---

## 1. Estrutura de Arquivos Esperada

```
PaymentGateway/Classes/{Feature}/
├── Implementation/
│   ├── {Feature}Feature.swift
│   ├── {Feature}Handler.swift
│   ├── {Feature}Model.swift
│   ├── {Feature}ViewController.swift
│   ├── {Feature}ViewModel.swift
│   └── {Feature}Worker.swift        (somente se a cena chama API)
├── Provider/                        (somente se houver Worker)
│   └── {Feature}Provider.swift
├── Analytics/                       (opcional — nem toda cena tem)
│   └── {Feature}Events(+...).swift
└── Resources/
    ├── {Feature}.strings
    └── {Feature}Keys.swift

PaymentGatewayInterface/Classes/
├── Model/{Feature}DataStore.swift
└── Route/{Feature}Route.swift
```

**Verifique:**
- [ ] Todos os arquivos obrigatórios existem e seguem `{Feature} + Componente.swift`
- [ ] `Provider/` só existe se houver `{Feature}Worker.swift`
- [ ] `DataStore`/`Route` existem (localmente em `{Feature}/Interface/` ou em `PaymentGatewayInterface`, dependendo se a cena precisa ser navegável de fora do pod)

---

## 2. Checklist por Arquivo

### `{Feature}Route.swift` / `{Feature}DataStore.swift`
```swift
public struct {Feature}DataStore {
    public let compositionData: PaymentGatewayDataProvider?
    public init(compositionData: PaymentGatewayDataProvider? = nil) { ... }
}

public struct {Feature}Route: Route {
    public static let identifier: String = String(describing: Self.self)
    public let dataStore: {Feature}DataStore
    public init(dataStore: {Feature}DataStore) { self.dataStore = dataStore }
}
```
- [ ] `DataStore` é `struct` imutável (`let`), com `init` público explícito
- [ ] `DataStore` carrega **apenas** o necessário para a próxima cena (nada de estado de UI)
- [ ] `Route.identifier` usa `String(describing: Self.self)` (não hardcoded)
- [ ] Se a cena é usada fora do pod (ex: pelo app Example), `Route`/`DataStore` são `public` e vivem em `PaymentGatewayInterface`

### `{Feature}Handler.swift`
```swift
public final class {Feature}Handler: RouteHandler {
    public var routes: [Route.Type] = [{Feature}Route.self]
    public init() {}
    public func destination(forRoute route: Route) -> Feature.Type {
        guard route is {Feature}Route else { preconditionFailure() }
        return {Feature}Feature.self
    }
}
```
- [ ] `public final class`, `init()` público e vazio
- [ ] `destination(forRoute:)` faz `guard`/`preconditionFailure()` em vez de force cast
- [ ] **Handler está registrado** em `Example/Example/ModulesRegistration/PaymentGatewayRegistration.swift` (`routerService.register(routeHandler:)`) — gap conhecido no projeto: `PaymentErrorHandler` não está registrado; não deixe isso se repetir em código novo

### `{Feature}Feature.swift`
```swift
final class {Feature}Feature: Feature {
    @Dependency var routerService: RouterServiceProtocol
    @Dependency var apiService: (APIServiceLogic & APIServiceData) // se houver Worker

    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? {Feature}Route else { preconditionFailure() }
        ...
    }
}
```
- [ ] Dependências resolvidas via `@Dependency`, nunca via `init` manual/singletons acessados direto no `build`
- [ ] `guard let route = route as? {Feature}Route else { preconditionFailure() }` presente
- [ ] `viewController.modalPresentationStyle` definido quando relevante
- [ ] `dataStore` do `Route` é atribuído ao `ViewModel` **após** a construção (propriedade `var`)

### `{Feature}Model.swift`
```swift
struct {Feature}Model {
    struct SceneModel: PaymentGatewayModel { ... }
}
```
- [ ] `SceneModel` conforma `PaymentGatewayModel`
- [ ] Não contém lógica, apenas dados para exibição

### `{Feature}ViewModel.swift`
```swift
protocol {Feature}ViewModelNotification: AnyObject { func didUpdate() ... }
protocol {Feature}ViewModelService { func fetchValues(); var dataStore: {Feature}DataStore? { get } ... }

final class {Feature}ViewModel: {Feature}ViewModelService {
    weak var notification: {Feature}ViewModelNotification?
    public var dataStore: {Feature}DataStore?
    var worker: {Feature}WorkerLogic?
    ...
}
```
- [ ] `notification` é `weak var` (evita retain cycle com a View)
- [ ] `{Feature}ViewModelNotification` herda de `AnyObject`
- [ ] Toda dependência externa (`Worker`, `RemoteConfig`, `StorageService`) é injetada via `init`, com valor padrão quando aplicável (ex: `remoteConfig: GtwRemoteConfigProtocol? = GtwRemoteConfig(...)`)
- [ ] Chamadas ao `Worker` usam `.done`/`.catch` (PromiseKit) e nunca bloqueiam a thread principal
- [ ] Erros são tratados via `PaymentUtils.extractError(error:)` (ou padrão equivalente) e repassados via `notification?.handleError(...)`
- [ ] Eventos de Analytics (quando existentes) são disparados aqui, nunca na `ViewController`/`Feature`/`Handler`
- [ ] `final class` (a menos que precise ser subclasse)

### `{Feature}ViewController.swift`
```swift
final class {Feature}ViewController: UIViewController {
    private let routerService: RouterServiceProtocol?
    var viewModel: {Feature}ViewModelService?
    ...
}
```
- [ ] `routerService` é `private let`, injetado via `init(routerService:)`, com `init?(coder:)` setando `nil`
- [ ] Não contém regra de negócio — apenas monta UI e delega ao `viewModel`
- [ ] Métodos de navegação (`routeTo...`) constroem o próximo `Route`/`DataStore` e chamam `routerService?.navigate(toRoute:fromView:presentationStyle:animated:)`
- [ ] `PresentationStyle` escolhido é coerente com o fluxo (`Push()`, `Present(modalPresentationStyle:)`, `ReplaceLast()`)
- [ ] Implementa a extensão `{Feature}ViewModelNotification` para reagir a callbacks
- [ ] Reaproveita views compartilhadas de `Classes/Views/` quando possível, em vez de duplicar UI
- [ ] `// MARK: -` usados para separar seções (Router Service, View Model, Views, Lifecycle, Layout Functions, Navigation)

### `{Feature}Worker.swift` (se existir)
```swift
protocol {Feature}WorkerLogic { func fetchData(params: Request) -> Promise<Response> }
final class {Feature}Worker: {Feature}WorkerLogic {
    let apiService: APIServiceLogic
    init(apiService: APIServiceLogic) { self.apiService = apiService }
}
```
- [ ] Protocolo `{Feature}WorkerLogic` definido para permitir mock em testes
- [ ] `apiService` injetado via `init` (sem singleton acessado direto dentro do método)
- [ ] Retorna `Promise<Response>` (PromiseKit), sem `async/await` misturado sem necessidade
- [ ] Não faz parsing/validação de negócio — apenas a chamada de rede

### `{Feature}Provider.swift` (se existir)
```swift
final class {Feature}Provider: RequestProvider {
    var httpMethod: RequestHTTPMethod { .get }
    var path: String { "/api--.../..." }
    ...
}
```
- [ ] `path` não tem valores sensíveis hardcoded (tokens, IDs de ambiente)
- [ ] `headers`/body usam apenas os campos do `Request`, sem dados não solicitados

### `Resources/{Feature}Keys.swift`
- [ ] `enum Localized: String, Localizable` com `tableName` igual ao nome do `.strings`
- [ ] Strings de UI usam as chaves (`{Feature}Keys.Localized.xxx.string()`), nunca hardcoded na `ViewController`/`ViewModel`

---

## 3. Segurança (OWASP Mobile)

**Verifique:**
- [ ] Dados sensíveis (CPF, valores, tokens) não são logados via `print()`
- [ ] Dados sensíveis (conta, documento) obtidos via `Storage`/Keychain (`Storage?.fetchKeychain(...)`), nunca de `UserDefaults` puro
- [ ] `DataStore` carrega apenas o necessário para a navegação — sem dados sensíveis além do essencial
- [ ] Nenhum "force unwrap" (`!`) sem justificativa; prefira `guard let`/`if let` como no restante do projeto
- [ ] Requisições passam por `BDServiceProviderInterface`/`APIServiceLogic` (nenhuma URLSession direta)

---

## 4. Convenções Gerais do Projeto

**Verifique:**
- [ ] `final class` para `Feature`, `ViewModel`, `ViewController`, `Worker` (quando não precisam de subclasse)
- [ ] `// MARK: -` para organizar seções
- [ ] Imports organizados (frameworks externos primeiro, módulos internos depois)
- [ ] Nenhuma lógica de negócio na `Feature`/`Handler` (eles só constroem e roteiam)
- [ ] `Analytics/` (quando presente) segue o padrão `enum {Feature}Events: PaymentGatewayAnalyticsProtocol` com `EventsModel` por estado (`Base`/`Loading`/`Error`/`Success`)

---

## 5. Checklist Final de PR

### Arquitetura
- [ ] Estrutura de arquivos completa (`Feature`, `Handler`, `ViewModel`, `ViewController`, `Model`, `DataStore`, `Route`, e `Worker`/`Provider` se aplicável)
- [ ] `Handler` registrado em `PaymentGatewayRegistration.swift`
- [ ] `DataStore` com apenas os dados necessários para passagem entre cenas
- [ ] Navegação feita via `routerService?.navigate(toRoute:fromView:presentationStyle:animated:)`

### Qualidade de Código
- [ ] Sem force unwrap desnecessário
- [ ] Sem `print()` em produção
- [ ] `weak var notification` no ViewModel
- [ ] `final class` onde aplicável
- [ ] MARK sections presentes

### Testes (se aplicável — ver skill `mvvm-router-unit-tests`)
- [ ] ViewModel testado (todos os métodos públicos do `{Feature}ViewModelService`)
- [ ] Worker testado, se existir
- [ ] Spies/Mocks implementam os protocolos corretos

### Segurança
- [ ] Sem dados sensíveis em logs
- [ ] Armazenamento sensível via `Storage` (Keychain)
- [ ] Sem dados desnecessários no `DataStore`
