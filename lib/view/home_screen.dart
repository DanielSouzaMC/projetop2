import 'package:flutter/material.dart';
import 'package:projetop2/view/compra_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset('lib/images/logo.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover
                )
              ),
              const SizedBox(height: 30),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.restaurant,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text('Cardapio'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/telamenu');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text('Carrinho'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const ComprarScreen()),);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
