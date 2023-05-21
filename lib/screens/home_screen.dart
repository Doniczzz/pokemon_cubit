import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_cubit/blocs/pokemon_cubit.dart';
import 'package:pokemon_cubit/models/pokemon_model.dart';
import 'package:pokemon_cubit/screens/detail_screen.dart';

import '../models/pokemon_state.dart';

class HomeScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Challenge'),
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pokemon = state.pokemons[index];
                      return ListTile(
                        title: Text(pokemon.name),
                        onTap: () {
                          _navigateToDetailScreen(context, pokemon);
                        },
                      );
                    },
                    childCount: state.pokemons.length,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Failed to fetch pokemons.'),
            );
          }
        },
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, Pokemon pokemon) {
    context.read<PokemonCubit>().fetchPokemonDetails(pokemon.name);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocBuilder<PokemonCubit, PokemonState>(
          builder: (context, state) {
            if (state is PokemonDetailsLoaded) {
              return DetailScreen(pokemon: state.pokemon);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
