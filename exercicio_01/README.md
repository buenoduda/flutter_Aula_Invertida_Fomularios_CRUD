# Exercício 1 — Nome válido e mensagem personalizada

- **Projeto:** `formulario_nome`
- **Nível:** Inicial
- **Aluno(a):** Eduarda Bueno de Salvo
- **Disciplina:** Programação para Dispositivos Móveis

---

## 📌 Enunciado do Professor
O cadastro de participantes precisa rejeitar nomes curtos. Modifique o exemplo da seção 3 para exigir um nome com pelo menos três caracteres depois de `trim()`.

### Requisitos
- Mantenha a mensagem `Informe o nome.` para o campo vazio.
- Apresente `O nome deve ter pelo menos três caracteres.` para um nome curto.
- Exiba a saudação somente depois de validar.

---

## 💡 Resposta à Pergunta Conceitual
**Pergunta:** *Por que precisamos usar `trim()` antes de verificar o comprimento?*
**Resposta:** Porque se o usuário digitar apenas espaços em branco (por exemplo, `"   "`), o comprimento (`length`) seria 3 e o validador aceitaria a entrada como válida. O método `trim()` elimina os espaços das pontas, garantindo que o teste de tamanho conte apenas caracteres reais.

---

## 🔍 Explicação Técnica da Alteração
No `TextFormField`, adicionamos uma verificação adicional dentro da função `validator`. Após testar se o campo é nulo ou vazio (`valor == null || valor.trim().isEmpty`), avaliamos se `valor.trim().length < 3`. Se for menor que 3, retornamos a mensagem de erro específica. Caso atenda a ambas as regras, o validador retorna `null`, permitindo que o método `confirmar()` execute o `setState()` com a saudação.

---

## 🧪 Tabela de Testes Realizados

| Entrada | Resultado Esperado | Resultado Observado | Status |
| :--- | :--- | :--- | :---: |
| *(Vazio)* ou `"  "` | Erro: `Informe o nome.` | Erro `Informe o nome.` exibido | Passou |
| `"Al"` (2 caracteres) | Erro: `O nome deve ter pelo menos três caracteres.` | Erro de comprimento exibido | Passou |
| `"Ana"` ou `"  Ana  "` | Saudação: `Olá, Ana!` | Exibiu `Olá, Ana!` | Passou |