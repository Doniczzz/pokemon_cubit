import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_cubit/blocs/pokemon_cubit.dart';
import 'package:pokemon_cubit/repositories/pokemon_repository.dart';
import 'package:pokemon_cubit/screens/home_screen.dart';

void main() {
  final PokemonRepository pokemonRepository = PokemonRepository();
  runApp(MyApp(pokemonRepository: pokemonRepository));
}

class MyApp extends StatelessWidget {
  final PokemonRepository pokemonRepository;

  const MyApp({super.key, required this.pokemonRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonCubit(pokemonRepository: pokemonRepository)
        ..fetchAllPokemons(),
      child: MaterialApp(
        title: 'Pokémon Challenge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
