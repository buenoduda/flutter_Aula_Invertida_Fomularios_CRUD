# Exercício 8 — Buscar e editar o produto correto

- **Projeto:** `produtos_memoria`
- **Nível:** Desafio para correção
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Inclua uma busca pelo nome na tela principal. O filtro muda a lista visível, mas cadastro, edição e exclusão devem continuar agindo no registro correto.

### Requisitos
- Busca ignora diferenças entre maiúsculas e minúsculas.
- Campo vazio mostra todos os produtos.
- Mostre `Nenhum produto encontrado.` quando o filtro não tiver resultados.
- Editar ou excluir um item filtrado atua somente naquele item.
- Mostre separadamente quantidade cadastrada e quantidade encontrada.

---

## 🔍 Explicação Técnica da Alteração
Adicionamos um campo `TextField` de pesquisa na tela principal e criamos a lista dinâmica `produtosFiltrados`. Como a posição na lista visível não é a mesma da lista original `produtos`, alteramos os métodos `abrirDetalhes` e `excluir` para receber a instância do `Produto` selecionado. A partir dele, encontramos o índice correto na lista principal utilizando `produtos.indexOf(produtoSelecionado)`. Também adicionamos os contadores `Cadastrados: X` e `Encontrados: Y`.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Cadastrar Mouse, Teclado e Monitor. Buscar `"Teclado"` e alterar preço | Apenas `"Teclado"` é alterado; Mouse e Monitor intactos | Registro correto editado na lista base | Passou |
| Digitar `"Impressora"` na busca com produtos na lista | Exibir `Encontrados: 0` e texto `Nenhum produto encontrado.` | Estado vazio de filtro exibido | Passou |
| Buscar `"Monitor"` e confirmar exclusão pela lixeira | Diálogo confirma `"Monitor"` e remove apenas este item | Excluiu exatamente o produto pesquisado | Passou |