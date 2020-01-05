
import 'package:cshannon/controllers/data_controller.dart';
import 'package:cshannon/controllers/scale_controller.dart';
import 'package:cshannon/data/projects_data.dart';
import 'package:cshannon/screens/paint.dart';
import 'package:cshannon/screens/screens.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:flutter/material.dart';

class StateManager extends ChangeNotifier {
  DataController dataController = DataController();
 
  String currentRoute = "/";
  ScaleController sc;
  Widget currentScreen=Container();

  StateManager();

    Map<String, dynamic> dataMap={
    "projects":{"name":"project", "collection_name": "projects", "models":projects,},
    "books":{"name":"book", "collection_name": "books", "models":[],},
    "quotes":{"name":"quote", "collection_name": "quotes", "models":[],},
    "categories":{"name":"category", "collection_name": "categories", "models":[],},
    "sites":{"name":"site", "collection_name": "sites", "models":[],},
    "youtube":{"name":"youtube", "collection_name": "youtube", "models":[],},
  };
  List<CustomModel> getModels(String key)=>(dataMap.containsKey(key) &&dataMap[key]["models"].isNotEmpty)?dataMap[key]["models"] 
    :[];
  List<CustomModel> getAllModels(){
    List<CustomModel> cm=[];
      cm.addAll(dataMap["projects"]["models"]);
      cm.addAll(dataMap["books"]["models"]);
      cm.addAll(dataMap["sites"]["models"]);
      cm.addAll(dataMap["youtube"]["models"]);
   
    return cm;
    }

  Future<void> initialize(/*Firestore _db,*/) async {
    // List k = dataMap.keys.toList();
    // int l=dataMap.keys.length;
    // for (int i=0; i<l;i++){
    //   List<CustomModel>m=await dataController.getDataList(dataMap[k[i]]["name"], dataMap[k[i]]["collection_name"])

    // }
    dataMap.forEach((key, dataInfo) async{
      if(dataMap[key]["models"].isEmpty)
        dataMap[key]["models"]= await dataController.getDataList(dataMap[key]["name"], dataMap[key]["collection_name"]);
    });
   
    //notifyListeners();
  }
  
  Map<String, dynamic> routes = {
    "/": (StateManager m) =>new HomePage(m),
    "/fourier": (StateManager m) =>new  Fourier2(m),
    "/guiboxes": (StateManager m) =>new  GuiScreen2(m),// MyMainApp(),
    "/paint": (StateManager m) =>new  PaintDemo(),// PaintDemo(),
    "/music": (StateManager m) =>new  PianoScreen(),
    "/quotes": (StateManager m) =>new  Quotes(m),
    "/books":(StateManager m) =>new  Books(m),
    "/essays": (StateManager m) =>new  Essays(m),
    "/sites":(StateManager m) =>new   Bubbles(m, "sites"),
    //"/bbooks":(StateManager m) =>  Bubbles(m, "books"),
    //"/people":(StateManager m) => Container()
  };
  setScale(Size screenSize){
    if(sc==null)sc=ScaleController(screenSize);
    else sc.rescale(screenSize);

    notifyListeners();
  }
  Widget getScreen() {
    
    currentScreen= routes[currentRoute](this);
    return currentScreen;
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