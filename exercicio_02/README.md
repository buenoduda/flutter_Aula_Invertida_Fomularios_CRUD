# Exercício 2 — Limpar e evitar uma saudação antiga

- **Projeto:** `formulario_nome`
- **Nível:** Inicial
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
No formulário de nome, uma saudação antiga pode permanecer quando o usuário tenta confirmar uma entrada inválida. Acrescente o botão Limpar e organize esse comportamento.

### Requisitos
- Limpar deve apagar campo e saudação e remover as mensagens de validação.
- Ao tentar confirmar um nome inválido, apague a saudação anterior.
- Cancelar uma entrada inválida não deve produzir mensagem de sucesso.

---

## 🔍 Explicação Técnica da Alteração
Implementamos o método `limpar()`, que executa `nomeController.clear()`, reinicia o estado visual dos validadores chamando `chave.currentState?.reset()` e esvazia a variável de saída (`mensagem = ''`) dentro de um `setState()`. No método `confirmar()`, adicionamos uma cláusula `else`: caso a validação do formulário falhe, a mensagem de saudação anterior é imediatamente apagada da tela.

---

## 🧪 Tabela de Testes Realizados

| Procedimento | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| Digitar `"Ana"` e confirmar | Exibir `Olá, Ana!` | Saudação exibida com sucesso | Passou |
| Apagar o nome e confirmar novamente | Mostrar erro e remover a saudação anterior | Campo indicou erro e a saudação sumiu | Passou |
| Digitar `"Al"`, confirmar e clicar em Limpar | Campo vazio, erro removido e tela limpa | Texto apagado e estado do Form resetado | Passou |