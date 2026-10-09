---
name: ios-vip-module-docs
description: 'Documenta um módulo iOS Swift com arquitetura VIP (View-Interactor-Presenter) a partir do código-fonte, gera roadmap de documentação, escreve markdown em docs/, pede revisão e publica no Confluence via MCP Atlassian. Inclui documentação de dependências e bibliotecas externas com profundidade escolhida por biblioteca. Use quando pedirem documentar módulo iOS, documentação VIP, roadmap de documentação, documentar Swift, publicar documentação no Confluence, documentar bibliotecas internas ou dependências de um módulo.'
argument-hint: 'Nome ou pasta do módulo a documentar (ex.: App)'
---

# Documentação de módulo iOS (VIP) com publicação no Confluence

Gera documentação completa em pt-BR a partir do código Swift e a publica no Confluence. O fluxo tem 5 fases com **gates de aprovação**: nunca avance de fase sem aprovação explícita do usuário.

## Regras gerais

- Idioma da documentação: **português (pt-BR)**. Identificadores de código ficam em inglês, como no fonte.
- Toda afirmação deve vir do código. O que não puder ser inferido é marcado como `> **A confirmar:** ...` e vai para a lista de pendências.
- Não copie código externo integralmente; documente interfaces, contratos e comportamento. Trechos de código só quando curtos e ilustrativos.
- Nunca inclua segredos, tokens, chaves, URLs internas de ambientes ou dados de clientes na documentação.
- Não altere nenhum arquivo Swift do projeto. A única escrita permitida é em `docs/`.
- Use a ferramenta de perguntas ao usuário (`vscode_askQuestions`) sempre que precisar de informações. Não adivinhe valores.
- Mantenha o estado do progresso em `docs/ROADMAP.md` (coluna Status) para retomar sessões interrompidas.
- Para ler muito código, delegue a subagentes `Explore` em paralelo (um por área) e consolide os resultados.

## Fase 0 – Parâmetros

Pergunte, em uma única rodada quando possível:

1. Nome do módulo e pasta(s) do código-fonte (sugira a partir de `*.podspec`, `project.yml` ou pastas de primeiro nível).
2. Público-alvo principal (novos devs, integradores, QA, produto).
3. Existe documentação prévia (README, DocC, Confluence) a reaproveitar? Se sim, onde.
4. A pasta `docs/` já existe? Se existir, pergunte se deve sobrescrever, mesclar ou usar outro diretório.

Se `docs/` não existir, crie-a na raiz do projeto.

## Fase 1 – Análise e roadmap

1. Varra **todo** o código Swift do módulo seguindo [o guia de análise VIP](./references/vip-analysis-guide.md). Cubra: cenas, componentes comuns, modelos, rede, configuração, analytics, extensões, utilitários, módulo transacional, recursos (strings, assets) e testes/mocks.
2. Descubra as dependências externas conforme [dependências externas](./references/external-dependencies.md): cruze `import` Swift com `Podfile`, `*.podspec`, `Package.swift`, `project.yml`.
3. Pergunte a **pasta** e o **nível de profundidade** de cada dependência (Ignorar, Referência, Uso no módulo, Profundo), em uma tabela única com padrões sugeridos, conforme o guia de dependências.
4. Gere `docs/ROADMAP.md` usando [o template de roadmap](./references/roadmap-template.md), contendo: inventário do módulo, lista de documentos planejados (escopo, arquivos-fonte, prioridade, status), tabela de dependências externas com profundidade escolhida e riscos/lacunas.
5. **GATE 1:** apresente um resumo do roadmap e peça aprovação ou ajustes. Itere até aprovar. Não gere documentos antes disso.

## Fase 2 – Geração da documentação (markdown em `docs/`)

Gere os documentos conforme o roadmap aprovado, usando [os templates](./references/doc-templates.md). Estrutura de saída:

```
docs/
├── ROADMAP.md
├── README.md                  # índice e visão geral
├── architecture/              # VIP no módulo, camadas, fluxo de dados
├── integration/               # como integrar e iniciar o módulo
├── scenes/                    # um arquivo por cena/fluxo
├── network/                   # endpoints, workers, providers, erros
├── models/                    # modelos de domínio e request/response
├── configuration/             # bridge, configuração, remote config, feature flags
├── analytics/                 # eventos e propriedades
├── testing/                   # estratégia de testes e mocks
├── external/                  # dependências externas (README.md + um item por biblioteca)
├── glossary.md
└── open-points.md             # pendências, "A confirmar" e dívidas técnicas
```

Regras:
- Cada documento começa com um cabeçalho curto (objetivo, arquivos-fonte principais, última atualização) e termina com links relacionados.
- Referencie código por caminho relativo ao repositório, por exemplo `App/Network/PixNetwork.swift`, sem números de linha frágeis.
- Use diagramas **Mermaid** (`sequenceDiagram`, `flowchart`, `classDiagram`) em blocos ```` ```mermaid ````.
- Links entre documentos usam caminhos relativos `.md`, que a fase de publicação reescreve.
- Dependências externas seguem o nível escolhido: veja [dependências externas](./references/external-dependencies.md) e os templates em [assets/templates](./assets/templates/).
- Atualize o Status no `ROADMAP.md` a cada documento concluído.
- Para áreas grandes, gere o documento por partes, usando subagentes por subpasta.

## Fase 3 – Revisão (GATE 2)

1. Execute o [checklist de revisão](./references/review-checklist.md) e corrija o que for automático (links quebrados, Mermaid inválido, segredos, termos inconsistentes).
2. Apresente ao usuário: lista dos documentos gerados com caminhos, resumo das pendências "A confirmar" e dos riscos de precisão.
3. Peça uma **revisão humana** explícita. O usuário pode editar os `.md` diretamente ou pedir ajustes ao agente.
4. Itere até receber aprovação clara para publicar. Sem essa aprovação, **não publique**.

## Fase 4 – Publicação no Confluence (GATE 3)

Siga [o guia de publicação](./references/confluence-publishing.md):

1. Verifique se há ferramenta MCP Atlassian/Confluence disponível. Se não houver, **pare** e oriente o usuário a configurar o servidor MCP Atlassian; não tente alternativas que exijam credenciais no chat.
2. Solicite todas as informações necessárias: site Atlassian, espaço (space key), página pai, título raiz, prefixo de títulos, política para páginas existentes, labels e confirmação final.
3. Mostre o plano de publicação (árvore de páginas que serão criadas ou atualizadas) e peça confirmação final antes de qualquer escrita.
4. Publique pai primeiro e filhas depois, reescrevendo links relativos para links de páginas do Confluence.

## Fase 5 – Relatório final

Entregue: URLs das páginas publicadas, páginas atualizadas versus criadas, itens que falharam e por quê, pendências "A confirmar" que continuam em aberto e sugestões de manutenção da documentação.

## Retomada e atualização

Se `docs/ROADMAP.md` já existir, leia-o, mostre o status e pergunte se deseja continuar de onde parou, atualizar documentos desatualizados ou recomeçar.
