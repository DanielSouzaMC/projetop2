import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetop2/view/compra_screen.dart';

class DadosItemScreen extends StatelessWidget {
  final String nome;
  final String descricao;
  final String valor;
  final String imagem;
  final int categoria;

  const DadosItemScreen({
    super.key,
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.imagem,
    required this.categoria,
  });

  Future<void> adicionarAoCarrinho(BuildContext context) async {
    final pedidoRef = FirebaseFirestore.instance.collection('pedido').doc('usuario123');

    try {
      final pedido = await pedidoRef.get();

      if (pedido.exists) {
        final itens = List<Map<String, dynamic>>.from(pedido.data()?['itens'] ?? []);
        bool itemJaExiste = false;

        for (var item in itens) {
          if (item['nome'] == nome) {
            item['quantidade'] += 1;
            item['subtotal'] = item['quantidade'] * double.parse(valor);
            itemJaExiste = true;
            break;
          }
        }

        if (!itemJaExiste) {
          itens.add({
            'nome': nome,
            'descricao': descricao,
            'valor': double.parse(valor),
            'quantidade': 1,
            'subtotal': double.parse(valor),
            'categoria': categoria,
          });
        }

        final total = itens.fold<double>(
          0.0,
          (sum, item) => sum + item['subtotal'],
        );

        await pedidoRef.update({'itens': itens, 'total': total});
      } else {
        await pedidoRef.set({
          'usuarioId': 'usuario123',
          'itens': [
            {
              'nome': nome,
              'descricao': descricao,
              'valor': double.parse(valor),
              'quantidade': 1,
              'subtotal': double.parse(valor),
              'categoria': categoria,
            }
          ],
          'total': double.parse(valor),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Item adicionado ao carrinho!'),
          duration: const Duration(milliseconds: 750), 
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar ao carrinho: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  imagem,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "R\$ $valor",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () => adicionarAoCarrinho(context),
                  child: const Text('Adicionar ao Carrinho'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComprarScreen(),
                      ),
                    );
                  },
                  child: const Text('Comprar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
