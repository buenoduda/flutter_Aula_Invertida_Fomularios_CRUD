# Exercício 7 — Impedir nomes repetidos

- **Projeto:** `produtos_memoria`
- **Nível:** Intermediário
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
A loja decidiu que não pode haver dois produtos com o mesmo nome. Implemente essa regra no cadastro e na edição.

### Requisitos
- Compare nomes depois de `trim()` e `toLowerCase()`.
- Rejeite `Mouse` e `mouse` como duplicados.
- Editar um produto sem mudar seu nome deve ser permitido.
- Ao editar, compare com os outros registros, excluindo o registro em edição.
- Apresente mensagem clara e permita corrigir o campo sem perder a digitação.

---

## 🔍 Explicação Técnica da Alteração
Seguindo a orientação do professor, passamos uma `List<String> nomesExistentes` para a tela de formulário. No cadastro, essa lista contém o nome de todos os produtos cadastrados. Na edição, enviamos apenas os nomes dos outros produtos (`i != indice`), excluindo o que está sendo editado. No validador de nome (`validarNome`), usamos `.any()` para comparar a entrada digitada com a lista de nomes já cadastrados utilizando `trim()` e `toLowerCase()`.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Cadastrar `"Mouse"` e `"Teclado"`; tentar cadastrar `"mouse"` | Bloquear com `Já existe um produto com este nome.` | Bloqueou cadastro de nome duplicado | Passou |
| Editar `"Mouse"`, mudar apenas o preço e salvar | Salvar com sucesso sem acusar falso positivo | Produto salvo mantendo o próprio nome | Passou |
| Editar `"Teclado"` alterando o nome para `"Mouse"` | Bloquear por conflito com o outro produto | Exibiu erro de duplicidade e manteve a tela | Passou |