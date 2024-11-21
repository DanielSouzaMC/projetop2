import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComprarScreen extends StatefulWidget {
  const ComprarScreen({super.key});

  @override
  State<ComprarScreen> createState() => _ComprarScreenState();
}

class _ComprarScreenState extends State<ComprarScreen> {
  Future<void> removerItem(String nome) async {
    final pedidoRef =
        FirebaseFirestore.instance.collection('pedido').doc('usuario123');

    final pedido = await pedidoRef.get();

    if (pedido.exists) {
      final itens = List<Map<String, dynamic>>.from(pedido.data()?['itens'] ?? []);

      itens.removeWhere((item) => item['nome'] == nome);

      if (itens.isEmpty) {
        await pedidoRef.delete();
        setState(() {}); 
        return;
      }

      final total = itens.fold<double>(
        0.0,
        (sum, item) => sum + double.parse(item['subtotal'].toString()),
      );

      await pedidoRef.update({'itens': itens, 'total': total});
      setState(() {}); 
    }
  }

  Future<void> limparCarrinho() async {
    final pedidoRef =
        FirebaseFirestore.instance.collection('pedido').doc('usuario123');

    await pedidoRef.delete();
    setState(() {}); 
  }

  Future<void> finalizarCompra(BuildContext context) async {
    final pedidoRef =
        FirebaseFirestore.instance.collection('pedido').doc('usuario123');

    await pedidoRef.delete(); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compra realizada com sucesso!'),
        duration: Duration(seconds: 1), 
      ),
    );
    await Future.delayed(const Duration(seconds: 1)); 
    Navigator.pushNamed(context, '/telamenu'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprar'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('pedido').doc('usuario123').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Carrinho Vazio',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/telamenu'); 
                  },
                  child: const Text('Comprar Mais'),
                ),
              ],
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final itens = List<Map<String, dynamic>>.from(data['itens']);
          final total = double.parse(data['total'].toString());

          final entradas = itens.where((item) => item['categoria'] == 1).toList();
          final pratosPrincipais = itens.where((item) => item['categoria'] == 2).toList();
          final sobremesas = itens.where((item) => item['categoria'] == 3).toList();

          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (entradas.isNotEmpty)
                      _buildCategorySection('Entradas', entradas, context),
                    if (pratosPrincipais.isNotEmpty)
                      _buildCategorySection('Pratos Principais', pratosPrincipais, context),
                    if (sobremesas.isNotEmpty)
                      _buildCategorySection('Sobremesas', sobremesas, context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: R\$ ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/telamenu'); 
                },
                child: const Text('Comprar Mais'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => limparCarrinho(),
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Limpar Carrinho',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => finalizarCompra(context), 
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        'Finalizar Compra',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategorySection(
      String category, List<Map<String, dynamic>> items, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((item) => _buildItemCard(item, context)).toList(),
      ],
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(item['nome']),
        subtitle: Text(
          'Quantidade: ${item['quantidade']} - Subtotal: R\$ ${item['subtotal'].toStringAsFixed(2)}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await removerItem(item['nome']);
          },
        ),
      ),
    );
  }
}
