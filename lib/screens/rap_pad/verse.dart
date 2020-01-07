import 'package:flutter/material.dart';

final List<String> vowels = [
  "~", // a cat
  "@", // aa cake
  "_", // e bed
  "#", // ee keep
  "%", // i sit
  "^", // ii bike
  "<", // o top
  "&", // oo home
  ">", // u sun
  "*", // uu cute
  "/", // other u put
  "=", // oo soon
  "[", // aw dog
  "]", // oi join
  "+" // ow down
];
final List<Color> vowelColors = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.lightGreenAccent,
  Colors.blue,
  Colors.lightBlue,
  Colors.yellow,
  Colors.indigo,
  Colors.purple,
  Colors.deepPurpleAccent,
  Colors.amber,
  Colors.cyan,
  Colors.grey,
  Colors.lightGreenAccent,
  Colors.teal,
];


class Verse {
  final String artistName;
  final String songName;
  final String audioclipAsset;
  final String lyrics;
  final List<String> rhymingvowels;
  bool isReady=false;

  Verse(
      {this.artistName,
      this.songName,
      this.audioclipAsset,
      this.lyrics,
      this.rhymingvowels, this.isReady=false});
}

final List<Verse> testVerses = [
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_sorry_for_loss.wav",
    lyrics:
        "Uh, Im s[orry for your l[oss, Its a b[ody dead in the car and its probly one of your, "
        "The writing all across the window and the walls,Whether it was true or false, "
        "we shouldnt have got involved",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_backagain_2.wav",
    isReady: true,
    lyrics:
        "Pr#e-K~ard~ash%i~an K~any@e,\n M^y rh^yme-pl@ay %imm~ac*ul~ate\n S@ame c@ad~ence ~as D.&O.#C\n Pr#e-~acc%id~ent,\n "
        "M@ayb#e m^y ac*umen &on p~ar w%ith\n K*ool #G  R~ap and them\n G%ive m#e the pr&oper r#espect M&otherf*ucka\n w#e b~ack ag@ain",
    // "Pre-Kardashian Kanye My rhyme-play immaculate Same cadence as D.O.C Pre-accident, Maybe my acumen on par With Kool G  Rap and them Give me the proper respect Mu'f*cka we back again",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_builtitlastyear_2.wav",
    lyrics: "Got my crown tilted, my gown quilted Silk with cashmere, "
        "burn a room down in a minute Built it last year, \n"
        "newsflash I dodged a bullet that killed the cashier "
        "My homie told me to come with him to the mass chair ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_circumcise_2.wav",
    lyrics:
        "I s#ee intruders, avert your ey#es I t&old yo*u k#eep out of the hood,"
        " circumsize How could you sleep I thought you always was the first to ride "
        "Ay yo you heard the line,",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_exceptiontotherule_2.wav",
    lyrics:
        "Ay yo you heard the line, 'everybody plays the fool?' Well I will be that exception to the rule"
        " The principal that hand deliver lessons to the school I was making major moves "
        "My dollar deja vu My mission when my ambition was brandishing the tool to be an icon",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_farfrominspired_2.wav",
    lyrics: "For a couple things we lost in the fire The drive, "
        "a desire to perform on a higher plateau "
        "I am at that show lost in a Maya "
        "Wondering how he got so far from inspired",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_guildedcage_2.wav",
    lyrics:
        "Them brothers said don't go from written bars filled with rage To primetime television, "
        "and you guilded cage Then forget it's people in the world still enslaved "
        "I barb-wired my wrist, and let it fill the page",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_hearld_2.wav",
    lyrics: "C~atch the h_er~ald I !am fr_esh chopped, a B_ev@el R~ap "
        "on a doctrine l_evel so _F. Scott Fitzger~ald "
        "Maybe I am the new Rakim Maybe I am fat Pharaohe "
        "Undergarments of armor be my intimate apparel",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_herown_2.wav",
    lyrics: "Look, when photos was sepia-toned "
        "And record-players was something you would keep in ya home "
        "Yo the traveller the meaning of Tariq he was known "
        "For the exemplary performance, uniquely his own",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_icon_2.wav",
    lyrics: "to be an icon Wearing slippers made of python "
        "Getting mine quicker 'cuz I am slick as a pipeline",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_ironchair_2.wav",
    lyrics: "Gunfire and flares, sirens glare Im in an iron chair "
        "with people who care Don't get the lion's share "
        "When I don't give a f*ck then I ain't fair I am on a higher tier "
        "where people getting money like the financier",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_jesusandjudas_2.wav",
    lyrics: "Fools swear they wise Wise men know they foolish "
        "But we was heading for the web even before computers "
        "I never thought you'd give me a reason to do this Cain and Abel, "
        "Jesus and Judas Caesar and Brutus I see intruders, avert your eyes "
        "I told you keep out of the hood, circumsize"
        " How could you sleep I thought you always was the first to ride",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_remember_2.wav",
    lyrics: "remember,We walked past the teacher take the chalk and laugh, "
        "We wrote punishments I'll not talk in class,"
        "Now it's pistols punishing people for talking fast."
        "And all these innocent bystanders is hauling ass",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_toil_2.wav",
    lyrics: "'cuz I am slick as a pipeline Transportin' the oil, "
        "tribulation and toil hit the operation "
        "But I am back on the soil",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_amalgamism_2.wav",
    lyrics: "I made the 21-pound for some a new found religion "
        "When money's put down, it's only one sound to make "
        "O.G's and young lions equally proud to listen "
        "The secret almalgamism a algorithm ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_asbabies_2.wav",
    lyrics: "The anomaly swore solemnly, "
        "high snobiety Freakonomics of war policy, dichotomy "
        "That's Heaven and Hades Tigris and Euphrates "
        "His highness The apple of the iris of to you ladies As babies",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_klamar_2.wav",
    lyrics:
        "I got that detox for y'all The microphone Doctor Black Deepak Chopra"
        " I am a griat that make you wanna peacock your arm "
        "Every heavy dignitary paying me top regards "
        "Boy I am three ocular far From ya binoculars "
        "So that smart money 'finna get the heat out the car "
        "Yo I am K-dot-Lamar meets 2Pac Shakur Got profiled by a few cops,"
        " too hot to charge",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_plasmashed_2.wav",
    lyrics: "Somebody said a price tag was on a rapper's head"
        " So we gon' see a nice bag when a rapper dead"
        " The mast black, the flag green, black and red "
        "They will probaly wave a white flag after plasma shed",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_onroute_2.wav",
    lyrics: "No doubt, yo the game went they own route"
        " I can't explain what these lame kids is talking 'bout "
        "Or how they fit they whole foot into they own mouth "
        "I put a couple bodies in a brown bag Then I am on route ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_sizeeight_2.wav",
    lyrics: "I am sneaker-shopping with my son in size 8 "
        "Prior to they release, 'cuz why wait? "
        "Look, in my estate I got electrified gates"
        " For these blase guys hatin' at a high rate "
        "'Cuz I dodged fate, then got great The fly straight"
        " If we ain't family or friends, then we don't vibrate, "
        "and I am that Gun in y'all face, none of y'all safe If I catch you at the right time in the wrong place, slippin' "
        "Sippin' on something with a strong taste Like whiskey or bootleg Bourbon with a corn base My Levante",
    rhymingvowels: [],
  ),
  
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    audioclipAsset: "black_thought_threat_2.wav",
    lyrics:
        "My Levante resemble a vehicular threat The mic I spray, resembling a sickle of death "
        "It ain't strenuous to come from a continuous breath I set fire to the venue,"
        " I am a spin you in step Rinse, repeat!",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    isReady: true,
    audioclipAsset: "black_thought_soundofthebeast_2.wav",
    lyrics:
        "st_ep R%inse, rep#eat!\n You ch_eckin' for the s+ound of the b#eats\n I am the h+ound,"
        " I am a cr#eep,\n I get d+own, I am a #eat\n I am a k#eep something to l@ay a n@ay-s@ayer to sl#eep\n Pl@aying with h#eat,\n "
        "n&obody and n>oth%ing f>uck%ing w%ith 'R#iq\n Y&o th#ese w#eakl%ings %is cl@aim%ing th@ey c>utt%ing >up %in the str#eet\n N%igg>a p#eace, "
        "yo*u @ain't working with n<oth%ing but the polic#e,\n listen You ain't finna be nothing but the dec#eased,\n "
        "listen You in a turn and him with a permanent cr#ease",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    isReady: true,
    audioclipAsset: "black_thought_rapfigures_2.wav",
    lyrics:
        "I str^ike f_ear in the hearts of r~ap f%igures\n Who m^ind b_ear the stigmas of t^ime,\n "
        "no bl~ack pr%ivilege From boom-blap niggas,\n to trap niggas You in the trap with us,\n "
        "where the lions is as Vivid as the walls on the graph\n Or the graph by the Lord of Wrath\n "
        "I reside between the seconds on the chronograph\nHow much more CB4 can we afford?\n"
        "It's like a Sharia law on my My Cherie Amour\n How much hypocrisy can people possibly adore \n"
        "But ain't nobody working on a cure?\n My young boy ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Black Thought",
    songName: "Flex Freestyle",
    isReady: true,
    audioclipAsset: "black_thought_nevertheless_2.wav",
    lyrics: "Y'all just r_egul~ar, I am ~a @Ap_ex Pr_ed~at~or\n"
        " Brim st@ay fr_esh, f_eath~ered up, _etc_eter~a N_everth~eless,\n "
        "I got a message and left One dead messenger,\n "
        "yep My pen is Henry Kissinger, Buzz Bissinger\n",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Capital Steez",
    songName: "Free the Robot",
    audioclipAsset: "free_the_robot - cagedin_2.wav",
    lyrics:
        "I'm comin' through r@ag%in' And I won't stop 't%il R@eag@an is c@aged %in"
        " Mom tell me I should let the Lord handle it "
        "The arm of the law is tryin' to man-handle us A man's world,"
        " but a white man's planet And the doors are slowly closing while we fallin' through the cracks of it "
        "It's a shame that flippin' crack will be The best alternative "
        "if you don't make it rappin' These crack houses and trap houses are trappin' us in"
        " And in the end we're gonna remain stagnant ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Capital Steez",
    songName: "Free the Robot",
    isReady: true,
    audioclipAsset: "free_the_robot - fastway_2.wav",
    lyrics: "Cause I want mine the f~ast w@ay The ski m~ask w@ay,\n"
        "look%in' for a f~ast p@ay And instead of st%ick%in' >up for each <oth_er \n"
        "We p%ick%in' >up g>uns and st%ick%in' >up our br<oth_ers\n",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Capital Steez",
    songName: "Free the Robot",
    isReady: true,
    audioclipAsset: "free_the_robot - pushingcrack_2.wav",
    lyrics:
        "No disrespect to the man or the l_eg%end,\n but I'm s%ick and t^ired of ask%in' m^y br_ethr%en \n"
        "if It all _ends %in tw=o thousand #el_ev%en\n W/ould G<od c<ome thr=ough or w/ould h#e actuall#y forg_et >us?\n"
        "Ca>use, apocalypse %is gett%ing cl&os>er\n But they're more focused on our l%il youth s%ipp%in' s&od>a \n"
        "Fuck the s/ug~ar ~act,\n n%igg~as out p/ush%in' cr~ack\n ~And ^I lost m^y f~ather f%igure bec~ause of th~at\n",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Capital Steez",
    isReady: true,
    songName: "Free the Robot",
    audioclipAsset: "free_the_robot - stevieblind_2.wav",
    lyrics: "Illumin<at#i try^in' to r#ead m^y m^ind with a #eagle ^eye\n"
        "And the haze got m#e thinkin',wh^y W#e killed Osama and plent#y innocent p#eople d^ied\n"
        "W#e should s#ee the s^igns, but w#e St#evi#e bl^ind",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Capital Steez",
    songName: "Free the Robot",
    isReady: true,
    audioclipAsset: "free_the_robot - thundersound_2.wav",
    lyrics: "So can I live, or is m^y br>other tr^yin' to g>un m#e d+own?\n"
        "Sc>uffle a co>uple of r+ounds 'til w#e hear the th>under s+ound\n"
        "N&o l^ightn%ing, cl~ash of the t^it%ans And ~after the v^iol~ence a m&oment of s^il~ence",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    audioclipAsset: "paper_trails - empanadas_2.wav",
    lyrics:
        "Balenciagas, balance my soccer with the henny agua Me and my niggas tryna eat, "
        "you pussies empanada The flow like plenty lava With just a penny "
        "I could multiply my worth And make you work for me for twenty hours",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    isReady:  true,
    audioclipAsset: "paper_trails - ipromise_2.wav",
    lyrics:
        "into the ch@amb_er, g_et hyp_erb<ol%ic\nTh@ey r@ais%in' m~ax,\n ^I r@aise st@akes to keep the br<ol%ic"
        " M^y b%itch%es %is m~acroc<osm%ic,\n p~ass the chr<on%ic The m~astered s<on%ics\n %is l%ightyears ab<ove your c<onsc%ious\n"
        "You're n&ov^ice,\n b>ut I g<ot n&otes th~at str^ike nerves\n ^I pr<omise your m^inds ain't sharp l%ike m%y swords ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    audioclipAsset: "paper_trails - plottin_2.wav",
    lyrics: "Sitting back plotting, jotting information on my nation "
        "Really started from the bottom, boy, cotton But they still planting plantations, "
        "we keep buying in Closed-minded men, pride is higher than the prices on your pradas",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    audioclipAsset: "paper_trails - position_2.wav",
    lyrics: "I swear these niggas wanna copy, thanks for listening "
        "This kid ain't been the same since Biggie smacked me at my christening "
        "Watch your tradition and please play it safe Cause your position on the top "
        "is switching right in front your face Rocking on this bass with rhymes,"
        " I'm bustin' out He duckin' down, got some issues now, headed for your house ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    audioclipAsset: "paper_trails - prose_2.wav",
    lyrics:
        "So put the pistols down, got that red dot on your nose Who put the clown on lock, jaws "
        "like the blue knows Froze, keep your mouth closed or you can see the soap, "
        "dog I got connections that guaranteed to see closed doors You hear that underground sonar "
        "The way I flows, this wisdom The Pros been on a mission Listen ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass",
    songName: "Paper Trails",
    audioclipAsset: "paper_trails_ps.wav",
    lyrics:
        "So cut the BS, and don't worry where my jeans is And PS: Your bitch a genius, "
        "learnt from my penis I got dreams filling arenas and breaking brackets "
        "Tend this racket, while I'm cracking a Serena God damn, "
        "God bless the heaven that sent you But now I'm breezing out, baby, cause my rent's due",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass and Capital Steez",
    songName: "Survival Tactics",
    audioclipAsset: "survival_tactics - comicon_2.wav",
    lyrics:
        "Fuckin' ridiculous Finger to the president screamin', Fuck censorship!"
        " If Obama got that president election Then them P.E. boys bout to make an intervention "
        "Fuck what I once said, I want the blood shed "
        "'Cause now-a-days for respect you gotta pump lead "
        "I guess Columbine was listenin' to Chaka Khan "
        "And Pokémon wasn't gettin' recognized at Comic-Con",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass and Capital Steez",
    songName: "Survival Tactics",
    audioclipAsset: "survival_tactics - fewguns_2.wav",
    lyrics: "It's like 6 milli ways to die my nigga choose one "
        "Doomsday comin' start investin' in a few guns New gats, booby traps, and bazooka straps "
        "Better play your cards right, no booster packs "
        "Everybody claim they used to rap But these ain't even punchlines no more,"
        " I'm abusing tracks Leaving instrumentals blue and black I'm in Marty McFly mode,"
        " so tell em' that the future's back Riding on hoverboards, "
        "wiping out motherboards Stopped spitting fire 'cause my motherfuckin' lung is scorched"
        " King Arthur when he swung his sword A king author "
        "I ain't even use a pen in like a month or four",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass and Capital Steez",
    songName: "Survival Tactics",
    audioclipAsset: "survival_tactics - institution_2.wav",
    lyrics:
        "It's like we've been content with losin' And half our students fallen victim to the institution"
        " Jobs are scarce since the Scientific Revolution "
        "And little kids are shootin' Uzi's 'cause its given to 'em Little weapon, "
        "code name: Smith and Wesson And you'll be quick to catch a bullet "
        "like an interception If your man’s tryna disrespect "
        "it Send a message and it's over in a millisecond—nigga",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Joey Badass and Capital Steez",
    songName: "Survival Tactics",
    audioclipAsset: "survival_tactics - intelligence_2.wav",
    lyrics: "Niggas don't want war—I'm a martian, with an army of spartans "
        "Sparring with a knife in a missile fight Get your intel right; "
        "your intelligence is irrelevant But it's definite; "
        "I spit more than speech impediments Brooklyn's the residence, "
        "the best and it's evident We got them niggas P-E-Nuts—like they elephants",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself - amplifiedbythe_2.wav",
    lyrics: "But I kept rhymin' and stepped right in the next cypher "
        "Best believe somebody's payin' the Pied Piper "
        "All the pain inside amplified by the Fact that I can't get by with my nine-to- Five "
        "and I can't provide the right type of life for my family "
        "'Cause man, these goddamn food stamps don't buy diapers "
        "And there's no movie, there's no Mekhi Phifer, this is my life",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself - backtoreality_2.wav",
    lyrics:
        "Snap back to reality, ope there goes gravity, ope There goes Rabbit, "
        "he choked, he's so mad but he won't Give up that easy, no, he won't have it, "
        "he knows His whole back's to these ropes, it don't matter, "
        "he's dope He knows that but he's broke, he's so stagnant,"
        " he knows When he goes back to this mobile home, "
        "that's when it's Back to the lab again yo, this whole rhapsody "
        "Better go capture this moment and hope it don't pass him",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself - booedoffstage_2.wav",
    lyrics: "No more games, I'ma change what you call rage "
        "Tear this motherfuckin' roof off like two dogs caged "
        "I was playin' in the beginning, the mood all changed "
        "I've been chewed up and spit out and booed off stage ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself - failuresnot_2.wav",
    lyrics: "too much for me to wanna Stay in one spot, "
        "another day of monotony's Gotten me to the point I'm like a snail,"
        " I've got To formulate a plot or end up in jail or shot "
        "Success is my only motherfuckin' option—failure's not "
        "Mom, I love you, but this trailer's got To go; "
        "I cannot grow old in Salem's Lot So here I go,"
        " it's my shot: feet, fail me not This may be the only opportunity that I got ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself - gettingevenharder_2.wav",
    lyrics: "And these times are so hard, and it's gettin' even harder "
        "Tryna feed and water my seed, plus teeter-totter "
        "Caught up between bein' a father "
        "and a prima donna Baby mama drama, screamin' on her, ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    audioclipAsset: "lose_yourself -palmssweaty _2.wav",
    lyrics:
        "His palms are sw_eaty, kn#ees w#eak, arms are heavy There's vomit on his sweater already:"
        " Mom's spaghetti He's nervous, but on the surface he looks calm and ready"
        " To drop bombs, but he keeps on forgetting What he wrote down,"
        " the whole crowd goes so loud He opens his mouth, but the words won't come out "
        "He's choking, how? Everybody's joking now The clock's run out, time's up, over—blaow!",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Eminem",
    songName: "Lose Yourself",
    isReady: true,
    audioclipAsset: "lose_yourself - soulsescaping_2.wav",
    lyrics:
        "His s&oul's esc@aping thr*ough this h&ole\n that is g@aping This world is mine for the t@aking,\n"
        " m@ake me king \nAs we m*ove t]oward a New World ]Order\n A n]ormal life is b]oring;\n"
        "but superstardom's Cl&ose to p&ost-m]ortem,\n it &only gr&ows h<arder H&omie gr&ows h<otter,\n"
        " he bl&ows, it's <all &over\n These h&oes is <all on him, c&oast-to-c&oast sh&ows\n "
        "He's kn&own as the Gl&obetr<otter, l&onely r&oads G<od &only kn&ows,\n he's gr&own farther from h&ome, "
        "he's n&o father\n He g&oes h&ome and barely kn&ows his &own daughter\n But h&old your n&ose,"
        " 'cause here g&oes the c&old water These\n h&oes d&on't want him n&o m&o', "
        "he's c&old pro<duct\n They moved on to the next schm&oe who fl&ows\n "
        "He n&ose-d&ove and s&old nada,\n and s&o the s&oap opera Is t&old,\n it unf&olds, "
        "I supp&ose it's &old, partner\n But the beat g&oes on:\n "
        "da-da-dom, da-dom, dah-dah, dah-dah",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    isReady: true,
    audioclipAsset: "maad_city - backnine_2.wav",
    lyrics:
        "I w>as n%ine Joey p~acked th>e n%ine\n P~akist~an on every p+orch %is f%ine\n "
        "We ad~apt to cr%ime,\n p~ack a v~an with\n f+our guns ~at ~a t%ime",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    audioclipAsset: "maad_city - doctor_2.wav",
    lyrics:
        "With dreams of being a lawyer or doctor Instead of boy with a chopper"
        "that hold the cul de sac hostage Kill them all if they gossip, "
        "the Children of the Corn They realizing the option of living a lie, "
        "drown their body with toxins Constantly drinking and drive, "
        "hit the powder then watch this flame That arrive in his eye; "
        "this a coward, the concept is aim and They bang it and slide out that bitch with deposits "
        "And the price on his head, the tithes probably go to the projects",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    audioclipAsset: "maad_city - gotugly_2.wav",
    lyrics:
        "It was Me, O-Boog, and Yaya, YG Lucky ride down Rosecrans It got ugly, "
        "waving your hand out the window. Check yo self Uh, warriors and Conans "
        "Hope euphoria can slow dance with society The driver seat the first one to get killed ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    isReady: true,
    audioclipAsset: "maad_city - jumpintheseat_2.wav",
    lyrics: "If I told you I k%illed a n%igga at 16, would you b#eli#eve m#e?\n"
        " Or s#ee m#e to b#e innocent Kendrick that you s#een %in the str#eet\n"
        " With a basketb[all and some Now and Laters to #eat\n"
        " If I m_ention_ed [all of my sk_el_etons, would you jump in the s#eat?\n"
        " Would you s@ay my int_ellig_ence now is gre@at reli#ef?\n"
        "And it's s@afe to s@ay that our n_ext g_ener@ation m@ayb#e can sl#e#ep\n"
        "W%ith dr#eams of b#eing a lawyer or doctor\ ",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    audioclipAsset: "maad_city - memorylane_2.wav",
    lyrics: "Br@ace yourself, I'll t@ake you on a trip down mem&ory l@ane "
        "This is not a rap on how I'm slingin cr~ack or move c&oc@aine "
        "This is cul-de-s~ac and plenty C&ogn~ac and m#ajor p#ain Not the drill sergeant, "
        "but the stress that w@eighing on your brain",
    rhymingvowels: [],
  ),
  Verse(
    artistName: "Kendrick Lamar",
    songName: "MAAD City",
    isReady: true,
    audioclipAsset: "maad_city - punk_2.wav",
    lyrics: " W%ith the sliding d&oor, f>uck #is >up? F>uck yo*u sh*oot%in'\n"
        "f&or %if yo>u ain't walk%in >up yo*u f>uckin' p>unk?\n"
        "P%ick%in' >up the f>uck%in' p>ump P%ick%in' [off you s>uckers,\n"
        "s>uck a d%ick &or die &or s>ucker p>unch A w[all >of bullets c>om%in' fr>om",
    rhymingvowels: [],
  ),
];
