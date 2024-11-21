import 'package:flutter/material.dart';

class DetalhesItemScreen extends StatelessWidget {
  final String nome;
  final String descricao;
  final String valor;
  final String imagem;

  const DetalhesItemScreen({
    super.key,
    required this.nome,
    required this.descricao,
    required this.valor,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 16),
            
            Text(
              nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              descricao,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "R\$ $valor",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
