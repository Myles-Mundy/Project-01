/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/


VAR time = 0 //  0 Morning, 1 Noon, 2 Night




VAR torch = ""
VAR hook = ""
VAR goldBar = ""
VAR diamondStatue = ""
VAR rocks = ""
VAR dagger = ""
VAR inventory = 0
VAR tr = 0
VAR sr = 0
VAR dt = 0
VAR dh = 0
VAR dgb = 0
VAR dds = 0
VAR dj = 0
VAR dd = 0
VAR wet = 0
VAR lr = 0
VAR rc = 0

-> cavemouth

== cavemouth ==
You are at the entrance to a cave. {torchpickup: | There is a torch on the floor. } The cave extends to the east and west.
+ {not liteasttunnel or dt == 1} [Take the East Tunnel] -> easttunnel
+ {liteasttunnel && torch != ""} [Take the East Tunnel] -> liteasttunnel
+ [Take the West Tunnel] -> westtunnel
* {inventory <= 2} [Aquire the Majestic Torch] -> torchpickup
* {inventory == 3 && torch == "" && dt == 0} [Aquire the Majestic Torch] -> fullInventory
+ [Check Inventory] -> bag
+ {dt == 1} [Pick up Torch] 
~ dt = 0
~ inventory = inventory + 1
~ torch = "torch"
-> cavemouth
+ {dh == 1 && inventory != 3} [Pick up Grappling Hook] 
~ dh = 0
~ inventory = inventory + 1
~ hook = "Grappling Hook"
-> cavemouth
+ {dgb == 1 && inventory < 2} [Pick up Gold Bar] 
~ dgb = 0
~ inventory = inventory + 2
~ goldBar = "Gold Bar"
-> cavemouth
+ {dds == 1 && inventory <= 1} [Pick up Diamond Statue] 
~ dds = 0
~ inventory = inventory + 3
~ diamondStatue = "Diamond Statue"
-> cavemouth
+ {dj == 1 && inventory <= 1} [Pick up Jewels] 
~ dj = 0
~ inventory = inventory + 3
~ rocks = "Jewels"
-> cavemouth
+ {dd == 1 && inventory <= 2} [Pick up Ritual Dagger]
~ dd = "Ritual Dagger"
~ inventory = inventory +1
~ dd = 0
-> cavemouth
* [Go Home] -> exit
-> END

== bag ==
You currently are holding: {torch} {hook}  {goldBar}  {diamondStatue}  {rocks} {dagger} {torch == "" && hook == "" && goldBar == "" && diamondStatue == "" && rocks == "" && dagger == "": A big bag of nothing}
+ {torch != ""} [Drop Torch]
~ torch = ""
~ inventory = inventory -1
~ dt = 1
-> cavemouth
+ {hook != ""} [Drop Grappling Hook]
~ hook = ""
~ inventory = inventory -1
~ dh = 1
-> cavemouth
+ {goldBar != ""} [Drop Gold Bar]
~ goldBar = ""
~ inventory = inventory -2
~ dgb = 1
-> cavemouth
+ {diamondStatue != ""} [Drop Diamond Statue]
~ diamondStatue = ""
~ inventory = inventory -3
~ dds = 1
-> cavemouth
+ {rocks != ""} [Drop Jewels]
~ rocks = ""
~ inventory = inventory -3
~ dj = 1
-> cavemouth
+ {dagger != ""} [Drop Ritual Dagger]
~ dagger = ""
~ inventory = inventory -1
~ dd = 1
-> cavemouth
+ [Return] -> cavemouth
-> END

== fullInventory ==
You are carrying too much, you must discard some of your items.
+ [Damn]-> cavemouth
-> END

== easttunnel ==
You are in the east tunnel, it is too dark to see anything.
* {torch == "torch"} [Light Torch] -> liteasttunnel
+ [Go Back] -> cavemouth
-> END

== westtunnel ==
You are in the west {not rope && not gold:, there is a minecart in the corner which contains both a bar of gold and a grappling hook.| } {gold && rope && sr == 0: You accidentally bump into the minecart, it shifts greatly revealing a hidden passage underneath it.| {sr == 1: A passage through the floor leads into a ancient altar.}} {not gold && inventory >= 2: There is gold in the minecart but you could not possibly carry it with you right now}
* {inventory <= 1 && not gold} [Take Gold] -> gold
* {not rope && inventory < 3} [Take Grappling Hook] -> rope
+ {gold && rope} [Enter the mysterious passage]
-> altar
+ [Go Back] -> cavemouth
-> END

== rope ==
You now have a rope{torchpickup:, not as majestic as the torch but its close}.
* [Yipeeeeeee] 
~ inventory = inventory + 1
~ hook = "Grappling hook"
-> westtunnel


== gold ==
You now have to carry around a bar of Gold
* [yay? ]
~ goldBar = "Gold bar"
~ inventory = inventory + 2
-> westtunnel
-> END

=== torchpickup ===
You now have a majestic torch, it is incredibly majestic.
+ [Go Back]
~ torch = "torch" 
~ inventory = inventory + 1
-> cavemouth
-> END

== liteasttunnel ==
{not tresherroom: You can see there is a cliff in front of you and a ledge another 20ft away | The treasure room is on the other side of this cliff with the rope from your grappling hook still hanging from the stalagtite.}
* [You can defintely jump it] -> cliffdeath
* { not tresherroom && rope} [Swing over with rope]
~ inventory = inventory -1
~ hook = ""
-> tresherroom
+ {tresherroom} [Swing to the treasure room on the hook] -> tresherroom
+ [Return to entrance] -> cavemouth
-> END

== cliffdeath ==
You could not jump it, you fall for an enitre minute before you splat on the ground.
-> END

== bouldertrap ==
<b> A completely unexpected boulder comes rolling at you !!!!</b>
* [RRRUUUUUUNNNNNNN] -> exit
* [walk] -> boulderdeath
-> END


== boulderdeath ==
The boulder crushes you in an incredibly grusome scene, you survive just long enough to suffer in agony for a few more minutes.
-> END


== tresherroom ==
{tr == 0: You do the sickest indiana jones on a stalagtite to the ledge and find a room full of jewels with a diamond statue in the center of the room on a pedestal. You lose your grappling hook, it got stuck on the stalagtie and now hangs there.| Your rope  hangs from the stalagtite behind you. }{inventory < 1: You dont have the strength to carry anything else out of here.} 
* {inventory <= 1 && dds == 0}[Take the diamond statue, its so worth it] 
~ inventory = inventory + 2
~ diamondStatue = "Diamond Statue"
-> bouldertrap
* {goldBar != ""} [Swap the Gold Bar and the Diamond Statue]
~ goldBar = ""
~ tr = tr + 1
~ diamondStatue = "Diamond Statue"
-> noBoulderTrap
* {inventory <= 1}[Take the jewels and leave {dds == 0:, the statue is an obvious trap}]
~ inventory = inventory + 3 
-> jewels
+ [Swing back to the East Tunnel] 
~ tr = tr + 1
-> liteasttunnel

-> END


== noBoulderTrap ==
You quickly pick up the statue and set down the gold bar in its place, nothing seems to happen.
* [God damn this is heavy] -> tresherroom
-> END

== jewels ==
You pocket as many jewels as you can and swiftley make your escape.
* [I could buy a house with this many jewels]
~ rocks = "jewels"
-> cavemouth
-> END

== altar == 
{sr == 0: You enter a mysterious room with cryptic writing and mysterious symbols lining the walls. There are four statues in each of the corners all with there eyes missing. In the center you see a stone block, on its sides there are carvings dipicting a masked person stabbing the eyes out of someone laying down. | You are in the the seceret room. }
* {rocks != ""} [Fill the statues eyes with the jewels] 
~ rocks = ""
~ time = -0.5
-> river
* {diamondStatue != ""} [Place the Diamond stutue on the stone block.]
~ diamondStatue = ""
-> ritualDagger
+ [Go Back] 
~ sr = sr + 1
-> westtunnel
-> END


== ritualDagger ==
Once you set the stature down the room begins to shift, a wall behind you opens and reveals a decorate dagger on a pedestal
* [Take the Dagger]
~ dagger = "Ritual Dagger"
~ inventory = inventory -1
-> altar
-> END



== river ==
{not bonfire: As you put the last gems in, the floor falls out from under you. A long drop lands you in a river of water and you eventually wash up to a bank. } You are by the river. {wet == 0: You can see the light from a fire around the corner of a tunnel. | You know there is a tunnel somewhere around here but there is no light to guide you.} {risingTides()}
* {time != 3} [Continue following the river, it must flow to an exit] -> swimming
+ {wet == 0 && time != 3} [Follow the light] 
~ lr = 0
-> bonfire
+ {wet == 1 && time != 3} [Go to the bonfire remains]
~ lr = 0
-> bonfire
* {time == 3} [Try to swim up with the water level] -> tideExit
-> END

== tideExit ==
Swim up with the tides and manage to get back in the room you fell down from. You immediatly run away, your life is worth more than this bs.
-> END

== swimming ==
You get back in the river and start swimming. The water is incredibly cold {bonfire: but your time around the fire keeps you warm}.
* {not bonfire && risingTides < 1} [The cold is becoming too much] -> riverDeath
* {bonfire && risingTides < 1 or time > 3} [Push onwards] -> riverExit
* {risingTides >=1} [Push onwards] -> drowning
-> END

== drowning ==
The water level in the cave had risin too much, you watch as the water and the ceiling come together and take your final breath. 
-> END

== bonfire ==
{risingTides()}
{wet != 1:There is a small bonfire in the middle of a room with a corridor leading further into the cave. | There are soaked remains of a fire here and a tunnel going further into the caverns. }
+ {time != 3}[{wet == 0:Take a stick from the fire and }follow the path]
~ lr = 0
-> newTunnel
+ {time != 3}[Rest and Return to the River] -> river
+ {wet == 0 && time != 3} [Sit by the fire] -> bonfire
* {time == 3} [Try to swim up with the water level] -> drowning
+ {wet == 1 && time != 3} [Sit by the fire's watery remains] -> bonfire
-> END

== newTunnel ==
You start moving through the narrow passage. { risingTides() } {time < 2 or time > 3 && time < 5: There is a sudden drop in front of you, and you cant jump to the other side. | The water is high enough that you must start swimming through it. } 
+ {time >= 2 && time != 3 && lr == 0} [Swim through the rest of the passage]
~ lr = 1
-> opening
+ {time >= 2 && time != 3 && lr == 1} [Swim through the rest of the passage]
~ lr = 0
-> bonfire
+ {time >= 2 && time != 3 && lr == 1} [Swim back to the clearing] -> opening
+ {time < 2 && time != 3 && lr == 1} [Return to the clearing] -> opening
+ {time >= 2 && time != 3 && lr == 0} [Swim back to the bonfire] -> bonfire
+ {time < 2 && time != 3 && lr == 0} [Return to the Bonfire] -> bonfire
+ {time == 3} [Try to swim up with the water level] -> drowning
-> END

== opening == 
You are in a giant room full of abandoned stone houses going all the way up to the ceiling with a giant hole at the very top filling the cavern with light. {risingTides()}

* {time == 3 && not fail} [Try and swim out through the opening at the top of the cavern] -> fail
+ {time == 3 && fail} [Wait out the tides] -> opening
+ {time != 3} [Explore the ruins] -> ruins
+ {time != 3} [Return to the passage] -> newTunnel

-> END

== fail ==
You swim upwards with the rising water but it does not get you anywhere close enough to the opening in the ceiling
{risingTides()}
+ [Wait for the tides to return] -> opening
-> END


== ruins ==
{risingTides()}
You are in the lowest home in the ruins. {rc != 1: There is another above this one but the stairs leading to it have collapsed. You can see the water line from the previous high tide end just above the highest point in this house. There is also a hole in the top of this room that could be used to enter home above this one.}

+ {time == 3} [Swim through the hole to the next level up] 
~ rc = 1
-> ruinslv2
+ {time != 3} [Return to the main clearing] 
~ rc = 1
-> opening
+ {time != 3} [Wait for the tides to shift] 
~ rc = 1 
-> ruins
+ {time != 3} [Look around] 
~ rc = 1
-> ruinslv1
-> END

== ruinslv1 == 
The floor of this place is muddy and slick, not much light makes it in here. There are no man made abjects here, just rocks and some scraps of plants. It was most likely just put here to hold up the levels above it.
+ [Sick] -> ruins
-> END

== ruinslv2 ==
{risingTides()}
You are in the second level of houses. This room contains plenty of useful materials such as food, a lit fire, and a sort of bed made out of piles of plants. You wonder who lit this fire, it had to be recently.

* [Camp out here and wait for help] -> camping
+ {time == 3 or time == 3.5} [Wait for the Tides to shift] -> ruinslv2
+ {time != 3 && time != 3.5} [Drop down to the previous floor] -> ruins
-> END

== camping ==
You eat some of the food you don't recognize and lay down to sleep. Its been a long day and you deserve some rest.

* [ZZZzzzz] -> camprock
-> END

== camprock ==
You are suddenly starteled awake as an unknown figure starts dragging you to the hole in the room, you fall through and land in the floor below you. At this point you realize there is a heavy rock tied to your leg, you wont be able to swim when the tide comes up.

* [Accept your fate] -> campdeath
* {ritualDagger != ""} [Cut the rope with the dagger] -> survivor
->END

== campdeath ==
You sit in silence as the water slowly climbs up your body, there's nothing you can do anymore.
-> END

== survivor == 
You pull out your dagger and free yourself from the rock.
* [Go back and fight] -> fight
* [Run away] -> runEND
-> END

== fight ==
You wait for the tide to rise and swim up to the second floor, you do not see anyone there.
* [Stay your ground and wait for the person to return] -> waitDeath
* [Search the room] -> inspector
-> END

== waitDeath == 
You stand in the corner of the room holding the dagger in your hand while staring at the hole in the floor. As time passes you slowly drift into sleep. You never wake up.
-> END

== inspector == 
The room contains 4 {not potsdes: clay pots full of various plants along the north wall| gross pots}, on the east wall is a {not chimmney: chimmney with a small fire still lit| sus chimmney}. Right behind you on the west wall is a {not beddes: bed made out of a pile of plant life. | sucky bed.}
+ [inspect the pots] -> potsdes
+ [inspect the chimmney] -> chimmney
+ [inspect the bed] -> beddes
-> END

== chimmney ==
You look in the chimmney, there are marks going up it where the soot and ash has been wiped away.
* [climb the chimmney] -> climbing
+ [keep looking around] -> inspector
-> END

== climbing ==
You put out the fire and start climbing up the chimmney, once you reach the top, you see 3 figures standing the in woods outside.
* [watch and wait] -> listening
* [ATTAAAACCCCKKKKK] -> attack
-> END

== listening ==
You cant hear anything that they are saying, eventually they start walking away. You wait until they wont hear you climbing out the rest of the way.
* [continue on] -> chase
-> END

== attack ==
You run at the three people with a dagger, you now recognize the one who attacked you as the biggest among them, standing to the sides him are 2 smaller people, though still more muscular than you.
* [Get revenge] -> revenge
* [go for the small fries] -> myaveragemcdonaldsorder

== revenge ==
You run and stab the largest man, while he falls to the ground you dont stop attacking, the other two try and pull you off of him, hitting and kicking, but yuo wont let up. After whal feels like an eternity one of them tackles you off of him and wrestles the dagger away from you, suddenly you feel a sharp pain in your chest.
-> END

== myaveragemcdonaldsorder ==
You stab one of the smaller men in their throat before they have a chance to react, now the the larger one stands between you and the other person.
* [Kill him] -> middle
* [Go around and attack] -> goAround

== goAround ==
You attempt to run around the man and attack again but he knocks you to the ground with a powerful punch, while you are trying to stand back upm the last thing you see is him in front of you holding a rock over his head.
-> END

== middle ==
You send your blade into the mans heart, the person behind him is screamingand runs away, you move to chase him but your dagger is stuck.
* [Free the dagger] -> freeDagger
* [Chase him down] -> chase
-> END

== freeDagger ==
You yank on your dagger until finnally you feel it becomes loose, just then you realize the man was not dead yet. He grabs you and runs both of you into the hole that let light into the cave ruins below. You splashing into the water and lose concuisness for a breif second. You find yourself underwater and try to swim back up but thee man is holding your legs together. You can't breathe and you can't move, all thats left is the unyeilding pain.
-> END

== chase ==
{not listening: You run after them but quickly lose sight,| you lose sigh of them as they pass through some dense folliage, } you try and follow the direction you saw them heading for a while but never see a trace. You look around and you have no idea where you are, you attmpt to retrace yuor steps but everything looks the same. Over the course of severall weeks, you starve to death never finding your way back. 
-> END


== potsdes ==
You move the four pots from the wall and look inside them, the bottoms are soaking with water and crawling with bugs.
+ [Gross] -> inspector
-> END

== beddes ==
Its a pretty sucky bed
+ [boooo] -> inspector
-> END

== runEND ==
You run out to the clearing and back through the passage as fast as you could, for a moment you heard footsteps following but they stopped once you reached the river. With all the strength your had left, you swam down it as fast as you could until you passed out waking up in a hospital. The dagger should be able to pay for 10% of the total bill.

-> END



== riverDeath ==
The cold sets in,  you cant move anymore. You concuiussness drifts into nothing as you sink to the bottom of the cave. 
-> END

== riverExit ==
You finnally see a light after an hour of swimming, you climb out of the river onto dry land in the middle of the forest. You didn't make it out with much but you at least still have your life.
-> END

== function risingTides ==
    ~ time = time + 0.5
    
    {
        - time > 6:
            ~ time = 0
    }    
    {
        - time > 3:
            ~ wet = 1
    }
    
    {    
        - time == 0:
            ~ return "You can hear the water from the river starting to rise"
        
        - time == 1:
            ~ return "The water keeps rising, you need to get to higher ground"
        
        - time == 3:
            ~ return "The water is at its peak right now"
            
        - time == 4:
            ~ return "The water has started to lower"
            
        - time == 5:
            ~ return "The water has mostly receeded"

        - time == 6:
            ~ return "The water is at its lowest right now"
    
    
    
    }




== exit ==
{rocks == "jewels" && ritualDagger == "Ritual Dagger": You manage to make it out with enough money to buy over $7. You could have bought a lot of more valuable things but the seven dollar bill seemed worth it. | {rocks == "jewels": With all the money you have managed to obtain from the jewels, you buy yourself a nice modest house out on the countryside and live happily ever after. | { diamondStatue == "Diamond Statue": You run all the way out of the cave without looking back. Although you could carry it out of the cave, you struggle to get it any farther during your walk back to civilization. Over the course of the next week you continue trying to get it back so you can make money but you have exhausted yourself, you die starving in the woods before you could cash it in | {goldBar != "": The gold bar was a nice haul but it didn't get you as much as you though it would, it got you about a month of rent before you were back on the streets, homeless again. | {rope != "" && not tresherroom: When you get back you try and make of this excurshion what you can, you sell the rope for five buckaroonies. Thats 2 whole boxes of tic tacs. | } } } } } {torchpickup && diamondStatue == "": You find out that your majestic torch was so majestic that a collector is willing to buy it for a BILLION TRILLION DOLLARS, but you know that some thing are with more than any amount of money so you keep it.| } 
{not torchpickup && rocks == "" && diamondStatue == "" && goldBar == "" && rope == "" && ritualDagger == "": You return to the bridge you have been living under for the past five years with the emptiest of hands, maybe its for the best, you would have just gambled it all away again anyway. | }
-> END





















