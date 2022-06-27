// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Blocs/WeatherBloc.dart';
import 'Models/WeatherModel.dart';

class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  ShowWeather(this.weather, this.city);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(weather.getImage),
          fit: BoxFit.cover),
      ),
          padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/3,),
              Text(city,style: const TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),

              Text("${weather.getTemp.round()}C",style: const TextStyle(color: Colors.white70, fontSize: 50),),
              const Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("${weather.getMinTemp.round()}C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Min Temperature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("${weather.getMaxTemp.round()}C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Max Temperature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("${weather.getPressure.round()} mb",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Pressure",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("${weather.getHumidity.round()}%",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Humidity",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                  },
                  color: Colors.lightBlue,
                  child: const Text("Search", style:   TextStyle(color: Colors.white70, fontSize: 16),),

                ),
              )
            ],
          )
      );
  }
}