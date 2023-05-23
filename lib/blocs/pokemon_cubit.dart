import 'package:bloc/bloc.dart';
import 'package:pokemon_cubit/models/pokemon_model.dart';
import 'package:pokemon_cubit/repositories/pokemon_repository.dart';
import 'package:pokemon_cubit/models/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final PokemonRepository _pokemonRepository;
  Pokemon?
      selectedPokemon; // Nuevo atributo para almacenar el Pokémon seleccionado

  PokemonCubit({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository,
        super(PokemonInitial());

  Future<void> fetchAllPokemons() async {
    try {
      final List<Pokemon> pokemons =
          await _pokemonRepository.fetchAllPokemons();
      emit(PokemonLoaded(pokemons));
    } catch (e) {
      emit(const PokemonError('Failed to fetch pokemons'));
    }
  }

  Future<void> fetchPokemonDetails(String pokemonName) async {
    try {
      final Pokemon pokemon =
          await _pokemonRepository.fetchPokemonDetails(pokemonName);
      selectedPokemon = pokemon; // Actualiza el Pokémon seleccionado
      emit(PokemonDetailsLoaded(pokemon));
    } catch (e) {
      emit(const PokemonError('Failed to fetch pokemon details'));
    }
  }
}
