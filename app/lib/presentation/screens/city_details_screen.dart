import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CityDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> args;
  const CityDetailsScreen(this.args, {super.key});

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(args['city'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade300, Colors.blue.shade600],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMainTemperature(),
                const SizedBox(height: 32),
                _buildWeatherGrid(),
                const SizedBox(height: 32),
                _buildSunriseSunsetCard(),
                const SizedBox(height: 16),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTemperature() {
    return Center(
      child: Column(
        children: [
          Text(
            '${args['weather'].main.temp.round()}°',
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            args['weather'].weather[0].description,
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '↑ ${args['weather'].main.tempMax.round()}°',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              Text(
                '↓ ${args['weather'].main.tempMin.round()}°',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.7,
      children: [
        _buildInfoCard(
          icon: Icons.water_drop,
          title: 'Humidity',
          value: '${args['weather'].main.humidity}%',
          color: Colors.blue,
        ),
        _buildInfoCard(
          icon: Icons.air,
          title: 'Wind Speed',
          value: '${args['weather'].wind.speed} m/s',
          color: Colors.green,
        ),
        _buildInfoCard(
          icon: Icons.gas_meter,
          title: 'Pressure',
          value: '${args['weather'].main.pressure} hPa',
          color: Colors.purple,
        ),
        _buildInfoCard(
          icon: Icons.cloud,
          title: 'Clouds',
          value: '${args['weather'].clouds.all}%',
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 7, horizontal: 12.0), // Padding réduit
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: color, size: 28), // Taille d'icône légèrement réduite
            const SizedBox(height: 2), // Espacement réduit
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2), // Espacement réduit
            Text(
              value,
              style: const TextStyle(
                fontSize: 18, // Taille de police légèrement réduite
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSunriseSunsetCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSunTime(
              icon: Icons.wb_sunny,
              title: 'Sunrise',
              time: _formatTime(args['weather'].sys.sunrise),
              color: Colors.amber,
            ),
            _buildSunTime(
              icon: Icons.nightlight_round,
              title: 'Sunset',
              time: _formatTime(args['weather'].sys.sunset),
              color: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSunTime({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
