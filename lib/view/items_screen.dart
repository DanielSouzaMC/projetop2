import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetop2/view/entradas_scren.dart';
import 'package:projetop2/view/home_screen.dart';
import 'package:projetop2/view/prato_principal_screen.dart';
import 'package:projetop2/view/sobremesas_screen.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio'),
      ),
      body: Column(
        children: [
          // Imagem no topo da janela
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Image.asset(
              'lib/images/logo.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20), // Espaço entre a imagem e os cards
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('categorias').orderBy('ordem').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar categorias.'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Nenhuma categoria encontrada.'));
                }

                final categorias = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: categorias.length,
                  itemBuilder: (context, index) {
                    final data = categorias[index].data() as Map<String, dynamic>;

                    final nome = data['nome'] ?? 'Sem nome';
                    final descricao = data['descricao'] ?? 'Sem descrição';
                    final ordem = data['ordem'] ?? '';

                    IconData icon;
                    int categoriaId; 
                    switch (ordem.toString()) {
                      case '2': 
                        icon = Icons.dinner_dining;
                        categoriaId = 2;
                        break;
                      case '3': 
                        icon = Icons.icecream;
                        categoriaId = 3;
                        break;
                      default: 
                        icon = Icons.fastfood;
                        categoriaId = 1;
                    }

                    return GestureDetector(
                      onTap: () {
                        Widget screen;
                        if (categoriaId == 2) {
                          screen = const PratosPrincipaisScreen(); 
                        } else if (categoriaId == 3) {
                          screen = const SobremesasScreen(); 
                        } else {
                          screen = EntradasScreen(categoriaId: categoriaId); 
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => screen),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(
                            icon, 
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
                          trailing: const Icon(
                            Icons.arrow_forward_ios, 
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10), 
          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Voltar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
