
import 'package:cshannon/utils/main_animator.dart';
import 'package:cshannon/utils/model_builder.dart';
import 'package:cshannon/utils/oscilloscope.dart';
import 'package:flutter/material.dart';


class FourierLines extends StatelessWidget {
    final double line1Len;
    final List<WaveInfo> waves;

  FourierLines({ 
  this.line1Len=120.0,
  this.waves
   });
  @override
  Widget build(BuildContext context) {
    
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    CustomModel fourierLines = CustomModel.fromLib2(
      {"name":"fourierLines",
      "vars":{
        "stepPerUpdate":2.5,
        "thickness":20.0,
      }
      }
      );
      fourierLines.vars["lines"]=[];
      if(waves!=null && waves!=[]){
        fourierLines.vars["lines"].add(CustomModel.fromLib2("line2d_length_${line1Len *waves[0].amp}_node_0_root_freqMult_${waves[0].freq}_color_random"));
        for (int i=1; i<waves.length; i++)
          fourierLines.vars["lines"].add(CustomModel.fromLib2("line2d_length_${line1Len*waves[i].amp}_node_${i}_freqMult_${waves[i].freq}_color_random_conNode_${i-1}"));
        
      }
     
    return  Container(
      height: h,
      width: w,
      child: MainAnimator(
            model: fourierLines,
            painted: true,
          ),
    );
  }
}