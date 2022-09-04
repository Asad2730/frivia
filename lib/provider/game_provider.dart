import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frivia/start.dart';

//https://opentdb.com/api.php?amount=10&difficulty=easy&type=boolean
class GameProvider extends ChangeNotifier{

  final dio = Dio();
  final amount = 10;
  List? questions;
  int currentQuestionCount = 0;
  static var difficulty = '';
  int correct = 0;

  BuildContext context;
  GameProvider({required this.context}){
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestion();
  }


  Future _getQuestion() async{
     var response = await dio.get('',queryParameters: {
       'amount':amount,
       'type':'boolean',
       'difficulty': difficulty.toLowerCase(),
     });

     var data = jsonDecode(response.toString());
     questions = data['results'];
     //print(questions);
    notifyListeners(); //to tell providers that change has occur & reload
  }


 String getCurrentQuestionText(){

    return questions![currentQuestionCount]['question'];
  }

  Future answerQuestion(String answer) async{

    bool isCorrect = questions![currentQuestionCount]['correct_answer'] == answer;
    currentQuestionCount++;
   showDialog(context: context, builder:(BuildContext build){
     return AlertDialog(
       backgroundColor: isCorrect?Colors.green:Colors.red,
       title:Icon(isCorrect?Icons.check_circle:Icons.cancel_sharp,color: Colors.white,),
     );
   });

   if(isCorrect){
     correct++;
   }

  await Future.delayed(const Duration(seconds: 1));
   Navigator.pop(context);

   if(currentQuestionCount == amount){
     endGame();
   }else{
     notifyListeners();
   }


  }


  Future endGame() async {
    showDialog(context: context, builder:(BuildContext build){
      return  AlertDialog(
        backgroundColor:Colors.blue,
        title:const Text('EndGame !',style:TextStyle(fontSize: 25,color: Colors.white),),
        content:Text('$correct/10') ,
      );
    });

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context); //removes alert
    Navigator.pop(context); //removes GamePage()
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartGame()),
    );
  }

}