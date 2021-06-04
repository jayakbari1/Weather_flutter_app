import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

void main()  => runApp(
  MaterialApp(
    title: "Weather App",
    home: Home(),
  )
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var current;
  var humidity;
  var windSpeed;

  Future getWeather() async{
    http.Response response = await http.get("https://api.openweathermap.org/data/2.5/weather?q=Surat&appid=e60912eed6933008cd618e01a3dabb83");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.current = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }
  void initState(){
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Currently in Surat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    temp!=null ? temp.toString() + "\u00B0" : "Can't find data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      current!=null? current.toString() : "Can't find data",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temperature"),
                      trailing: Text(temp!=null ? temp.toString() + "\u00B0" : "Can't find data"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description!=null ? description.toString()  : "Can't find data"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("TemperaHumidityture"),
                      trailing: Text(humidity!=null ? humidity.toString()  : "Can't find data"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("WindSpeed"),
                      trailing: Text(windSpeed!=null ? windSpeed.toString()  : "Can't find data"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}
