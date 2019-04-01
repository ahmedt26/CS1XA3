import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url
import String
import Random

main : AppWithTick () Model Msg
main = appWithTick Tick
       { init = init
       , update = update
       , view = view
       , subscriptions = subscriptions
       , onUrlRequest = MakeRequest
       , onUrlChange = UrlChange
       }  


type alias Model = { time : Float -- x and ys are coordinate stuff.
  , score : String
  , finalscore : Float
  , gmtrans : Float
  , x : Float
  , y : Float
  , xcord : String
  , ycord : String
  , huntx : Float -- Coordinates for the hunting ship.
  , hunty : Float
  , randomnum : Float    -- Used to give bad guys different start positions.
  , difficulty : Float } -- A numerical value which increases the speed of the bad guys.


init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url key = ( { time = 0 
                       , score = "" 
                       , gmtrans = 0.0 -- Transparency of game over text.
                       , x = 0.0 
                       , y = 0.0
                       , finalscore = 0.0
                       , xcord = "" -- Debug variables. Shows the current position of the spaceship relative to coordinate shape.
                       , ycord = ""
                       , huntx = 0.0
                       , hunty = -50.0
                       , randomnum = 0.0 -- WIP: Random number generator to randomize badguy positions.
                       , difficulty = 1.0} 
                       , randfloat )


type Msg = Tick Float GetKeyState
         | NewNumber Float
         | MakeRequest Browser.UrlRequest
         | UrlChange Url.Url
         | MoveMsg (Float, Float) 
         | EnemyMsg

randfloatgen : Random.Generator Float -- Generates a random float from -10 to 10. WIP
randfloatgen = Random.float -100 100 

randfloat : Cmd Msg  -- Returns a random float from -10 to 10. WIP
randfloat = Random.generate NewNumber randfloatgen

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of

       NewNumber num -> ( {model | randomnum = num}, Cmd.none) -- Possibly implement random number generation for placing the bad guys in varying locations.

       Tick ticks _ -> ( {model | time = ticks, score = String.fromFloat model.time, difficulty = model.difficulty + 0.0001}, Cmd.none)

       EnemyMsg -> ( {model | gmtrans = 1.0, finalscore = model.time}, Cmd.none) -- GameOver text, and show score. If you hover over another badguy again it will update score. Will fix.

       MoveMsg (cx, cy) -> ({model | x = 1000 + cx -- Move your character and the phaser ship.
                                   , y = 500 - cy
                                   , xcord = String.fromFloat cx
                                   , ycord = String.fromFloat cy
                                   , huntx = model.x - model.huntx
                                   , hunty = model.y - model.hunty}, Cmd.none)



       MakeRequest req ->
           ( model, Cmd.none ) -- do nothing

       UrlChange url ->
           ( model, Cmd.none ) -- do nothing

view : Model -> { title : String, body : Collage Msg }

{--
The nature of the coordinate system requires that you play fullscreen (browser takes up whole screen).
If you want a half window, you'll have to change the xcord constant from 1000 to 500.
--}
view model = 
  let 
    title = "Space Tag"
    coordsystem = square 1000 |> filled red |> notifyMouseMoveAt MoveMsg |> makeTransparent 0.0 -- Shape used to measure coordinates of mouse.

    background = square 1000 |> filled black

    scoretext = text ("Time Survived: " ++ model.score) |> bold |> filled white |> move (-160, 150) |> scale 3 -- Time survived shown top left of screen.

    xcord = text ("X: " ++ model.xcord) |> bold |> filled white |> move (-240, 210) |> scale 2 -- Debugging text which shows x/y coords.

    ycord = text ("Y: " ++ model.ycord) |> bold |> filled white |> move (-240, 200) |> scale 2

    randtest = text ("Random Value: " ++ String.fromFloat model.randomnum) |> bold |> filled white |> move (-240, 150) |> scale 2

    gameover = text ("Game Over ! :( Your Score: " ++ String.fromFloat model.finalscore) |> bold |> filled red |> move (-80, 0)
                                 |> scale 5 |> makeTransparent model.gmtrans
    
    spaceship = group [ circle 20 |> filled white, triangle 20 |> filled blue] -- You! Good guy space ship. Don't die!
                      |> rotate (degrees 90) |> move (model.x, model.y) 

    badguy = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] -- Standard badguy, move through the center and comes around.
                   |> rotate (degrees 90) |> move (model.randomnum + 100*cos (model.difficulty * model.time), model.randomnum + 100*tan (1.5*model.difficulty*model.time))
                   |> notifyEnter EnemyMsg
    badguy2 = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] 
                   |> rotate (degrees 180) |> move (model.randomnum - 100*tan (model.difficulty * model.time), -100*cos (2.0*model.difficulty * model.time) - model.randomnum*2)
                   |> notifyEnter EnemyMsg
    badguy3 = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] 
                   |> rotate (degrees 180) |> move (model.randomnum - 100*tan (model.difficulty * model.time), -100*cos (model.difficulty * model.time) - model.randomnum)
                   |> notifyEnter EnemyMsg
    badguy4 = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] -- Standard badguy, move through the center and comes around.
                   |> rotate (degrees 90) |> move (model.randomnum + 100*cos (model.difficulty * model.time), 200 + 100*tan (0.5*model.difficulty*model.time))
                   |> notifyEnter EnemyMsg
    phaser = group [ ngon 5 25 |> filled red, triangle 25 |> filled orange] -- Teleports around ship (actually a bug but now it's a feature!)
                   |> rotate (degrees 180) |> move (model.huntx , model.hunty)
                   |> notifyEnter EnemyMsg
    strafer = group [ ngon 12 25 |> filled red, square 25 |> filled orange] -- Strafes the map
                   |> rotate (degrees 180) |> move (500*tan (model.difficulty * model.time), 100*cos (3.0*model.difficulty * model.time) - model.randomnum)
                   |> notifyEnter EnemyMsg
    strafer2 = group [ ngon 12 25 |> filled red, square 25 |> filled orange] -- Strafes the map
                   |> rotate (degrees 180) |> move (-500*tan (2.0*model.difficulty * model.time), -100*cos (model.difficulty * model.time) - model.randomnum)
                   |> notifyEnter EnemyMsg
    strafer3 = group [ ngon 12 25 |> filled red, square 25 |> filled orange] -- Strafes the map
                   |> rotate (degrees 180) |> move (500*tan (model.difficulty * model.time), 100*cos (model.difficulty * model.time) + model.randomnum)
                   |> notifyEnter EnemyMsg
    strafer4 = group [ ngon 12 25 |> filled red, square 25 |> filled orange] -- Strafes the map
                   |> rotate (degrees 180) |> move (500*tan (model.difficulty * model.time) + (20/model.time), 100*cos (1.5*model.difficulty * model.time))
                   |> notifyEnter EnemyMsg
    carrier = group [ ngon 7 120 |> filled red, triangle 50 |> filled orange |> move (-50, 0), triangle 50 |> filled orange |> move (-50,0) |> rotate (degrees 180)] -- Big guy that circles the edges of the map. Very big, very scary!
                   |> rotate (degrees 180) |> move (600*sin (model.difficulty * model.time), 400*cos model.time)
                   |> notifyEnter EnemyMsg

    body  = collage 1000 1000 [ background, gameover, scoretext, randtest, spaceship, coordsystem, badguy, badguy2, badguy3, badguy4, phaser, strafer, strafer2, strafer3, strafer4, carrier] 

  in { title = title, body = body }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

