import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_cubit/blocs/pokemon_cubit.dart';
import 'package:pokemon_cubit/models/pokemon_model.dart';

import '../models/pokemon_state.dart';

class DetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Detail'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<PokemonCubit, PokemonState>(
              builder: (context, state) {
                if (state is PokemonDetailsLoaded && state.pokemon == pokemon) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ability: ${state.pokemon.ability}'),
                      const SizedBox(height: 8),
                      Text('Type: ${state.pokemon.type}'),
                      const SizedBox(height: 8),
                      Text('Height: ${state.pokemon.height}'),
                      const SizedBox(height: 8),
                      Text('Weight: ${state.pokemon.weight}'),
                    ],
                  );
                } else if (state is PokemonError) {
                  return const Text('Failed to fetch Pokémon details');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Regresar a la pantalla anterior
          Navigator.pop(context);

          // Actualizar el estado de PokemonCubit y recuperar la lista de pokémones
          context.read<PokemonCubit>().fetchAllPokemons();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
