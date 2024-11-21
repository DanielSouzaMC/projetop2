import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetop2/view/dados_item_screen.dart';
import 'package:projetop2/model/itens.dart';

class EntradasScreen extends StatelessWidget {
  final int categoriaId;

  const EntradasScreen({super.key, required this.categoriaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('itens')
            .where('categoria', isEqualTo: categoriaId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar entradas.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma entrada encontrada.'));
          }

          final itens = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final data = itens[index].data() as Map<String, dynamic>;
              final nome = data['nome'] ?? 'Sem nome';
              final descricao = data['descricao'] ?? 'Sem descrição';
              final valor = data['valor'] ?? '0.00';
              final cod = data['cod'];

              final itemFoto = Itens.gerarDados().firstWhere(
                (item) => item.cod == cod.toString(),
                orElse: () => Itens('', ''), 
              );

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: const Icon(
                    Icons.fastfood,
                    size: 40,
                    color: Colors.orange,
                  ),
                  title: Text(
                    nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    descricao,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DadosItemScreen(
                          nome: nome,
                          descricao: descricao,
                          valor: valor,
                          imagem: itemFoto.foto, 
                          categoria: categoriaId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
