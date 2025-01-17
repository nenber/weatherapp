import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_neosilver/blocs/city/city_bloc.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({super.key});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final TextEditingController _cityController = TextEditingController();
  Timer? _debounce;
  bool _isLoading = false;

  void dispose() {
    _debounce?.cancel();
    _cityController.dispose();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      context.read<CityBloc>().add(SearchCityEvent(city: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        if (state is CityLoadingState) {
          _isLoading = true;
        } else {
          _isLoading = false;
        }

        return TextField(
          enabled: !_isLoading,
          controller: _cityController,
          decoration: InputDecoration(
            labelText: 'Search City',
            border: OutlineInputBorder(),
            helperText: "You must enter at least 3 characters",
            suffixIcon: IconButton(
              icon: Icon(Icons.gps_fixed),
              onPressed: () {
                context.read<CityBloc>().add(GetCityByCoordinatesEvent());
              },
            ),
          ),
          onChanged: (query) => _onSearchChanged(context, query),
        );
      },
    );
  }
}
