import 'package:cshannon/components/fourier_lines.dart';
import 'package:cshannon/components/text_builder.dart';
import 'package:cshannon/utils/oscilloscope.dart';
import 'package:flutter/material.dart';



class Fourier2 extends StatefulWidget {
  @override
  _Fourier2State createState() => _Fourier2State();
}

class _Fourier2State extends State<Fourier2> {

  List<WaveController> waves=[];


  List<WaveInfo> _toWaveVals(){
    List<WaveInfo> out = [];
    waves.forEach((w){

      //if(w.isActive)
      out.add(w.toWaveInfo());
    });
    return out;

  }

  @override
  void initState() {
    super.initState();
    [[1.0, 1.0], [2.0,0.5],[3.0, 0.33],[4.0,0.25], [5.0, 0.2]].forEach((initVals){
      print(initVals);
      waves.add(WaveController(initVals[0], initVals[1]));
    });
  }

  @override
  void dispose() {
    
    waves.forEach((wave){
      wave.dispose();
    });
    
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: size.width / 3,
              height: size.height,
              color: Colors.white.withOpacity(0.3),
              child: ListView(
                children: <Widget>[
                  Container(height: 160,width: double.infinity,
                  child: Image.network("https://upload.wikimedia.org/wikipedia/commons/7/72/Fourier_transform_time_and_frequency_domains_%28small%29.gif"),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Center(child:  toRichText({
                                      "token":"#",
                                         "fontSize":18,
                                      "text":
'''Resources:
  -#linkhttps://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/#Interactive Guide to Fourier Transforms#/color##/link#
  -#linkhttp://www.jezzamon.com/fourier/index.html##colorblue#An Interactive Introduction to Fourier Transforms#/color##/link#
  -#linkhttps://www.youtube.com/watch?v=ds0cmAV-Yek##colorblue#Smarter Every Day Video#/color##/link#
  -#linkhttps://www.youtube.com/watch?v=r6sGWTCMz2k##colorblue#3blue1brown Video#/color##/link#
  -#linkhttps://www.youtube.com/watch?v=spUNpyF58BY##colorblue#3blue1brown Video 2#/color##/link#
  -#linkhttps://www.youtube.com/watch?v=Mm2eYfj0SgA##colorblue#Coding Train Video#/color##/link#
  -#linkhttps://www.youtube.com/watch?v=r18Gi8lSkfM##colorblue#Eugene Physics Video#/color##/link#
  '''
                                    }),),
                  ),
               
                ]
               //..addAll(List.generate(waves.length,(i) =>  waves[i].makeRow(setState:()=>setState(() {}), height:80.0, width: size.width / 3)))
              )
          ),
           Expanded(
                  child://Container()
                  FourierLines(
                   waves: _toWaveVals()),
            
           ),

        ],
      ),
    );
  }
 
}

