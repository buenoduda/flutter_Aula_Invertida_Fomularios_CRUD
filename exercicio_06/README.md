# Exercício 6 — Calcular o valor total do estoque

- **Projeto:** `produtos_memoria`
- **Nível:** Intermediário
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Usando a quantidade do exercício 5, exiba o valor de cada produto em estoque e o total de todos os registros na tela principal.

### Requisitos
- Valor de um item é preço multiplicado pela quantidade.
- Calcule o total com uma repetição percorrendo `produtos`.
- Recalcule o total após cadastrar, editar e excluir.
- Lista vazia apresenta total zero, com duas casas decimais.

---

## 💡 Resposta à Pergunta Conceitual
**Pergunta:** *Por que um total fixado apenas no cadastro ficaria incorreto depois de uma edição?*
**Resposta:** Porque a edição permite alterar tanto o preço quanto a quantidade de itens já cadastrados sem passar pelo método de inserção. Se o total fosse acumulado apenas no cadastro, qualquer alteração posterior deixaria o total exibido desalinhado com os dados reais da lista.

---

## 🔍 Explicação Técnica da Alteração
Criamos o getter `valorTotalItem` na classe `Produto` retornando `preco * quantidade`. Na tela principal (`_TelaProdutosState`), implementamos o getter `totalGeralEstoque`, que percorre a coleção `produtos` somando o subtotal de cada produto em um laço de repetição. Como a interface é reconstruída com `setState()` após cadastros, edições e exclusões, o total geral é sempre recalculado em tempo de execução.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Abrir app sem produtos cadastrados | Exibir `Total em estoque: R$ 0.00` | Exibiu `R$ 0.00` com lista vazia | Passou |
| Cadastrar Produto A (10 × 3 = 30) e Produto B (20 × 2 = 40) | Total geral em estoque: `R$ 70.00` | Total exibido exatamente `R$ 70.00` | Passou |
| Excluir o Produto A | Total geral recalculado para `R$ 40.00` | Total atualizado para `R$ 40.00` | Passou |