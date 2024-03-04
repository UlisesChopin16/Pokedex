import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/Models/pokemon_model.dart';

class PokemonController extends GetxController {
  var isLoading = false.obs;
  var getDataModel = GetDataModelPokemons(results: []).obs;

  getDataFromApi() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('http://192.168.1.64/ClaseFlutter/Controller/pokemonc.php?op=listar');
      var response = await http.post(url);
      getDataModel.value = getDataModelPokemonsFromJson(response.body);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}