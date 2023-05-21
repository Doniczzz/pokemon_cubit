import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_cubit/models/pokemon_model.dart';

class PokemonRepository {
  Future<List<Pokemon>> fetchAllPokemons() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1281'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((pokemonData) {
        final String name = pokemonData['name'];
        return Pokemon(
            name: name,
            imageUrl: '',
            ability: '',
            type: '',
            height: '',
            weight: '');
      }).toList();
    } else {
      throw Exception('Failed to fetch pokemons');
    }
  }

  Future<Pokemon> fetchPokemonDetails(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final String name = data['name'];
      final String imageUrl =
          data['sprites']['other']['official-artwork']['front_default'];
      final List<dynamic> abilities = data['abilities'];
      final List pokemonAbilities =
          abilities.map((ability) => ability['ability']['name']).toList();
      final String ability = pokemonAbilities.join(', ');
      final List<dynamic> types = data['types'];
      final List pokemonTypes =
          types.map((type) => type['type']['name']).toList();
      final String type = pokemonTypes.join(', ');
      final String height = data['height'].toString();
      final String weight = data['weight'].toString();

      return Pokemon(
        name: name,
        imageUrl: imageUrl,
        ability: ability,
        type: type,
        height: height,
        weight: weight,
      );
    } else {
      throw Exception('Failed to fetch pokemon details');
    }
  }
}
