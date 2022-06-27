import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/Models/WeatherModel.dart';
import 'package:weatherapp/States/WeatherStates.dart';

import '../Repos/WeatherRepo.dart';

class WeatherEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent{
  final _city;

  FetchWeather(this._city);

  @override
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent{

}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{

  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());

  @override
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    if(event is FetchWeather){
      yield WeatherIsLoading();

      try{
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      }catch(_){
        print(_);
        yield WeatherIsNotLoaded();
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }

}