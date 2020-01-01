
import 'package:cshannon/controllers/animation_controller.dart';
import 'package:cshannon/controllers/data_controller.dart';
import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/data/bubble_data.dart';
import 'package:cshannon/models/category_bubble.dart';
import 'package:cshannon/models/item_node.dart';
import 'package:cshannon/screens/screens.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:cshannon/utils/utils.dart';
import 'package:flutter/material.dart';

class StateManager extends ChangeNotifier {
  DataController dataController = DataController();
  AnimController animController= AnimController();
 
  String currentRoute = "/";
  ScaleController sc;

  StateManager();

    Map<String, dynamic> dataMap={
    "projects":{"name":"project", "collection_name": "projects", "models":[],},
    "books":{"name":"book", "collection_name": "books", "models":[],},
    "quotes":{"name":"quote", "collection_name": "quotes", "models":[],},
    "categories":{"name":"category", "collection_name": "categories", "models":[],},
    "nodes":{"name":"node", "collection_name": "nodes", "models":[],},
  
  };
  List<CustomModel> getModels(String key)=>(dataMap.containsKey(key) &&dataMap[key]["models"].isNotEmpty)?dataMap[key]["models"] 
    :[];
  
  

  Future<void> initialize(/*Firestore _db,*/) async {
    // List k = dataMap.keys.toList();
    // int l=dataMap.keys.length;
    // for (int i=0; i<l;i++){
    //   List<CustomModel>m=await dataController.getDataList(dataMap[k[i]]["name"], dataMap[k[i]]["collection_name"])

    // }
    dataMap.forEach((key, dataInfo) async{
      dataMap[key]["models"]= await dataController.getDataList(dataMap[key]["name"], dataMap[key]["collection_name"]);

    });
   
    //notifyListeners();
  }
  
  Map<String, dynamic> routes = {
    "/": (StateManager m) => HomePage(m),
    "/fourier": (StateManager m) => Fourier2(),
    "/guiboxes": (StateManager m) => Container(),// MyMainApp(),
    "/paint": (StateManager m) => Container(),// PaintDemo(),
    "/music": (StateManager m) => PianoScreen(),
    "/quotes": (StateManager m) => Quotes(m),
    "/books":(StateManager m) => Books(m),
    "/essays": (StateManager m) => Essays(m),
    "/sites":(StateManager m) =>  Bubbles(m),
    //"/people":(StateManager m) => Container()
  };


  setScale(Size screenSize){
    if(sc==null)sc=ScaleController(screenSize);
    else sc.rescale(screenSize);
    notifyListeners();
  }
  Widget getScreen() {
    return routes[currentRoute](this);
  }
  

  changeScreen(String route) {
    if (routes.containsKey(route)) {
      currentRoute = route;
      notifyListeners();
    }
  }

}






 //  dataMap["books"]["models"]= await dataController.getDataList("book", "assets/jsons/book.json");//quotesList 
    //dataMap["books"]["quotes"]= await dataController.getDataList("quote", "assets/jsons/quotes.json");
//"blogs":{"name":"blog", "collection_name": "blogs", "models":[],}
 
  //List<CategoryBubble> categories=[];
  //List<ItemNode> items=[];

  //List<CustomModel> bookList = List();
  //List<CustomModel> quotesList = List();