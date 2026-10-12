import 'package:flutter/material.dart';

// 6.1 Entrada do aplicativo
void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaProdutos(),
    );
  }
}

// 6.2 Modelo de dados
class Produto {
  final String nome;
  final double preco;
  final String descricao;
  final int quantidade;

  const Produto({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.quantidade,
  });

  double get valorTotalItem => preco * quantidade;
}

// 6.3 Tela principal com busca, lista, cadastro e exclusão
class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  final List<Produto> produtos = [];
  final TextEditingController buscaController = TextEditingController();
  String filtro = '';

  // Lista visível filtrada conforme o texto digitado na busca
  List<Produto> get produtosFiltrados {
    final termo = filtro.trim().toLowerCase();
    if (termo.isEmpty) {
      return produtos;
    }
    return produtos.where((p) => p.nome.toLowerCase().contains(termo)).toList();
  }

  // O total em estoque sempre considera todos os produtos cadastrados
  double get totalGeralEstoque {
    double total = 0.0;
    for (final p in produtos) {
      total += p.valorTotalItem;
    }
    return total;
  }

  void avisar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  Future<void> cadastrar() async {
    final nomesExistentes = produtos.map((p) => p.nome).toList();

    final novo = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaFormulario(nomesExistentes: nomesExistentes),
      ),
    );

    if (!mounted || novo == null) return;

    setState(() {
      produtos.add(novo);
    });

    avisar('Produto cadastrado com sucesso.');
  }

  // Recebe o objeto selecionado e descobre o índice real na lista original
  Future<void> abrirDetalhes(Produto produtoSelecionado) async {
    final indiceReal = produtos.indexOf(produtoSelecionado);
    if (indiceReal == -1) return;

    final outrosNomes = [
      for (int i = 0; i < produtos.length; i++)
        if (i != indiceReal) produtos[i].nome,
    ];

    final atualizado = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaDetalhes(
          produto: produtos[indiceReal],
          outrosNomes: outrosNomes,
        ),
      ),
    );

    if (!mounted || atualizado == null) return;

    setState(() {
      produtos[indiceReal] = atualizado;
    });

    avisar('Produto atualizado.');
  }

  // Localiza e remove o produto selecionado pelo seu índice real na lista produtos
  Future<void> excluir(Produto produtoSelecionado) async {
    final indiceReal = produtos.indexOf(produtoSelecionado);
    if (indiceReal == -1) return;

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (contextoDialogo) => AlertDialog(
        title: const Text('Excluir produto'),
        content: Text('Deseja excluir ${produtoSelecionado.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contextoDialogo, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(contextoDialogo, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (!mounted || confirmou != true) return;

    setState(() {
      produtos.removeAt(indiceReal);
    });

    avisar('Produto excluído.');
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listaVisivel = produtosFiltrados;

    return Scaffold(
      appBar: AppBar(title: const Text('Produtos em memória')),
      body: Column(
        children: [
          // Campo de busca com opção de limpar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: buscaController,
              decoration: InputDecoration(
                labelText: 'Buscar produto por nome',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: filtro.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          buscaController.clear();
                          setState(() {
                            filtro = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (valor) {
                setState(() {
                  filtro = valor;
                });
              },
            ),
          ),
          // Indicadores de produtos cadastrados e encontrados
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cadastrados: ${produtos.length}'),
                    Text('Encontrados: ${listaVisivel.length}'),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Total em estoque: R\$ ${totalGeralEstoque.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Apresentação da lista visível ou mensagem de estado vazio
          Expanded(
            child: produtos.isEmpty
                ? const Center(child: Text('Nenhum produto cadastrado.'))
                : listaVisivel.isEmpty
                    ? const Center(child: Text('Nenhum produto encontrado.'))
                    : ListView.builder(
                        itemCount: listaVisivel.length,
                        itemBuilder: (context, indice) {
                          final produto = listaVisivel[indice];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: ListTile(
                              title: Text(produto.nome),
                              subtitle: Text(
                                'R\$ ${produto.preco.toStringAsFixed(2)} × ${produto.quantidade} un. = R\$ ${produto.valorTotalItem.toStringAsFixed(2)}',
                              ),
                              onTap: () => abrirDetalhes(produto),
                              trailing: IconButton(
                                tooltip: 'Excluir produto',
                                icon: const Icon(Icons.delete),
                                onPressed: () => excluir(produto),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cadastrar,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 6.4 Tela de detalhes com acesso à edição
class TelaDetalhes extends StatelessWidget {
  final Produto produto;
  final List<String> outrosNomes;

  const TelaDetalhes({
    super.key,
    required this.produto,
    required this.outrosNomes,
  });

  Future<void> editar(BuildContext context) async {
    final atualizado = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaFormulario(
          produto: produto,
          nomesExistentes: outrosNomes,
        ),
      ),
    );

    if (!context.mounted || atualizado == null) return;

    Navigator.pop(context, atualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do produto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(produto.nome, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 12),
            Text('Preço unitário: R\$ ${produto.preco.toStringAsFixed(2)}'),
            const SizedBox(height: 6),
            Text('Quantidade em estoque: ${produto.quantidade}'),
            const SizedBox(height: 6),
            Text(
              'Valor total do item: R\$ ${produto.valorTotalItem.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              produto.descricao.isEmpty
                  ? 'Sem descrição.'
                  : produto.descricao,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => editar(context),
              child: const Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}

// 6.5 Formulário reutilizado
class TelaFormulario extends StatefulWidget {
  final Produto? produto;
  final List<String> nomesExistentes;

  const TelaFormulario({
    super.key,
    this.produto,
    this.nomesExistentes = const [],
  });

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final chave = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController precoController;
  late final TextEditingController quantidadeController;
  late final TextEditingController descricaoController;

  @override
  void initState() {
    super.initState();
    final produto = widget.produto;
    nomeController = TextEditingController(text: produto?.nome ?? '');
    precoController = TextEditingController(
      text: produto != null ? produto.preco.toString() : '',
    );
    quantidadeController = TextEditingController(
      text: produto != null ? produto.quantidade.toString() : '',
    );
    descricaoController = TextEditingController(
      text: produto?.descricao ?? '',
    );
  }

  double? converterPreco(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  String? validarPreco(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o preço.';
    }

    final preco = converterPreco(valor);
    if (preco == null || !preco.isFinite) {
      return 'Digite um número válido.';
    }

    if (preco <= 0) return 'O preço deve ser maior que zero.';

    return null;
  }

  String? validarQuantidade(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe a quantidade.';
    }

    if (valor.contains('.') || valor.contains(',')) {
      return 'A quantidade deve ser um número inteiro.';
    }

    final qtde = int.tryParse(valor.trim());
    if (qtde == null) {
      return 'Digite um número inteiro válido.';
    }

    if (qtde < 0) {
      return 'A quantidade não pode ser negativa.';
    }

    return null;
  }

  String? validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o nome.';
    }

    final nomeLimpo = valor.trim();
    if (nomeLimpo.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres.';
    }

    final duplicado = widget.nomesExistentes.any(
      (n) => n.trim().toLowerCase() == nomeLimpo.toLowerCase(),
    );

    if (duplicado) {
      return 'Já existe um produto com este nome.';
    }

    return null;
  }

  void salvar() {
    if (!chave.currentState!.validate()) return;

    final produto = Produto(
      nome: nomeController.text.trim(),
      preco: converterPreco(precoController.text)!,
      descricao: descricaoController.text.trim(),
      quantidade: int.parse(quantidadeController.text.trim()),
    );

    Navigator.pop(context, produto);
  }

  @override
  void dispose() {
    nomeController.dispose();
    precoController.dispose();
    quantidadeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.produto != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? 'Editar produto' : 'Cadastrar produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: chave,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: precoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: validarPreco,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: validarQuantidade,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição opcional',
                ),
                maxLines: 3,
                validator: (valor) {
                  if (valor != null && valor.trim().length > 120) {
                    return 'A descrição deve ter no máximo 120 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}