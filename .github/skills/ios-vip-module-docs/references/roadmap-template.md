# Template do roadmap (`docs/ROADMAP.md`)

Preencha com dados reais do módulo. Status permitidos: `Planejado`, `Em andamento`, `Concluído`, `Em revisão`, `Aprovado`, `Publicado`.

````markdown
# Roadmap de documentação – <Módulo>

- Módulo: <nome>
- Versão analisada: <versão do podspec/commit>
- Data da análise: <AAAA-MM-DD>
- Público-alvo: <público>
- Status geral: Planejado

## 1. Inventário do módulo

| Área | Pasta | Arquivos Swift | Observações |
|---|---|---|---|

## 2. Cenas e fluxos identificados

| Fluxo | Cenas | Pasta | Observações |
|---|---|---|---|

## 3. Documentos planejados

| # | Documento | Caminho em docs/ | Escopo | Arquivos-fonte principais | Prioridade | Status |
|---|---|---|---|---|---|---|
| 1 | Visão geral | README.md | Objetivo, escopo, índice | ... | Alta | Planejado |
| 2 | Arquitetura | architecture/overview.md | VIP no módulo, camadas | ... | Alta | Planejado |
| 3 | Integração | integration/getting-started.md | Como iniciar o módulo | ... | Alta | Planejado |
| 4 | Cena X | scenes/x.md | ... | ... | Média | Planejado |
| ... | Rede | network/overview.md | Workers, endpoints, erros | ... | Alta | Planejado |
| ... | Modelos | models/overview.md | ... | ... | Média | Planejado |
| ... | Configuração | configuration/overview.md | Bridge, remote config | ... | Alta | Planejado |
| ... | Analytics | analytics/events.md | Eventos | ... | Média | Planejado |
| ... | Testes | testing/overview.md | Mocks e estratégia | ... | Média | Planejado |
| ... | Glossário | glossary.md | Termos de negócio | ... | Baixa | Planejado |
| ... | Pendências | open-points.md | A confirmar e dívidas | ... | Média | Planejado |

## 4. Dependências externas

| Biblioteca | Origem/versão | Usos no módulo | Pasta informada | Nível | Documento | Status |
|---|---|---|---|---|---|---|

Níveis: Ignorar, Referência, Uso no módulo, Profundo.

## 5. Riscos e lacunas

- <ex.: biblioteca sem fonte local, código sem testes, regra de negócio não evidente>

## 6. Publicação no Confluence

- Estado: não iniciada
- Espaço / página pai / prefixo: a definir na fase 4
````

Ao final do roadmap, ordene os documentos por prioridade e dependência (visão geral e arquitetura primeiro, cenas e dependências depois).
