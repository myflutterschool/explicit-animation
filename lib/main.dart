import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const ExplicitAnimationPage(),
    );
  }
}
class ExplicitAnimationPage extends StatefulWidget {
  const ExplicitAnimationPage({Key? key}) : super(key: key);
  //explicit animation use animation with animation controller
  //animation controller controls the animation, like start / stop and repeat the animation and bunch of other things

  @override
  _ExplicitAnimationPageState createState() => _ExplicitAnimationPageState();
}
//because use two animation controller
class _ExplicitAnimationPageState extends State<ExplicitAnimationPage>with TickerProviderStateMixin {
  late AnimationController firstAnimationController;
  late AnimationController secondAnimationController;
  late CurvedAnimation firstCurveAnimation;
  late CurvedAnimation secondCurveAnimation;

  @override
  void initState() {
    firstAnimationController=AnimationController(vsync: this,duration: const Duration(seconds: 4));
    secondAnimationController=AnimationController(vsync: this,duration: const Duration(seconds: 4));

    firstCurveAnimation=CurvedAnimation(parent: firstAnimationController, curve: Curves.easeIn);
    secondCurveAnimation=CurvedAnimation(parent: secondAnimationController, curve: Curves.easeIn);

    firstAnimationController.repeat();
    secondAnimationController.repeat();

        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animation'),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.apps_sharp,size: 32,color: Colors.blue,),
        onPressed:(){
          setState(() {
            if(firstAnimationController.isAnimating&&secondAnimationController.isAnimating){
              firstAnimationController.stop();
              secondAnimationController.stop();
            }else{
              firstAnimationController.repeat();
              secondAnimationController.repeat();
            }
          });
        } ,
      ),
      body: _animationView(),
    );
  }
  Widget _animationView()=>Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Colors.lightGreen,
    child: Center(
      child: Row(children: [
        RotationTransition(
            turns: Tween<double>(begin: 1,end: 0).animate(firstCurveAnimation),
          alignment: Alignment.center,
          child: const Icon(
            Icons.settings,
            size: 200,
            color: Colors.deepPurple,
          ),
        ),
        RotationTransition(
          turns: Tween<double>(begin: 0,end:1).animate(secondCurveAnimation),
          alignment: Alignment.center,
          child: const Icon(
            Icons.settings,
            size: 200,
            color: Colors.deepPurple,
          ),
        ),
      ],),
    ),
  );
}


