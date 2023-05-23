import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_cubit/blocs/pokemon_cubit.dart';
import 'package:pokemon_cubit/models/pokemon_model.dart';
import 'package:pokemon_cubit/screens/detail_screen.dart';

import '../models/pokemon_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonCubit = BlocProvider.of<PokemonCubit>(context);
    final searchController = TextEditingController();

    void searchPokemon(String pokemonName) async {
      await pokemonCubit.fetchPokemonDetails(pokemonName);
      final state = pokemonCubit.state;

      if (state is PokemonDetailsLoaded) {
        // Navigate to the details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(pokemon: state.pokemon),
          ),
        ).then((value) {
          // Fetch all the pokémons again after returning from the details screen
          pokemonCubit.fetchAllPokemons();
        });
      } else {
        // Show an AlertDialog if the Pokémon does not exist
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pokémon Not Found'),
            content:
                Text('The Pokémon with name "$pokemonName" does not exist.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        ).then((value) {
          // Fetch all the pokémons again after closing the AlertDialog
          pokemonCubit.fetchAllPokemons();
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokémon List',
          style: TextStyle(
            fontFamily: 'PokemonSolid',
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Pokémon',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                searchPokemon(value.trim());
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                if (state is PokemonLoaded) {
                  return ListView.builder(
                    itemCount: state.pokemons.length,
                    itemBuilder: (context, index) {
                      final Pokemon pokemon = state.pokemons[index];
                      return Card(
                        color: Colors.red.shade100,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            pokemon.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {
                            searchPokemon(pokemon.name);
                          },
                        ),
                      );
                    },
                  );
                } else if (state is PokemonError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
