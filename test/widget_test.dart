// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adoption_app/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/presentation/bloc/pet_list_bloc.dart';
import 'package:pet_adoption_app/presentation/bloc/adoption_cubit.dart';
import 'package:pet_adoption_app/presentation/bloc/favorites_cubit.dart';
import 'package:pet_adoption_app/data/datasources/pet_data_source.dart';
import 'package:pet_adoption_app/data/repositories/pet_repository_impl.dart';
import 'package:pet_adoption_app/domain/usecases/get_pets.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('HomePage displays search bar and pet cards',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AdoptionCubit()),
            BlocProvider(create: (_) => FavoritesCubit()),
            BlocProvider(
              create: (_) => PetListBloc(
                GetPets(PetRepositoryImpl(PetDataSource())),
              )..add(const LoadPetsEvent()),
            ),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
    });
  });
}
