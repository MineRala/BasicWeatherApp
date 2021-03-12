import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async{
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=%C4%B0zmir&units=imperial&appid=********************************") ;
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Weather App",),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Currently ın Izmir",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() +"\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                      fontSize: 35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature",style: TextStyle(fontWeight: FontWeight.bold),),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather",style: TextStyle(fontWeight: FontWeight.bold),),
                    trailing: Text(description != null ? description.toString() : "Loading",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity",style: TextStyle(fontWeight: FontWeight.bold),),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed",style: TextStyle(fontWeight: FontWeight.bold),),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
