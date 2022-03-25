import 'package:bmi/result.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = false;
  double heightVal = 170;
  double weight = 55;
  int age = 18;
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Mass Index"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    buildm(context, 'male'),
                    const SizedBox(
                      width: 15,
                    ),
                    buildm(context, 'female'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Height',style: Theme.of(context).textTheme.headline2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(heightVal.toStringAsFixed(1),style: Theme.of(context).textTheme.headline1,),
                          Text('CM',style: Theme.of(context).textTheme.bodyText1,)
                        ],
                      ),
                      Slider(min:60,max:220,value: heightVal, onChanged:(newValue){
                        setState(() {
                          heightVal=newValue;
                        });

                      }),

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    buildm1(context, 'age'),
                    const SizedBox(
                      width: 15,
                    ),
                    buildm1(context, 'weight'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: Colors.teal,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 12,
                child: TextButton(
                  onPressed: () {
                    result = weight / pow(heightVal / 100, 2);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Result(
                              result: result,
                              isMale: isMale,
                              age: age,
                            )));
                  },
                  child: Text(
                    'Calculate',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildm1(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              type == 'age' ? 'Age' : 'Weight',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(type == 'age' ? '$age' : '${weight.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.headline1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age++ : weight++;
                    });
                  },
                  child: Icon(Icons.add),
                  mini: true,
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                ),
                const SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age-- : weight--;
                    });
                  },
                  child: Icon(Icons.remove),
                  mini: true,
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildm(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (type == 'male') ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ((type == 'male' && isMale == true) ||
                    (type == 'female' && !isMale))
                ? Colors.teal
                : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                (type == 'male') ? Icons.male : Icons.female,
                size: 90,
                color: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(type == 'male' ? 'Male' : 'Female',
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),
        ),
      ),
    );
  }
}
