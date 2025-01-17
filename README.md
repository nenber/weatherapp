# Weather app working on android and ios

# to use the whole app

 - add you weather api key in 'app/.env' from [openweathermap.org](https://openweathermap.org)
 - run pub get
 - flutter run
 
 # to use only the component
 The component "weather_component" provides 3 features : 
 

> you need to provide an api key to use it

 
 **- WeatherBuilder** allow you to wrap any widget to provide weather datas from city name and manage states while fetching the api (*builder*, *errorBuilder*, *loadingBuilder*)
**- Search by city name** allow you to search any city in france by city name
**- Search by coordinates** allow you to search any city in france by coordinates
# How to use it
Here's an example

    return ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (ctx, index) {
                  return WeatherBuilder(
                    city: state.cities[index].name,
                    apiKey: apiKey!,
                    builder: (context, weather) {
                      return ListTile(
                        title: Text(state.cities[index].name),
                        subtitle: Text("${weather.main.humidity}% humidity"),
                        trailing: Text("${weather.main.temp}°C"),
                        leading: weather.clouds.all > 50
                            ? const Icon(Icons.cloud)
                            : const Icon(Icons.sunny),
                      );
                    },
                    loadingWidget: const Center(child: Text("No data")),
                    errorBuilder: (context, error) {
                      return ListTile(
                        title: Text(state.cities[index].name),
                        subtitle: Text(
                          'An error occured while fetching data \n $error',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        leading: const Icon(Icons.error, color: Colors.red),
                      );
                    },
                  );
                },
              );
