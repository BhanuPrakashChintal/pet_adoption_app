import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/favorites_page.dart';
import 'presentation/pages/history_page.dart';
import 'presentation/bloc/adoption_cubit.dart';
import 'presentation/bloc/favorites_cubit.dart';
import 'presentation/bloc/pet_list_bloc.dart';
import 'data/datasources/pet_data_source.dart';
import 'data/repositories/pet_repository_impl.dart';
import 'domain/usecases/get_pets.dart';

void main() {
  runApp(const PetAdoptionApp());
}

class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AdoptionCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider(
          create: (_) => PetListBloc(
            GetPets(
              PetRepositoryImpl(PetDataSource()),
            ),
          )..add(const LoadPetsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Pet Adoption App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const FavoritesPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
