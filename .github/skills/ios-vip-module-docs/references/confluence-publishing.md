# Publicação no Confluence (MCP Atlassian)

Só execute depois da aprovação da revisão (GATE 2).

## 1. Pré-checagem

- Verifique se há ferramentas de um servidor MCP Atlassian/Confluence disponíveis (criar página, atualizar página, buscar página/espaço). Detecte os nomes reais em tempo de execução.
- Se não houver, **pare** e oriente: configurar o servidor MCP da Atlassian no VS Code, autenticar pelo fluxo do próprio servidor e reiniciar a sessão. Não peça nem aceite tokens no chat e não grave credenciais em arquivos.

## 2. Informações a solicitar (uma rodada de perguntas)

| Informação | Detalhe |
|---|---|
| Site Atlassian | Ex.: `<empresa>.atlassian.net` |
| Espaço (space key) | Chave do espaço de destino; valide se existe |
| Página pai | ID ou URL; a raiz do módulo será criada abaixo dela |
| Título da página raiz | Padrão sugerido: nome do módulo |
| Prefixo de títulos | Opcional, evita colisão (títulos são únicos por espaço) |
| Política para páginas existentes | Criar novas com sufixo, atualizar existentes ou ignorar |
| Labels | Ex.: `ios`, `<modulo>`, `documentacao` |
| Publicar dependências externas? | Sim/não, por nível |
| Confirmação final | Após mostrar o plano |

## 3. Plano de publicação

Monte e exiba a árvore antes de escrever:

```
<Página pai informada>
└── <Módulo> (de docs/README.md)
    ├── Arquitetura
    ├── Integração
    ├── Cenas
    │   └── <uma página por cena>
    ├── Rede
    ├── Modelos
    ├── Configuração
    ├── Analytics
    ├── Testes
    ├── Dependências externas
    │   ├── <Lib: Uso no módulo>
    │   └── <Lib: Profundo>
    │       └── <subpáginas>
    ├── Glossário
    └── Pendências
```

Marque cada nó como criar, atualizar ou ignorar, conforme a política. Peça confirmação final.

## 4. Conversão markdown para Confluence

- Envie o conteúdo no formato aceito pela ferramenta MCP (markdown ou storage format). Consulte a descrição da ferramenta; prefira markdown quando suportado.
- Mermaid: mantenha como **bloco de código** (` ```mermaid `) sem conversão para imagem. Informe ao usuário que será exibido como código, a menos que o espaço tenha uma macro de Mermaid.
- Links relativos entre `.md`: após criar as páginas, reescreva para links das páginas do Confluence (mapa caminho-do-arquivo para ID/URL). Publique primeiro, depois faça uma segunda passada para corrigir links.
- Remova o bloco de metadados interno (se houver) e mantenha o cabeçalho de objetivo e fontes.
- Adicione uma nota no topo da raiz: "Documentação gerada a partir do código-fonte em <data>; fonte da verdade: `docs/` no repositório".

## 5. Execução

1. Crie/atualize a raiz, depois as filhas, na ordem do plano.
2. Aplique as labels.
3. Em caso de erro (permissão, título duplicado, limite de tamanho), registre e continue com os demais; reporte no final.
4. Não apague nem sobrescreva páginas fora do plano aprovado.

## 6. Pós-publicação

- Atualize `docs/ROADMAP.md`: status `Publicado` e a URL de cada página.
- Entregue o relatório final com URLs, criadas versus atualizadas, falhas e pendências.
