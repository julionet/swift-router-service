# Guia de análise VIP (Swift)

Como mapear um módulo iOS com arquitetura VIP. Os nomes variam por projeto: confirme as convenções reais lendo 2 ou 3 cenas antes de generalizar.

## 1. Inventário inicial

- Liste a árvore de pastas até 3 níveis e conte arquivos `.swift` por pasta.
- Leia `*.podspec`, `Podfile`, `Package.swift`, `project.yml`, `Info.plist` (versão, deployment target, dependências, fontes e recursos).
- Identifique o ponto de entrada público do módulo (classes `public`/`open`, bridge, configuração, factory, router de entrada).
- Identifique pastas de recursos: strings localizadas (`.strings`), assets, `Keys` de localização.

## 2. Anatomia de uma cena VIP

Para cada cena (normalmente uma pasta com os arquivos abaixo), extraia:

| Componente | O que registrar |
|---|---|
| ViewController | Responsabilidade, ciclo de vida, outlets/ações do usuário, chamadas ao Interactor, protocolo de display |
| Interactor | Casos de uso, regras de negócio, estado interno, dependência de Workers, `DataStore` |
| Presenter | Transformação Response para ViewModel, formatação, textos e chaves de localização |
| Router | Destinos de navegação, passagem de dados (`DataPassing`), tipo de apresentação (push/modal) |
| Worker / Provider | Chamadas de rede ou serviços, protocolos, tratamento de erro |
| Models | `Request`, `Response`, `ViewModel` de cada caso de uso |
| Configurator / Factory | Como as peças são ligadas e como a cena é criada |

Registre também:
- Entrada: quem abre a cena e com quais parâmetros.
- Saída: para onde navega, com que dados.
- Estados: loading, sucesso, erro, vazio.
- Analytics disparados.
- Feature flags / remote config que afetam a cena.

## 3. Fluxos entre cenas

Agrupe cenas em fluxos de negócio (por exemplo, pagamento por chave, por QR Code, dashboard, extrato). Para cada fluxo, produza um `flowchart` das cenas e um `sequenceDiagram` do caminho principal (ViewController, Interactor, Worker, Presenter).

## 4. Camadas transversais

- **Network:** cliente base, workers, logica de requisição, mapeamento de erros, endpoints (método, caminho, request, response), autenticação. Não documente URLs de ambiente nem tokens.
- **Configuration:** bridge com o app host, configuração injetada, remote config, feature flags.
- **Analytics:** eventos, parâmetros, onde são disparados.
- **Commons:** componentes reutilizáveis (views, view controllers base, modais), modelos compartilhados, utilitários.
- **Extensions e Utils:** apenas o que tem relevância para entender o módulo.
- **TransactionalModule / integração com app host:** contratos expostos ao app principal.
- **Testes:** estrutura de `Tests`, mocks disponíveis, convenções, o que cada mock simula.

## 5. Técnicas de busca

- Cenas: busque `*Interactor.swift`, `*Presenter.swift`, `*Router.swift`, `*ViewController.swift`, `*Models.swift`, `*Worker.swift`.
- Protocolos: `protocol .*Logic`, `protocol .*DisplayLogic`, `protocol .*DataStore`, `protocol .*RoutingLogic`.
- Dependências: `^import ` agrupado por módulo.
- Navegação: `navigate`, `present`, `push`, deep links, route identifiers.
- Analytics: nomes de eventos e chamadas ao serviço de analytics.
- Strings: arquivos `*Keys.swift` e `.strings`.

## 6. Qualidade

- Prefira ler o código a inferir pelo nome.
- Ao encontrar código morto, TODO, FIXME ou inconsistências, registre em `docs/open-points.md`.
- Dependências sem fonte local: documente apenas o uso no módulo e marque como "fonte não fornecida".
