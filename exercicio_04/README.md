# Exercício 4 — Cancelamento sem efeitos colaterais

- **Projeto:** `produtos_memoria`
- **Nível:** Inicial
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Comprove e explique que desistir de uma operação mantém os registros. Execute a sequência de cancelamentos e melhore o texto dos botões se necessário.

### Requisitos
- Cancelar cadastro não cria produto.
- Cancelar edição preserva nome, preço e descrição originais.
- Cancelar exclusão preserva o item e a contagem.
- Entregue uma explicação de como `null` é tratado no cadastro e na edição.

---

## 💡 Explicação Técnica do Tratamento de `null`
- **No Cadastro:** Quando o usuário clica em Cancelar, o `Navigator.pop(context)` não envia nenhum valor, devolvendo `null` para o chamador. O método `cadastrar()` possui a cláusula de guarda `if (!mounted || novo == null) return;`, impedindo a execução de `produtos.add()` e mantendo a lista intacta.
- **Na Edição:** Os atributos de `Produto` são `final` (imutáveis). As alterações digitadas afetam temporariamente apenas os `TextEditingController`. Se o usuário cancela, o formulário devolve `null` para `TelaDetalhes`, que por sua vez não repassa dados à tela principal. A lista não executa a atribuição `produtos[indice] = atualizado`, preservando o registro original.
- **Na Exclusão:** O diálogo aberto via `showDialog<bool>()` retorna `false` ou `null`. Como a remoção só ocorre se `confirmou == true`, nenhuma exclusão é efetuada.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Clicar em `+`, preencher dados e clicar em Cancelar | Nenhum item criado; quantidade mantida | Lista permaneceu inalterada | Passou |
| Cadastrar `"Mouse"` a 50, abrir edição para `"Teclado"` a 100 e cancelar | Manter `"Mouse"` a 50 nos detalhes e na lista | Dados originais preservados | Passou |
| Clicar na lixeira de um produto e clicar em Cancelar | Item mantido na lista e contador inalterado | Produto não foi removido | Passou |