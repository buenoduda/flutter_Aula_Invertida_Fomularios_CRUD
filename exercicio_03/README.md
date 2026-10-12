# Exercício 3 — Regras adicionais para o produto

- **Projeto:** `produtos_memoria`
- **Nível:** Inicial
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
A loja quer nomes com pelo menos três caracteres e descrições com no máximo 120 caracteres. Acrescente essas regras ao formulário de produtos.

### Requisitos
- Nome e preço continuam obrigatórios.
- Descrição continua opcional; se preenchida, respeita o limite.
- A regra deve funcionar tanto no cadastro quanto na edição.

---

## 💡 Resposta à Pergunta Conceitual
**Pergunta:** *Qual é a vantagem de ter uma única tela de formulário para as duas operações?*
**Resposta:** Centralização de regras e facilidade de manutenção. Como a interface e os validadores (nome com 3+ caracteres, preço positivo, descrição até 120 caracteres) são idênticos no cadastro e na edição, manter uma única tela (`TelaFormulario`) evita duplicação de código e impede inconsistências no aplicativo.

---

## 🔍 Explicação Técnica da Alteração
Na tela `TelaFormulario`, adicionamos a verificação `valor.trim().length < 3` no validador do campo Nome. No campo Descrição, adicionamos a propriedade `validator` conferindo se `valor != null && valor.trim().length > 120`. Como o formulário é o mesmo para cadastro e edição, as duas rotinas passam pelas mesmas validações automaticamente.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Cadastrar produto com nome `"Ab"` | Erro: `O nome deve ter pelo menos 3 caracteres.` | Bloqueou o cadastro e exibiu erro | Passou |
| Cadastrar com descrição vazia | Cadastrar normalmente; detalhes mostram `Sem descrição.` | Cadastrado com sucesso | Passou |
| Editar descrição colocando 121 caracteres | Erro: `A descrição deve ter no máximo 120 caracteres.` | Bloqueou o salvamento | Passou |