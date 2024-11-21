import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetop2/view/dados_item_screen.dart';
import 'package:projetop2/model/itens.dart';

class SobremesasScreen extends StatelessWidget {
  const SobremesasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobremesas'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('itens')
            .where('categoria', isEqualTo: 3)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar sobremesas.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma sobremesa encontrada.'));
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

              // Busca o caminho da imagem baseado no cod
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
                    Icons.icecream,
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
                          categoria: 3,
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
