import 'package:flutter/material.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaNome(),
    );
  }
}

class TelaNome extends StatefulWidget {
  const TelaNome({super.key});

  @override
  State<TelaNome> createState() => _TelaNomeState();
}

class _TelaNomeState extends State<TelaNome> {
  final chave = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  String mensagem = '';

  void confirmar() {
    if (chave.currentState!.validate()) {
      setState(() {
        mensagem = 'Olá, ${nomeController.text.trim()}!';
      });
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nome validado')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: chave,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  // Regra 1: campo vazio ou formado apenas por espaços
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome.';
                  }
                  // Regra 2: no mínimo 3 caracteres após desconsiderar espaços
                  if (valor.trim().length < 3) {
                    return 'O nome deve ter pelo menos três caracteres.';
                  }
                  // null indica que todas as regras foram atendidas
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: confirmar,
                child: const Text('Confirmar'),
              ),
              const SizedBox(height: 20),
              Text(
                mensagem,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}