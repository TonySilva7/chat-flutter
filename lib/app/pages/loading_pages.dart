import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(height: 20),
            Text('Carregando...', style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
          ],
        ),
      ),
    );
  }
}
