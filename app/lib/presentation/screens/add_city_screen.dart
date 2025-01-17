import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';
import 'package:weather_component/src/models/city_model.dart';
import 'package:weatherapp_neosilver/presentation/widgets/search_textfield.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({Key? key}) : super(key: key);

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen>
    with AutomaticKeepAliveClientMixin {
  List<City> suggestions = [];
  @override
  void _onCitySelected(BuildContext context, City city) {
    // Affiche un message de sélection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text('City "${city.name}" added!')),
    );

    // Ajoute la ville via le bloc
    context.read<CityBloc>().add(AddCityEvent(city: city));

    // Réinitialise le champ de texte
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextFieldWidget(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CityBloc, CityState>(
                builder: (cxt, state) {
                  if (state is CityLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CityErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is CitySearchListState) {
                    suggestions = state.cities;
                    return suggestions.isEmpty
                        ? const Center(
                            child: Text(
                              'No suggestions available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: suggestions.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Material(
                                  elevation: 4,
                                  color: Colors.white,
                                  shadowColor: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    title: Text(suggestions[index].name),
                                    subtitle:
                                        Text("${suggestions[index].state}"),
                                    onTap: () => _onCitySelected(
                                        context, suggestions[index]),
                                  ),
                                ),
                              );
                            },
                          );
                  }
                  return const Center(
                    child: Text(
                      'No suggestions available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
