import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfuturecar/cars_page.dart';
import 'package:myfuturecar/constants.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(HOME_TITLE),
    ),
    body: Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(right:70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: CAR_TAB)));
                      },
                      child: Container(
                        width: 210,
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Center(child: Text("Cars",style: TextStyle(fontSize: 45),))),
                    ),
                    SizedBox(width: 40,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: COLOR_TAB)));
                      },
                      child: Container(
                        width: 210,
                        decoration: BoxDecoration(color: Colors.blue),
                          child: Center(child: Text("Colors",style: TextStyle(fontSize: 45),))),
                    ),
                  ],),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: CAR_TYPE_TAB)));
                      },
                      child: Container(
                          width: 210,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Center(child: Text("Car type",style: TextStyle(fontSize: 45),))),
                    ),
                    SizedBox(width: 40,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: POWER_CLASS_TAB)));
                      },
                      child: Container(
                          width: 280,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("Power class",style: TextStyle(fontSize: 45),)),
                          )),
                    ),
                  ],),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
              child: Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: BRAND_TAB)));
                      },
                      child: Container(
                          width: 210,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Center(child: Text("Brand",style: TextStyle(fontSize: 45),))),
                    ),
                    SizedBox(width: 40,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CarsPage(tabNumber: MY_GEARBOX_TAB)));
                      },
                      child: Container(
                          width: 280,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("My gearbox",style: TextStyle(fontSize: 45),)),
                          )),
                    ),
                  ],),
              ),
            )
          ],
        ),
      ) ,),);
  }

}