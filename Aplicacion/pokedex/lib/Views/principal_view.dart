import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pokedex/Controller/pokemon_controller.dart';
import 'package:pokedex/Views/details_view.dart';

class PrincipalView extends StatefulWidget {
  const PrincipalView({ Key? key }) : super(key: key);

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {

  final getDataController = Get.put(PokemonController());
  bool changeImage = false;

  @override
  void initState() {
    super.initState();
    getDataController.getDataFromApi();
  }

  List<String> types = [
    'Water',
    'Normal',
    'Poison',
    'Grass',
    'Fire',
    'Bug',
    'Electric',
    'Rock',
    'Ground',
    'Psychic',
    'Fighting',
    'Ghost',
    'Dragon',
    'Ice',
  ];
  
  Color determinarColor(String tipo){
    switch (tipo) {
      case 'Water':
        return Colors.blueAccent;
      case 'Poison':
        return Colors.purpleAccent;
      case 'Grass':
        return Colors.green;
      case 'Fire':
        return Colors.red;
      case 'Bug':
        return Colors.greenAccent;
      case 'Electric':
        return Colors.yellow[600]!;
      case 'Rock':
        return Colors.grey[700]!;
      case 'Ground':
        return Colors.brown;
      case 'Psychic':
        return Colors.pinkAccent;
      case 'Fighting':
        return Colors.redAccent;
      case 'Ghost':
        return Colors.deepPurpleAccent;
      case 'Dragon':
        return Colors.indigo;
      case 'Ice':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        extendBodyBehindAppBar: true,
        body: getDataController.isLoading.value ? const Center(
          child: CircularProgressIndicator()
        )
        : Stack(
          alignment: Alignment.center,
          children: [
            pokeball(),
            textTitle(),
            buildList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            changeImage = !changeImage;
            setState(() {

            });
          },
          child: const Icon(Icons.gif),
        ),
      ),
    );
  }

  pokeball(){
    return Positioned(
      top: -60,
      right: -100,
      child: Image.asset(
        'images/pokeball.png',
        width: 300,
        fit: BoxFit.fitWidth,
        color: Colors.grey[300],
      )
    );
  }

  textTitle(){
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

  buildList(){
    return Obx(
      ()=> Positioned(
        top: 180,
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
                // itemCount: getDataController.getDataModel.value.results.length,
                itemCount: getDataController.getDataModel.value.results.length,
                itemBuilder: (context, index) {
                  final pokemon = getDataController.getDataModel.value.results[index];
                  return cardPokemon(
                    index: index,
                    name: pokemon.pokNom,
                    num: pokemon.pokNum,
                    image: !changeImage ? pokemon.pokImg : pokemon.pokImgA,
                    imageError: pokemon.pokImg,
                    type: pokemon.pokTipo,
                    height: pokemon.pokAltura,
                    weight: pokemon.pokPeso,
                    color: determinarColor(pokemon.pokTipo)
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  cardPokemon({
    required String name,
    required String num,
    required String image,
    required String type,
    required String height,
    required String weight,
    required Color color,
    required int index,
    String? imageError
  }){

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5
      ),
      child: InkWell(
        onTap: (){ // esta propiedad es para que al dar clic en la tarjeta se redireccione a la pantalla de detalles

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailsView( 
                index: index,
                nombre: name,
                numero: num,
                imagen: image,
                tipo: type,
                altura: height,
                peso: weight,
                color: color,
              )
            )
          );
        },
        child: SafeArea( // esta propiedad es para que el inkwell no se salga de la pantalla
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                pokeballCard(),
                imagePokemon(index: index, image: image),
                infoPokemon(name: name, type: type),
                numPokemon(num: num),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pokeballCard(){
    return Positioned(
      bottom: -9,
      right: -5,
      child: Image.asset(
        'images/pokeball.png',
        height: 100,
        fit: BoxFit.fitHeight,
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }

  imagePokemon({required int index, required String image, String? imageError}){
    return Positioned(
      bottom: 5,
      right: 5,
      child: Hero(
        tag: index,
        child: CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fitHeight
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
          errorWidget: (context, url, error) {
            print('Error en la imagen $index: $error');
            return const SizedBox(
              height: 80,
              width: 80,
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                )
              )
            );
          }
        ),
      ),
    );
  }

  infoPokemon({required String name, required String type}){
    return Positioned(
      top: 25,
      left: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          namePokemon(name),
          const SizedBox(height: 10),
          typePokemon(type)
        ],
      ),
    );
  }

  namePokemon(String name){
    return SizedBox(
      width: 100,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
  }

  typePokemon(String type){
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

  numPokemon({required String num}){
    return Positioned(
      top: 15,
      right: 25,
      child: Text(
        '#$num',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white.withOpacity(0.6)
        ),
      ),
    );
  }
}