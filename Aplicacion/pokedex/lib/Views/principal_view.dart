import 'package:flutter/material.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({ Key? key }) : super(key: key);

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _pokeball(),
          _textoTitulo(),
          Positioned(
            top: 220,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // esta propiedad es para que las tarjetas sean en dos columnas
                      childAspectRatio: 1.4 // esta propiedad es para que las tarjetas sean cuadradas
                    ),
                    shrinkWrap: true,// esta propiedad es para que el gridview se adapte al contenido
                    physics: const BouncingScrollPhysics(),
                    itemCount: 151,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                        ),
                        child: InkWell(
                          onTap: (){},
                          child: SafeArea( // esta propiedad es para que el inkwell no se salga de la pantalla
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: -9,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  _pokeball(){
    return Positioned(
      top: -50,
      right: -50,
      child: Image.asset(
        'images/pokeball.png',
        width: 250,
        fit: BoxFit.fitWidth,
        color: Colors.grey[300],
      )
    );
  }

  _textoTitulo(){
    return Positioned(
      top: 100,
      left: 20,
      child: Text(
        'Pokedex',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.7)
        ),
      ),
    );
  }
}