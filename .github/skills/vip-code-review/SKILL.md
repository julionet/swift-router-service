---
name: vip-code-review
description: "Code review de funcionalidades iOS usando arquitetura VIP (Clean Swift). Use para revisar novas cenas/módulos, verificar conformidade com padrões do projeto App, checar protocolos, testes unitários (Spies), Analytics, Workers e DataStore."
argument-hint: "Caminho ou nome da funcionalidade a revisar (ex: App/Modules/Pix/Payment)"
---

# Code Review – Arquitetura VIP (iOS)

## Quando usar esta skill

- Revisar uma nova cena ou módulo criado com a arquitetura VIP (Clean Swift)
- Verificar se os padrões do projeto foram seguidos
- Checar testes unitários, Analytics, Workers e DataStore
- Avaliar qualidade e consistência antes de abrir PR

---

## 1. Estrutura de Arquivos Esperada

Cada cena VIP deve conter **obrigatoriamente** os seguintes arquivos, com o prefixo exato do nome da feature:

```
FeatureName/
├── FeatureNameInteractor.swift      # Lógica de negócio + DataStore
├── FeatureNamePresenter.swift       # Formatação para exibição
├── FeatureNameViewController.swift  # UI + setup VIP
├── FeatureNameRouter.swift          # Navegação + DataPassing
├── FeatureNameWorker.swift          # Acesso à API / dados externos
├── FeatureNameModels.swift          # Request / Response / ViewModel
├── Analytics/
│   └── FeatureNameAnalytics.swift   # Eventos de Analytics
└── Resources/                       # Assets locais (opcional)
```

**Verifique:**
- [ ] Todos os arquivos principais existem e seguem o padrão de nomenclatura `FeatureName + Componente.swift`
- [ ] Há uma pasta `Analytics/` com o arquivo de eventos correspondente
- [ ] Recursos como `.xib` e imagens ficam em `Resources/`

---

## 2. Protocolos VIP (Checklist por Arquivo)

### `FeatureNameInteractor.swift`
```swift
protocol FeatureNameBusinessLogic {
    func loadScreenValues()
    // ...demais actions
}

protocol FeatureNameDataStore {
    var someData: SomeType? { get set }
}

final class FeatureNameInteractor: FeatureNameBusinessLogic, FeatureNameDataStore {
    var presenter: FeatureNamePresentationLogic?
    // ...
}
```

**Verifique:**
- [ ] `FeatureNameBusinessLogic` declara todos os métodos de entrada da cena
- [ ] `FeatureNameDataStore` expõe apenas dados que precisam ser passados entre cenas
- [ ] Interactor **não importa UIKit** (exceto casos justificados)
- [ ] Dependências externas (Workers, RemoteConfig) são injetadas via `init`
- [ ] Não há lógica de UI ou de formatação no Interactor

### `FeatureNamePresenter.swift`
```swift
protocol FeatureNamePresentationLogic {
    func presentScreenValues(response: FeatureName.Model.Response)
}

class FeatureNamePresenter: FeatureNamePresentationLogic {
    weak var viewController: FeatureNameDisplayLogic?
    // ...
}
```

**Verifique:**
- [ ] `FeatureNamePresentationLogic` define métodos `present...` (nunca `display...`)
- [ ] `viewController` é `weak var` para evitar retain cycle
- [ ] Presenter converte dados do domínio em `ViewModel` antes de enviar ao ViewController
- [ ] Nenhum acesso direto a serviços externos (somente formatação)

### `FeatureNameViewController.swift`
```swift
protocol FeatureNameDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: FeatureName.Model.ViewModel)
}

class FeatureNameViewController: UIViewController, FeatureNameDisplayLogic {
    var interactor: FeatureNameBusinessLogic?
    var router: (NSObjectProtocol & FeatureNameRoutingLogic & FeatureNameDataPassing)?

    init() {
        super.init(nibName: String(describing: FeatureNameViewController.self),
                   bundle: Bundle(for: FeatureNameViewController.self))
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = FeatureNameInteractor()
        let presenter = FeatureNamePresenter()
        let router = FeatureNameRouter()

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
```

**Verifique:**
- [ ] `FeatureNameDisplayLogic` herda de `AnyObject`
- [ ] Métodos do protocolo são `display...` (nunca `present...`)
- [ ] `setup()` é chamado em **todos** os `init` (incluindo `init?(coder:)`)
- [ ] `interactor` e `router` são do tipo dos **protocolos**, não das classes concretas
- [ ] `router` combina `RoutingLogic` e `DataPassing` com `NSObjectProtocol`
- [ ] ViewController não contém lógica de negócio

### `FeatureNameRouter.swift`
```swift
protocol FeatureNameRoutingLogic {
    func routeToNextScene()
}

protocol FeatureNameDataPassing {
    var dataStore: FeatureNameDataStore? { get }
}

class FeatureNameRouter: NSObject, FeatureNameRoutingLogic, FeatureNameDataPassing {
    weak var viewController: FeatureNameViewController?
    var dataStore: FeatureNameDataStore?

    func routeToNextScene() {
        let destination = NextSceneViewController()
        var destinationDS = destination.router?.dataStore
        passData(dataSource: dataStore, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
```

**Verifique:**
- [ ] Router herda de `NSObject` (necessário para `@objc` protocols quando aplicável)
- [ ] `viewController` é `weak var`
- [ ] Navegação usa `passData` para transferência de DataStore entre cenas
- [ ] Router não executa lógica de negócio
- [ ] Prefixo de métodos é `routeTo...` ou `dismiss...`

### `FeatureNameWorker.swift`
```swift
protocol FeatureNameWorkerLogic {
    func fetchData() -> Promise<FeatureName.Model.Response>
}

class FeatureNameWorker: FeatureNameWorkerLogic {
    let apiService: APIServiceLogic

    init(apiService: APIServiceLogic = APIService.shared) {
        self.apiService = apiService
    }
}
```

**Verifique:**
- [ ] Protocolo `FeatureNameWorkerLogic` definido para permitir mock em testes
- [ ] `apiService` injetado via `init` com valor padrão (`APIService.shared`)
- [ ] Async via `Promise<T>` (PromiseKit) ou `async/await`
- [ ] Worker não acessa `UserDefaults`, `Keychain` ou estado global diretamente sem protocolo

### `FeatureNameModels.swift`
```swift
enum FeatureName {
    enum Model {
        struct Request { ... }
        struct Response { ... }
        struct ViewModel { ... }
    }
}
```

**Verifique:**
- [ ] Enum raiz é o nome da feature (sem sufixo)
- [ ] Aninhamento correto: `FeatureName.Model.ViewModel`, `FeatureName.Model.Request`
- [ ] `ViewModel` contém apenas tipos primitivos ou tipos de UI (`String`, `NSAttributedString`, `UIColor`, `UIImage`)
- [ ] `Request`/`Response` contêm tipos de domínio
- [ ] `CodingKeys` em snake_case para propriedades da API

---

## 3. Analytics

**Arquivo:** `Analytics/FeatureNameAnalytics.swift`

```swift
enum FeatureNameAnalytics {
    enum SomeAction {
        case screenView
        case buttonTap

        var event: AnalyticsEvent {
            switch self {
            case .screenView:
                return AnalyticsEvent(
                    type: .state,
                    pageName: ...,
                    subSection: ...,
                    aditionalParameters: [...]
                )
            }
        }
    }
}
```

**Verifique:**
- [ ] Cada tela nova rastreia `screenView` no `viewDidAppear` (ou via Interactor)
- [ ] Eventos de ação rastreados nos métodos corretos (via `.event.track()`)
- [ ] Analytics **não é chamado no Presenter nem no Router** (somente no Interactor ou ViewController)
- [ ] Nomes de páginas seguem o padrão existente do projeto (seção, subseção, pageVariation)

---

## 4. Testes Unitários

**Estrutura esperada em `Tests/Tests/Modules/FeatureModule/FeatureName/`:**

```
FeatureName/
├── FeatureNameInteractorTests.swift
├── FeatureNamePresenterTests.swift
├── FeatureNameViewControllerTests.swift
└── Spies/
    ├── FeatureNameBusinessLogicSpy.swift
    ├── FeatureNamePresentationLogicSpy.swift
    ├── FeatureNameDisplayLogicSpy.swift
    └── FeatureNameRoutingLogicSpy.swift
```

### Padrão de Spy
```swift
final class FeatureNamePresentationLogicSpy: FeatureNamePresentationLogic {
    var presentScreenValuesCalled = false

    func presentScreenValues(response: FeatureName.Model.Response) {
        presentScreenValuesCalled = true
    }
}
```

### Padrão de Teste
```swift
class FeatureNameInteractorTests: XCTestCase {
    private var sut: FeatureNameInteractor!
    private var spy: FeatureNamePresentationLogicSpy!

    override func setUp() {
        super.setUp()
        spy = FeatureNamePresentationLogicSpy()
        sut = FeatureNameInteractor(worker: FeatureNameWorkerMock())
        sut.presenter = spy
    }

    override func tearDown() {
        sut = nil
        spy = nil
        super.tearDown()
    }

    func testLoadScreenValues() {
        // When
        sut.loadScreenValues()
        // Then
        XCTAssertTrue(spy.presentScreenValuesCalled,
            "presentScreenValues() deveria ter sido chamado")
    }
}
```

**Verifique:**
- [ ] Existem testes para Interactor, Presenter e ViewController
- [ ] Todos os `setUp` instanciam o `sut` injetando mocks/spies
- [ ] `tearDown` nila as variáveis (`sut = nil`)
- [ ] Spies implementam os protocolos corretos e registram chamadas com flags `xxxCalled`
- [ ] Testes seguem estrutura **Given / When / Then** (comentários explícitos)
- [ ] Mensagens de asserção são descritivas (terceiro parâmetro do `XCTAssert`)
- [ ] Worker mockado via protocolo (nunca a classe concreta diretamente)
- [ ] Cobertura mínima: todos os fluxos do Interactor e do Presenter

---

## 5. Injeção de Dependências e Inicialização

**Verifique:**
- [ ] Todas as dependências externas (Worker, RemoteConfig, Repository) têm protocolo e são injetadas via `init`
- [ ] `init` com valor padrão (`= SomeService.shared`) para facilitar uso, mas com protocolo para testabilidade
- [ ] `Singleton` (`shared`) usado apenas na camada de `Worker`/`Service`, nunca no Interactor ou Presenter
- [ ] Não há referências `static` ou globais dentro do Interactor/Presenter

---

## 6. Segurança (OWASP Mobile)

**Verifique:**
- [ ] Dados sensíveis (tokens, senhas, CPF) **não são logados** com `print()` ou `Logs`
- [ ] Dados sensíveis armazenados somente via `Storage` (Keychain), nunca em `UserDefaults` simples
- [ ] Comunicação com API usa HTTPS (verificar `APIServiceProvider`)
- [ ] Nenhum dado sensível exposto em `DataStore` além do necessário para a navegação

---

## 7. Convenções Gerais do Projeto

**Verifique:**
- [ ] Arquivo de copyright no cabeçalho: `Copyright (c) YYYY. All rights reserved.`
- [ ] Imports organizados: SDK/framework imports separados dos módulos internos
- [ ] Uso de `DSKit` / `DSKitFonts` para componentes visuais (não criar UI custom sem justificativa)
- [ ] Strings de UI via localization keys (ex: `FeatureNameKeys.Localized.title.string()`)
- [ ] Nenhum `force unwrap` (`!`) sem justificativa em comentário
- [ ] `final class` para Interactor, Presenter, Worker e Router (quando não precisam ser subclassados)
- [ ] Marks (`// MARK: -`) usados para organizar seções: Architecture Objects, Init, Business Logic, etc.

---

## 8. Checklist Final de PR

Use esta lista antes de aprovar o PR:

### Arquitetura
- [ ] Estrutura de arquivos completa (Interactor, Presenter, ViewController, Router, Worker, Models)
- [ ] Protocolos VIP definidos e implementados corretamente
- [ ] `setup()` wiring completo no ViewController
- [ ] DataStore com apenas os dados necessários para passagem entre cenas
- [ ] Router usa `passData` para transferência de DataStore

### Qualidade de Código
- [ ] Sem força de unwrap (`!`) desnecessário
- [ ] Sem `print()` em produção
- [ ] `weak var` nos backreferences (viewController no Presenter/Router)
- [ ] `final class` onde aplicável
- [ ] MARK sections presentes

### Testes
- [ ] Interactor testado (todos os métodos públicos)
- [ ] Presenter testado (todos os métodos públicos)
- [ ] Spies criados para todos os protocolos
- [ ] Given/When/Then respeitado
- [ ] `setUp`/`tearDown` corretos

### Analytics
- [ ] `screenView` rastreado na abertura da tela
- [ ] Ações principais rastreadas
- [ ] Arquivo de Analytics criado na pasta correta

### Segurança
- [ ] Sem dados sensíveis em logs
- [ ] Armazenamento via Storage (Keychain)
- [ ] Sem dados desnecessários no DataStore
