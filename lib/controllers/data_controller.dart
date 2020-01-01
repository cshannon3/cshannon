import 'dart:convert';

import 'package:cshannon/utils/model_builder.dart';
import 'package:flutter/services.dart';

class DataController  {
  DataController();
    Future<List<CustomModel>> getDataList(String modelName, String collectionName) async{ //, String source
      List<CustomModel> em = [];
     // print("\n\n\n");
     // print(modelName);
      String data = await rootBundle.loadString("assets/jsons/$collectionName.json");//source
      final jsonData = json.decode(data);
   //  print(jsonData.length);
      jsonData.forEach((item){
        CustomModel cm = CustomModel.fromLib({
         "name": modelName,
         "vars":item
          });
        em.add(cm);
      });
    //  print(em.last.vars);
     // print(em.length);
      return em;
    }

    // Load projects to Firebase
    // Load categories to firebase
    //
}
