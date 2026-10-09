# <Biblioteca> (documentação profunda)

Estrutura da pasta `docs/external/<Biblioteca>/`. Cada seção abaixo é um arquivo. Todos usam o cabeçalho padrão (objetivo, fontes, data).

## `README.md`: visão geral e arquitetura
- Propósito, origem/versão, plataformas, dependências próprias
- Estrutura de pastas e responsabilidades
- Diagrama de componentes (Mermaid `flowchart`)
- Como o módulo documentado usa a biblioteca (resumo e link para `public-api.md`)

## `public-api.md`: tipos e protocolos públicos
| Símbolo | Tipo | Descrição | Usado pelo módulo? |
|---|---|---|---|

Detalhe, por tipo central: responsabilidade, propriedades e métodos públicos relevantes, erros, exemplos curtos de uso. Sem copiar implementação.

## `flows.md`: fluxos principais
Um `sequenceDiagram` por fluxo relevante (inicialização, chamada principal, tratamento de erro) com explicação textual.

## `configuration.md`: configuração e extensão
- Parâmetros de configuração, injeção de dependências, pontos de extensão e customização
- Ambientes e feature flags (sem valores sensíveis)

## Pontos de atenção
- Limitações, riscos, versões, itens "A confirmar" (também em `open-points.md` do módulo)
