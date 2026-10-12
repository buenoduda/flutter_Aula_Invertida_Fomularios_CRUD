# Exercício 5 — Acrescentar a quantidade em estoque

- **Projeto:** `produtos_memoria`
- **Nível:** Intermediário
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Cada produto precisa ter uma quantidade inteira em estoque. Acrescente o atributo `quantidade` e um campo correspondente.

### Requisitos
- Quantidade é obrigatória, inteira e maior ou igual a zero.
- Use `int.tryParse()` e rejeite valores decimais.
- Preencha a quantidade atual na edição.
- Exiba a quantidade na lista e nos detalhes.
- Atualize todos os pontos de construção de `Produto`.

---

## 🔍 Explicação Técnica da Alteração
Adicionamos o atributo imutável `final int quantidade;` à classe `Produto` e atualizamos todas as suas instanciações. Na `TelaFormulario`, criamos o `quantidadeController` (inicializado com a quantidade do produto na edição ou vazio no cadastro). Implementamos a função `validarQuantidade`, que rejeita campos vazios, entradas com ponto ou vírgula, valores que falham no `int.tryParse()` e inteiros menores que zero (`qtde < 0`). Por fim, adicionamos a quantidade no `subtitle` do `ListTile` e na `TelaDetalhes`.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Tentar cadastrar quantidade vazia, `"abc"`, `"-1"` ou `"2.5"` | Erro de validação específico para cada caso | Todos os casos inválidos foram bloqueados | Passou |
| Cadastrar produto com quantidade `0` | Cadastro aceito com sucesso (0 é >= 0) | Produto cadastrado com `Estoque: 0` | Passou |
| Cadastrar com quantidade `3` e editar para `5` | Carregar `3` no campo e salvar atualizando para `5` | Registro atualizado na lista e detalhes | Passou |