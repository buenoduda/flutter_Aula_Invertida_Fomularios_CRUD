# Exercício 10 — Integrar e apresentar o gerenciador de produtos

- **Projeto:** `produtos_memoria`
- **Nível:** Desafio para correção
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Reúna as funcionalidades em uma versão final coerente. Um usuário deve cadastrar, buscar, consultar, editar e excluir produtos com segurança nas regras estudadas.

### Requisitos
- Integre validação, quantidade, total do estoque, nomes únicos, busca e IDs.
- O total geral considera todos os produtos, mesmo com filtro ativo.
- Cadastro e edição usam a mesma tela de formulário.
- Cancelamentos preservam os dados; exclusão exige confirmação.
- Registre testes de atualização com filtro ativo e descreva uma falha que corrigiu.
- Escreva um README com instruções, recursos e a informação de que os dados não persistem após reiniciar.

---

## 💡 Questão Conceitual para Correção
**Pergunta:** *O que precisaria mudar para manter os produtos depois de fechar o aplicativo?*
**Resposta:** Seria necessário implementar uma camada de persistência definitiva. Em vez de manter os dados apenas em uma `List<Produto>` na memória RAM, a aplicação deveria salvar os dados localmente em disco (via serialização JSON em arquivo com `path_provider`, armazenamento de pares chave-valor com `shared_preferences` ou banco de dados relacional embarcado com `sqflite`) ou em um serviço em nuvem via API. Ao iniciar o app, os dados seriam lidos no `initState()`.

---

## 🔍 Falha Corrigida Durante a Integração
- **Falha Observada:** Ao aplicar um filtro de pesquisa e tocar para editar o produto exibido, se o código usasse o índice da lista visível (`indice == 0`), a tela de detalhes acabava sobrescrevendo o primeiro produto da lista geral em vez do produto que estava sendo visualizado.
- **Solução Implementada:** Passamos a identificar cada produto por um `id` imutável permanente e a localizar sua posição na lista principal com `produtos.indexWhere((p) => p.id == idAlvo)` antes de aplicar qualquer alteração ou exclusão.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Cadastrar A (R$ 30) e B (R$ 40) = R$ 70. Filtrar por `"B"` | Lista mostra apenas B, mas total geral segue `R$ 70.00` | Total geral manteve R$ 70.00 com filtro ativo | Passou |
| Com filtro `"B"` ativo, alterar preço de B de 20 para 25 | Total geral recalcula para `R$ 80.00` ($30 + 50$) | Total recalculou e item B atualizou | Passou |
| Com filtro ativo, clicar em Excluir e depois em Cancelar | Diálogo fecha; produto não é removido e lista é mantida | Exclusão abortada com segurança | Passou |