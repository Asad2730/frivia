import 'package:flutter/material.dart';
import 'package:frivia/home.dart';
import 'package:frivia/provider/game_provider.dart';


class StartGame extends StatefulWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {

  var difficulties = ['Easy','Medium','Hard'];
  double sliderIndex = 0;
  double? height,width;
  GameProvider? provider;


  void setSlider(double v){
    setState(() {
      sliderIndex = v;
      GameProvider.difficulty = difficulties[v.toInt()];
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Column(
             children: [
               title(),
               subTitle(),
             ],
           ),
            slider(),
            start(),
          ],
        ),
      ),
    );
  }


  Widget slider(){

    return Slider(
      value: sliderIndex,
      max: 2,
      divisions: 2,
      label: difficulties.elementAt(sliderIndex.toInt()),
      onChanged: (v){
        setSlider(v);
      },
    );
  }


  Widget title(){
    return const Text('Trivia',
      style: TextStyle(
          fontSize: 50,color: Colors.white,
          fontWeight:
          FontWeight.w900,
      ),);
  }


  Widget subTitle(){
    return  Text(
      difficulties.elementAt(sliderIndex.toInt()),
      style: const TextStyle(
        fontSize: 20,color: Colors.white,
        fontWeight:
        FontWeight.w900,
      ),);
  }


  Widget start(){
    return MaterialButton(
      color: Colors.blue,
      minWidth: width! * 0.80,
      height: height! *.10,
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GamePage()),
        );
      },
      child: const Text('Start',style: TextStyle(fontSize: 30,color:Colors.white),),
    );
  }

}



