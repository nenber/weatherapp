import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';
import 'package:weatherapp_neosilver/data/models/city.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({Key? key}) : super(key: key);

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _cityController = TextEditingController();
  Timer? _debounce;
  List<City> suggestions = [];
  @override
  void dispose() {
    _debounce?.cancel();
    _cityController.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CityBloc>().add(SearchCityEvent(city: query));
    });
  }

  void _onCitySelected(BuildContext context, City city) {
    // Affiche un message de sélection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text('City "${city.city}" added!')),
    );

    // Ajoute la ville via le bloc
    context.read<CityBloc>().add(AddCityEvent(city: city));

    // Réinitialise le champ de texte
    _cityController.clear();
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
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Search City',
                border: OutlineInputBorder(),
                helperText: "You must enter at least 3 characters",
              ),
              onChanged: (query) => _onSearchChanged(context, query),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CityBloc, CityState>(
                builder: (cxt, state) {
                  print(state);
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
                            itemCount: suggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(suggestions[index].city),
                                subtitle:
                                    Text("${suggestions[index].citycode}"),
                                onTap: () => _onCitySelected(
                                    context, suggestions[index]),
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
