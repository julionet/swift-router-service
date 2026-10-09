# Checklist de revisão

Execute antes do GATE 2. Corrija o que for automático e liste o restante para o usuário.

## Precisão
- [ ] Cada cena documentada existe no código e os caminhos citados existem.
- [ ] Protocolos, tipos e nomes de métodos conferem com o fonte.
- [ ] Fluxos e diagramas refletem o código, não suposições.
- [ ] Tudo que não foi inferível está marcado como "A confirmar" e listado em `open-points.md`.

## Completude
- [ ] Todos os documentos do `ROADMAP.md` existem ou têm status justificado.
- [ ] Todas as cenas, workers/providers, endpoints, eventos de analytics e feature flags encontrados estão cobertos.
- [ ] Cada dependência externa tem o nível escolhido atendido (Ignorar, Referência, Uso no módulo, Profundo).
- [ ] Documentos principais têm a seção "Dependências" com links para `external/`.

## Formato
- [ ] Todo documento tem cabeçalho (objetivo, fontes, data) e "Veja também".
- [ ] Links relativos entre `.md` resolvem para arquivos existentes.
- [ ] Blocos Mermaid têm sintaxe válida e rótulos sem caracteres que quebrem o parser.
- [ ] Tabelas bem formadas e títulos hierárquicos (um H1 por arquivo).
- [ ] Texto em pt-BR, terminologia consistente com o glossário.

## Segurança e conformidade
- [ ] Sem tokens, chaves, senhas, certificados, CPF/dados reais, URLs de ambientes internos ou de produção.
- [ ] Sem código externo copiado integralmente; apenas interfaces e trechos curtos.
- [ ] Nenhum arquivo Swift foi alterado.

## Relatório ao usuário
Apresente: documentos gerados (caminho e status), número de pendências "A confirmar", correções automáticas feitas e pontos que exigem decisão humana. Peça aprovação explícita para publicar.
