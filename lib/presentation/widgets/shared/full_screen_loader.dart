import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});



  Stream<String> getLoadingMessages(){ //Funcion que nos retorna streams periodicamente de tipo string
    
    final messages = <String>[
      "Cargando películas",
      "Comprando golosinas",
      "Cargando populares",
      "Ya casi...",
      "Esto está tardando mucho",
      "Espera...",
      "Listo :) ",
    ];
    
    return Stream.periodic(const Duration(milliseconds: 2000),(step){
        return messages[step];
      
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Espere por favor"),
          SizedBox(height: 20,),
          CircularProgressIndicator(),

          StreamBuilder(
            stream: getLoadingMessages(), //Lo que queremos contruir
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("Cargando...");

              return Text(snapshot.data!);
            },
          )
        ],

      ),
    );
  }
}