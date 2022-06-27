// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/ShowWeatherPage.dart';
import 'package:weatherapp/Blocs/WeatherBloc.dart';
import 'package:weatherapp/States/WeatherStates.dart';
import 'Repos/WeatherRepo.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[900],
        body: BlocProvider(
          create: ( context) => WeatherBloc(WeatherRepo()),
          child: SearchPage(),
        ),
      )
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            if(state is WeatherIsNotSearched) {
              return Container(
                padding: const EdgeInsets.only(left: 32, right: 32,),
                child: Column(
                  children: <Widget>[
                    const Text("Enter city to show", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    const Text("Weather Details", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: cityController,

                      decoration: const InputDecoration(

                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),

                      ),
                      style: const TextStyle(color: Colors.white70),

                    ),

                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: (){
                          weatherBloc.add(FetchWeather(cityController.text));
                        },
                        color: Colors.lightBlue,
                        child: const Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                      ),
                    )

                  ],
                ),
              );
            } 
            else if(state is WeatherIsLoading) {
              return const Center(child : CircularProgressIndicator());
            } 
            else if(state is WeatherIsLoaded){
              return ShowWeather(state.getWeather, cityController.text);
            }
            else{
              return const Text("Error",style: TextStyle(color: Colors.white),);
              }
          },
        )

      ],
    );
  }
}