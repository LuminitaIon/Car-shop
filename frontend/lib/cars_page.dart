import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myfuturecar/car_type.dart';
import 'package:myfuturecar/constants.dart';

import 'brand.dart';
import 'car.dart';
import 'color.dart';

class CarsPage extends StatefulWidget {
  final int tabNumber;

  const CarsPage({Key? key, required this.tabNumber}) : super(key: key);

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with SingleTickerProviderStateMixin {
  late int currentTab;
  late TabController tabController;
  List<Car>? carsTabList;
  List<CarType>? carsTypeTabList;
  List<Brand>? brandsTabList;
  List<ColorCar>? colorsTabList;
  List<Car>? carsByPowerTabList;
  String dropDownValue = "Normal";
  final controllerText = TextEditingController();
  String gearBox = '';
  bool isTextVisibleGearBox = false;

  apiCalls() async {
    Response response;
    switch (currentTab) {
      case CAR_TAB:
        {
          response = await get(Uri.http(BASE_URL, "/cars"));
          setState(() {
            carsTabList = List<Car>.from(jsonDecode(response.body)["data"]
                .map((model) => Car.fromJson(model)));
          });
          break;
        }
      case CAR_TYPE_TAB:
        {
          response = await get(Uri.http(BASE_URL, "/cars_type"));
          setState(() {
            carsTypeTabList = List<CarType>.from(
                jsonDecode(response.body)["data"]
                    .map((model) => CarType.fromJson(model)));
          });
          break;
        }
      case BRAND_TAB:
        {
          response = await get(Uri.http(BASE_URL, "/brands"));
          setState(() {
            brandsTabList = List<Brand>.from(jsonDecode(response.body)["data"]
                .map((model) => Brand.fromJson(model)));
          });
          break;
        }
      case COLOR_TAB:
        {
          response = await get(Uri.http(BASE_URL, "/colors"));
          setState(() {
            colorsTabList = List<ColorCar>.from(
                jsonDecode(response.body)["data"]
                    .map((model) => ColorCar.fromJson(model)));
          });
          break;
        }
      case POWER_CLASS_TAB:
        {
          if (dropDownValue.isNotEmpty) {
            response = await get(
                Uri.http(BASE_URL, "/power_class/car/$dropDownValue"));
            setState(() {
              carsByPowerTabList = List<Car>.from(
                  jsonDecode(response.body)["data"]
                      .map((model) => Car.fromJson(model)));
            });
          }
          break;
        }
      case MY_GEARBOX_TAB:
        {
          if (controllerText.text.isNotEmpty) {
            response = await get(
                Uri.http(BASE_URL, "/what_gbx_i_have/${controllerText.text}"));
            setState(() {
              gearBox = jsonDecode(response.body)["data"][0]["GEARBOX_CODE"];
              print(gearBox);
              isTextVisibleGearBox = true;
            });
          }
          break;
        }
    }
  }

  @override
  void initState() {
    currentTab = widget.tabNumber;
    super.initState();
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(handleChangeTab);
    tabController.index = currentTab;
    apiCalls();
  }

  handleChangeTab() {
    setState(() {
      currentTab = tabController.index;
      apiCalls();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(CARS_TITLE),
        ),
        body: DefaultTabController(
          length: 6,
          initialIndex: widget.tabNumber,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Cars",
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.pink : Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Car type",
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.pink : Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Brand",
                      style: TextStyle(
                          color: currentTab == 2 ? Colors.pink : Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Color",
                      style: TextStyle(
                          color: currentTab == 3 ? Colors.pink : Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Power class",
                      style: TextStyle(
                          color: currentTab == 4 ? Colors.pink : Colors.blue),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "My gearbox",
                      style: TextStyle(
                          color: currentTab == 5 ? Colors.pink : Colors.blue),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  _buildFirstTab(),
                  _buildSecondTab(),
                  _buildThirdTab(),
                  _buildFourthTab(),
                  _buildFifthTab(),
                  _buildSixthTab(),
                ]),
              )
            ],
          ),
        ));
  }

  _buildFirstTab() {
    return carsTabList != null && carsTabList?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    for (Car car in carsTabList!)
                      TableRow(children: [
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.id}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.model}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.brandCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.year}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.combustibil}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.carType}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.price}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.gearboxCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.km}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.power}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.color}")),
                        ),
                      ])
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  _buildSecondTab() {
    return carsTypeTabList != null && carsTypeTabList?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    for (CarType car in carsTypeTabList!)
                      TableRow(children: [
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.carTypeId}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.carTypeName}")),
                        ),
                      ])
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  _buildThirdTab() {
    return brandsTabList != null && brandsTabList?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    for (Brand brand in brandsTabList!)
                      TableRow(children: [
                        Container(
                          height: 50,
                          child: Center(child: Text("${brand.brandCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${brand.brandName}")),
                        ),
                      ])
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  _buildFourthTab() {
    return colorsTabList != null && colorsTabList?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    for (ColorCar col in colorsTabList!)
                      TableRow(children: [
                        Container(
                          height: 50,
                          child: Center(child: Text("${col.colorCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${col.colorName}")),
                        ),
                      ])
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  _buildFifthTab() {
    return Column(
      children: [
        DropdownButton(
          value: dropDownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue ?? '';
              apiCalls();
            });
          },
          items: <String>['Normal', 'Sport', 'Passion']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        if (carsByPowerTabList != null &&
            carsByPowerTabList?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Expanded(
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    for (Car car in carsByPowerTabList!)
                      TableRow(children: [
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.id}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.model}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.brandCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.year}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.combustibil}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.carType}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.price}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.gearboxCode}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.km}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.power}")),
                        ),
                        Container(
                          height: 50,
                          child: Center(child: Text("${car.color}")),
                        ),
                      ])
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  _buildSixthTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerText,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Input your car ID"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  apiCalls();
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const Center(child: Text("Find")),
                ),
              ),
              Visibility(
                  visible: isTextVisibleGearBox,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        gearBox != "None" ? "Your car has ${gearBox.toString()} gearbox" : "The car id was not found",
                        style: const TextStyle(fontSize: 45,fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
