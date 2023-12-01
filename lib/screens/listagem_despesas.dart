import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/despesa.dart';

class DespesasList extends StatefulWidget {
  const DespesasList({super.key});

  @override
  State<DespesasList> createState() => _DespesasListState();
}

class _DespesasListState extends State<DespesasList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Listagem de despesas')),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('despesas').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Despesa despesa = Despesa.fromDoc(documents[index]);
                    return ListTile(
                      trailing: Text('R\$${despesa.valor.toString()}'),
                      title: Text(despesa.nome),
                      subtitle: Text('${despesa.descricao} - ${despesa.data}'),
                    );
                  });
            }));
  }
}
