# Dependências externas

Parte do código do módulo vive em outras bibliotecas. A skill descobre essas dependências, pergunta a pasta e o nível de profundidade de cada uma e as documenta em `docs/external/`.

## 1. Descoberta

1. Colete os `import` Swift do módulo (excluindo frameworks Apple: `UIKit`, `Foundation`, `SwiftUI`, `Combine`, `CoreLocation` etc.) e conte o uso por biblioteca.
2. Leia `Podfile`, `*.podspec`, `Package.swift` e `project.yml` para obter versão e origem.
3. Classifique cada dependência:
   - **Interna com fonte local:** `:path => '...'` no Podfile ou pasta conhecida.
   - **Interna/versionada sem fonte local:** pod versionado de um repositório privado.
   - **Terceiros:** bibliotecas públicas (PromiseKit, SkeletonView, Lottie etc.).
4. Mapeie, por biblioteca, quais símbolos o módulo usa (`grep` dos tipos, protocolos e funções referenciados nos arquivos que importam a biblioteca).

## 2. Pergunta de pasta e profundidade

Apresente **uma única tabela** com padrões sugeridos e peça ajustes:

| Biblioteca | Origem | Usos no módulo | Pasta sugerida | Nível sugerido |
|---|---|---|---|---|

Níveis disponíveis:

| Nível | O que fazer | Saída |
|---|---|---|
| Ignorar | Não documentar | Nada |
| Referência | Nome, versão/caminho, propósito em uma linha; não ler o código-fonte | Uma linha em `docs/external/README.md` |
| Uso no módulo (padrão) | Ler apenas os símbolos que o módulo consome e explicar contrato, comportamento e motivo do uso | `docs/external/<Lib>.md` |
| Profundo | Arquitetura da biblioteca, tipos públicos, fluxos principais, configuração e pontos de extensão | Pasta `docs/external/<Lib>/` com vários arquivos |

Padrões sugeridos:
- Terceiros: **Referência**.
- Internas com `:path` local: **Uso no módulo**.
- Sem fonte local: **Referência**.

Depois da tabela, para cada biblioteca em **Uso no módulo** ou **Profundo**, pergunte a pasta com o código (sugira o caminho do Podfile). O usuário pode responder "sem fonte"; nesse caso, rebaixe para **Referência** e registre "Fonte não fornecida".

Registre as decisões na seção "Dependências externas" de `docs/ROADMAP.md`. O usuário pode alterá-las no GATE 1.

## 3. Leitura do código externo

- **Uso no módulo:** parta dos símbolos usados no módulo e leia só as definições, protocolos e implementações relevantes. Não varra a biblioteca inteira.
- **Profundo:** mapeie a biblioteca completa. Para bibliotecas grandes, avise o usuário que a análise será mais longa, divida por subpasta com subagentes `Explore` em paralelo e consolide em `docs/external/<Lib>/`.
- Nunca copie código externo integralmente: documente interfaces e contratos.
- Se o código externo estiver fora do workspace, leia-o somente com autorização do usuário (caminho informado por ele).

## 4. Saída

Estrutura:

```
docs/external/
├── README.md              # tabela de todas as dependências, nível e links
├── <LibUso>.md            # nível "Uso no módulo"
└── <LibProfunda>/         # nível "Profundo"
    ├── README.md          # visão geral e arquitetura
    ├── public-api.md      # tipos e protocolos públicos
    ├── flows.md           # fluxos principais (Mermaid)
    └── configuration.md   # configuração e extensão
```

Templates: [uso no módulo](../assets/templates/external-lib-usage.md) e [profundo](../assets/templates/external-lib-deep.md).

Nos documentos principais do módulo, inclua uma seção "Dependências" com um resumo curto e links para `docs/external/`, sem duplicar o conteúdo.

## 5. Publicação

No Confluence, crie a página "Dependências externas" como filha da raiz do módulo. Bibliotecas em **Uso no módulo** viram uma página; as em **Profundo** viram uma página com filhas.
