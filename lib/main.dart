import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_api_client.dart';
import 'package:weather/views/additional_info.dart';
import 'package:weather/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("mumbai");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: Color(0xFFf9f9f9),
          elevation: 0.0,
          title: const Text(
            "Weather App",
            style: TextStyle(color: Colors.cyan, fontSize: 24),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // custom widget
                  currentWeather(
                      Icons.wb_sunny, "${data!.temp}", "${data!.cityName}"),
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  additionalInfo("${data!.wind}", "${data!.humidity}",
                      "${data!.pressure}", "${data!.feels_like}")
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}
