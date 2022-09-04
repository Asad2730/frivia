import 'package:flutter/material.dart';
import 'package:frivia/provider/game_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {

  double? height,width;
  GameProvider? provider;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (_context) => GameProvider(context: context),
        child: _buildUI(),
    );
  }

  Widget _buildUI(){
    return Builder(
      builder: (_context) {
        provider = _context.watch();
        if(provider?.questions != null){
          return Scaffold(
            body:SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: height! * 0.05,),
                child: _gameUI(),
              ),
            ),
          );
         }
        else{
          return const Center(
            child: CircularProgressIndicator(color: Colors.white,),
          );
        }
        }
    );
  }

  Widget _gameUI(){
    return Column(
      mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _question(),
        Column(
          children: [
            _trueBtn(),
            SizedBox(height: height! *0.01,),
            _falseBtn(),
          ],
        ),
      ],
    );
  }


  Widget _question(){
    return  Text(
        provider!.getCurrentQuestionText(),
      style: const TextStyle(
          color:Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 25,
      ),
    );
  }


  Widget _trueBtn(){
    return MaterialButton(
        onPressed: ()=>provider!.answerQuestion('True'),
      color: Colors.green,
      minWidth: width! * 0.80,
      height: height! *.10,
      child: const Text('True',
        style:TextStyle(
        color:Colors.white,
        fontSize: 25,
      ),
      ),
    );
  }

  Widget _falseBtn(){
    return MaterialButton(
      onPressed: ()=>provider!.answerQuestion('False'),
      color: Colors.red,
      minWidth: width! * 0.80,
      height: height! *.10,
      child: const Text('False',
        style:TextStyle(
          color:Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}

