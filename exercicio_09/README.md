# Exercício 9 — Dar uma identidade estável aos registros

- **Projeto:** `produtos_memoria`
- **Nível:** Desafio para correção
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
Evolua o exercício 8 para identificar os produtos por um `id` inteiro que permaneça o mesmo durante a edição. A operação deve localizar o registro por `id`, sem depender da posição visível.

### Requisitos
- A tela principal atribui um novo `id` a cada cadastro aceito.
- Mantenha um contador que não diminui após exclusões.
- A edição preserva o `id` original.
- Use `indexWhere()` para localizar o registro por `id` antes de substituir ou excluir.
- Se não encontrar o `id`, interrompa a operação com feedback, sem acessar o índice -1.

---

## 🔍 Explicação Técnica da Alteração
Adicionamos o atributo imutável `final int id;` à classe `Produto`. Na tela principal, mantemos a variável `int proximoId = 1;`, que é incrementada a cada cadastro e nunca é decrementada ao excluir. Na edição, o formulário reaproveita o ID existente (`widget.produto?.id`). Para atualizar ou excluir, a tela busca a posição real na coleção usando `produtos.indexWhere((p) => p.id == idAlvo)`. Caso retorne `-1`, a operação é cancelada com um aviso preventivo, evitando exceções em tempo de execução.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Cadastrar IDs 1, 2 e 3; excluir ID 2; cadastrar novo | Novo item recebe ID 4 (o contador não retrocede) | Produto recebeu ID 4 corretamente | Passou |
| Filtrar produto de ID 3 e editar seu preço | Produto mantém ID 3 e apenas ele é modificado | Registro preservou o ID estável | Passou |
| Filtrar produto de ID 4 e confirmar exclusão | Remove apenas o item de ID 4; IDs 1 e 3 continuam na lista | Excluiu com base no ID único | Passou |