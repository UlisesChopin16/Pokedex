import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  final int index;
  final String nombre;
  final String numero;
  final String imagen;
  final String tipo;
  final String altura;
  final String peso;
  final Color color;

  const DetailsView({ 

    Key? key,
    required this.index,
    required this.nombre,
    required this.numero,
    required this.imagen,
    required this.tipo,
    required this.altura,
    required this.peso,
    required this.color

  }) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {

  double width = 0;
  double height = 0;

  // metodo para obtener el tamaño de la pantalla
  getSize(BuildContext context){
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    getSize(context);
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _infoTopPokemon(
            name: widget.nombre,
            type: widget.tipo,
            numero: widget.numero
          ),
          _infoBottomPokemon(
            heightp: widget.altura,
            weightp: widget.peso
          ),
          _pokeball(),
          _imagePokemon(image: widget.imagen, index: widget.index),
        ],
      ),
    );
  }

  _infoTopPokemon({
    required String name,
    required String type,
    required String numero
  }){
    return Positioned(
      top: 10,
      left: 30,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _namePokemon(name),
                const SizedBox(height: 5),
                _typePokemon(type)
              ],
            ),
          ),
          _numPokemon(numero)
        ],
      ),
    );
  }

  _namePokemon(String name){
    return Text(
      name,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
  }

  _typePokemon(String type){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0
        ),
        child: Text(
          type,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }

  _numPokemon(String num){
    return Text(
      '#$num',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white
      ),
    );
  }

  _infoBottomPokemon({
    required String heightp,
    required String weightp
  }){
    return Positioned(
      top: height * 0.4,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 40),

          child: Column(
            children: [
              _textInfo('Altura:', heightp),
              const SizedBox(height: 20),
              _textInfo('Peso:', weightp),
            ],
          ),
        ),
      ),
    );
  }

  _textInfo(String label, String content){
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          content,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _pokeball(){
    return Positioned(
      top: height * 0.15,
      right: -30,
      child: Image.asset(
        'images/pokeball.png',
        width: 250,
        height: 250,
        color: Colors.white.withOpacity(0.3),
      ),
    );
  }

  _imagePokemon({required int index, required String image}){
    return Positioned(
      top: height * 0.16,
      child: Hero(
        tag: index,
        child: CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            height: 270,
            width: 270,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover
              )
            ),
          ),
          placeholder: (context, url) => const SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: CircularProgressIndicator()
            )
          ),
        ),
      ),
    );
  }
}