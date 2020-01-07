
import 'package:cshannon/audio/audio_controller.dart';
import 'package:cshannon/audio/audio_player_interface.dart';
import 'package:cshannon/screens/rap_pad/verse.dart';
import 'package:flutter/material.dart';

class RapPad extends StatefulWidget {
  RapPad({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RapPadState createState() => new _RapPadState();
}

class _RapPadState extends State<RapPad> {
  List<Verse> verses=[];
  AudioPlayerController ap;
  int currentVerse=0;
  
  //                      [ a  aa  e   ee     i    ii    o   oo   u  uu other u(put), oo soon, aw dog oi join, ow down]

 // static const platform = const MethodChannel('com.cshannon.rappadf/spotify');
  List<TextSpan> formattedLyrics(int _versenum) {
    String lyrics = verses[_versenum].lyrics;
    String currentstring = "";
    List<TextSpan> results = [];
    for (int i = 0; i < lyrics.length; i++) {
      if (!vowels.contains(lyrics[i])) {
        currentstring += lyrics[i];
      } else {
        if (currentstring != "") {
          results.add(TextSpan(
            text: currentstring,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                color: Colors.white), // Text S
          ));
          currentstring = "";
        }
        results.add(TextSpan(
          text: lyrics[i + 1].toUpperCase(),
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: vowelColors[vowels.indexOf(lyrics[i])],
              // background: Paint()
              //   ..color = vowelColors[vowels.indexOf(lyrics[i])]
              //   ..strokeCap=StrokeCap.round
              //   ..strokeWidth=5.0,
              color: vowelColors[vowels.indexOf(lyrics[i])]
              ), // Text S
        ));
        i += 1;
      }
      if (i == lyrics.length - 1 && currentstring != "") {
        results.add(TextSpan(
          text: currentstring,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
              color: Colors.white), // Text S
        ));
      }
    }
    return results;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  void initState() {
    super.initState();
    verses=testVerses.where((v)=>v.isReady).toList();
    ap=AudioPlayerController.asset("assets/audio/black_thought_backagain_2.wav");
    ap.initialize();
  }
  
  play(int verse) async{
   String audioAsset =  verses[verse].audioclipAsset;
   
  if(verse== currentVerse){
      if(ap.value.isPlaying)ap.pause();
      else ap.play();
  }else{
    currentVerse=verse;
   // ap.pause();
   // ap.dispose();
    ap=AudioPlayerController.asset("assets/audio/$audioAsset");
    await ap.initialize();
    ap.play();

  }
  }
  //  if(verse!=currentVerse){
  //    ap=AudioPlayerController.asset("assets/audio/$audioAsset");
     
  //  }
     
  //     ap.play();
  // }


  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
         color: Colors.grey.withOpacity(0.8),
         borderRadius: BorderRadius.circular(20.0)
      ),
      child: new ListView(
              children: []..addAll(List.generate(verses.length, (_verse) {
                  return 
                  ExpansionTile(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: RichText(
                          text: TextSpan(
                              text: "", //verses[_verse].lyrics,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black), // Text Style
                              children: formattedLyrics(_verse)), // Text Span
                          textAlign: TextAlign.center,
                        ), // Rich Text
                      ), // Container
                    ],
                    leading: IconButton(
                      icon: Icon(Icons.play_circle_filled),
                      onPressed: () {
                     //TODO
                     //print("press");
                    // ap.play();
                    
                       
                    play(_verse);
                      },
                    ),
                    title: Container(
                        height: 70.0,
                        child: Column(
                          children: <Widget>[
                            Text(verses[_verse].audioclipAsset.substring(
                                0,
                                verses[_verse]
                                    .audioclipAsset
                                    .lastIndexOf("_"))),
                            Text(verses[_verse].songName),
                            Text(verses[_verse].artistName),
                          ],
                        )),
                
                  );
                }))
        
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

// class SongSearch extends SearchDelegate<String> {
//   Verse chosen_verse;
//   List<IconData> searchOptions = [Icons.album, Icons.music_note, Icons.radio];
//   int searchIndex = 0;

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(searchOptions[searchIndex % searchOptions.length]),
//         onPressed: () {
//           searchIndex += 1;
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return MusicScreen(
//       song: chosen_verse,
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = verses
//         .where((_verse) => (searchIndex % searchOptions.length == 0)
//             ? _verse.songName.toLowerCase().startsWith(query.toLowerCase())
//             : (searchIndex % searchOptions.length == 1)
//                 ? _verse.artistName
//                     .toLowerCase()
//                     .startsWith(query.toLowerCase())
//                 : _verse.lyrics.contains(query))
//         .toList();

//     return ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) => GestureDetector(
//               onDoubleTap: () {
//                 chosen_verse = suggestionList[index];
//                 showResults(context);
//               },
//               child: ExpansionTile(
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.all(10.0),
//                     child: RichText(
//                       text: TextSpan(
//                           text: "", //verses[_verse].lyrics,
//                           style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.w300,
//                               color: Colors.black), // Text Style
//                           children: formattedLyrics(
//                               suggestionList[index].lyrics)), // Text Span
//                       textAlign: TextAlign.center,
//                     ), // Rich Text
//                   ), // Container
//                 ],
//                 leading: IconButton(
//                   icon: Icon(Icons.play_circle_filled),
//                   onPressed: () {
//                     //TODO
//                    // Flame.audio.play(suggestionList[index].audioclipAsset);
//                   },
//                 ),
//                 title: Container(
//                     height: 70.0,
//                     child: Column(
//                       children: <Widget>[
//                         Text(suggestionList[index].audioclipAsset.substring(
//                             0,
//                             suggestionList[index]
//                                 .audioclipAsset
//                                 .lastIndexOf("_"))),
//                         Text(suggestionList[index].songName),
//                         Text(suggestionList[index].artistName),
//                       ],
//                     )),
//                 trailing: IconButton(
//                   icon: Icon(Icons.play_circle_filled),
//                   onPressed: () {
//                     //TODO
//                    // Flame.audio.play(suggestionList[index].audioclipAsset);
//                   },
//                 ),
//               ),
//             ));
//   }

//   List<TextSpan> formattedLyrics(String lyrics) {
//     //String lyrics = verses[_versenum].lyrics;
//     String currentstring = "";
//     List<TextSpan> results = [];
//     for (int i = 0; i < lyrics.length; i++) {
//       if (!vowels.contains(lyrics[i])) {
//         currentstring += lyrics[i];
//       } else {
//         if (currentstring != "") {
//           results.add(TextSpan(
//             text: currentstring,
//             style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w300,
//                 color: Colors.black), // Text S
//           ));
//           currentstring = "";
//         }
//         results.add(TextSpan(
//           text: lyrics[i + 1].toUpperCase(),
//           style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.w500,
//               background: Paint()
//                 ..color = vowelColors[vowels.indexOf(lyrics[i])],
//               color: Colors.black), // Text S
//         ));
//         i += 1;
//       }
//       if (i == lyrics.length - 1 && currentstring != "") {
//         results.add(TextSpan(
//           text: currentstring,
//           style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.w300,
//               color: Colors.black), // Text S
//         ));
//       }
//     }
//     return results;
//   }
// }
