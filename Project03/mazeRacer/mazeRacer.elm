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


type alias Model = { time : Float -- Overall time since start of program
                     , gametime : Float -- Used to time stages
                     , stageScore : Float -- Used to time
                     , canComplete : Bool -- Used to check if user clicked start circle
                     , stagePause : Bool -- Used to start/stop relative stage time for stages.
                     , screenState : String} -- Which screen the game is on currently.


init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url key = ( { time = 0
                        , gametime = 0
                        , stageScore = 0
                        , canComplete = False
                        , stagePause = True 
                        , screenState = "MENU"} -- MENU, PLAY, HOWTO, CREDITS, HIGHSCORE, ONE, TWO, THREE, COMPLETE. Used to change screens
                        , Cmd.none )


type Msg = Tick Float GetKeyState
         | MakeRequest Browser.UrlRequest
         | UrlChange Url.Url
         -- Menu Messages
         | MenuClick
         | PlayClick
         | HowToClick
         | CreditsClick
         -- Game Messages
         | BackClick -- To go back from a stage. Resets stageScore and stagePauge.
         | StageOneClick
         | StageTwoClick
         | StageThreeClick
         -- Stage Messages
         | StartTouch
         | EndTouch
         | MazeTouch

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of

       Tick ticks _ -> if model.stagePause == False then
                          ( {model | time = ticks, stageScore = model.stageScore + 0.01666666}, Cmd.none)
                       else
                          ( {model | time = ticks}, Cmd.none)

       MakeRequest req ->
           ( model, Cmd.none ) -- do nothing

       UrlChange url ->
           ( model, Cmd.none ) -- do nothing

       -- Each of these redirect the player to the screen when a certain element with a notification has this message and is activated.
       MenuClick -> ({model | screenState = "MENU"}, Cmd.none) -- Menu. All of these should be self-explanatory.

       PlayClick -> ({model | screenState = "PLAY", stageScore = 0.0}, Cmd.none)

       HowToClick -> ({model | screenState = "HOWTO"}, Cmd.none)

       BackClick -> ({model | screenState = "PLAY", stageScore = 0.0, stagePause = True, canComplete = False}, Cmd.none) -- Backing out of a stage resets stage time and puts it on pause.

       CreditsClick -> ({model | screenState = "CREDITS"}, Cmd.none)

       StageOneClick -> ({model | screenState = "ONE"}, Cmd.none)

       StageTwoClick -> ({model | screenState = "TWO"}, Cmd.none)

       StageThreeClick -> ({model | screenState = "THREE"}, Cmd.none)

      -- Stage Messages: Used to check if user touched edge, stage has started/ended.
       StartTouch -> ({model | stagePause = False, stageScore = 0.0, canComplete = True}, Cmd.none)

       EndTouch -> if model.canComplete == True then -- When stage is successfully completed, takes user to StageCompleteScreen which displays score in fancy way.
                      ({model | stagePause = True, screenState = "COMPLETE", canComplete = False}, Cmd.none)
                   else
                      (model, Cmd.none) 

       MazeTouch -> ({model | stagePause = True, stageScore = 0.0, canComplete = False}, Cmd.none)

view : Model -> { title : String, body : Collage Msg }

view model = 
  let 
    title = "Maze Racer"


    menuScreen = group [ square 1000 |> filled black
                         -- The trig Functions added to each menu button gives the screen life rather than the buttons sitting idly.
                         ,  text "Maze Racer" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title
                        
                         ,  (roundedRect 700 70 2 |> filled red |> addOutline (solid 2) white |> move (-400 + 20*sin model.time, 265)) |> notifyTap PlayClick 
                         ,  (text "Play") |> size 50 |> filled white |> move (-450,250) 

                         ,  (roundedRect 700 70 2 |> filled orange |> addOutline (solid 2) white |> move (-400 + 25*sin model.time, 185)) |> notifyTap HowToClick 
                         ,  (text "How To Play") |> size 50 |> filled white |> move (-450,170)

                         ,  (roundedRect 700 70 2 |> filled yellow |> addOutline (solid 2) white |> move (-400 + 30*sin model.time, 105)) |> notifyTap CreditsClick
                         ,  (text "Credits") |> size 50 |> filled white |> move (-450,90)

                         ,  (roundedRect 700 70 2 |> filled green |> addOutline (solid 2) white |> move (-400 + 35*sin model.time, 25))
                         ,  (text "High Scores") |> size 50 |> filled white |> move (-450,10)
                       ]
    
    playScreen =  group [ square 1000 |> filled black
                         , text "Stage Select" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title

                         ,  (roundedRect 700 70 2 |> filled blue |> addOutline (solid 2) white |> move (-400 + 20*sin model.time, 265)) |> notifyTap StageOneClick
                         ,  (text "Baby Steps") |> size 50 |> filled white |> move (-450,250)
                        
                         ,  (roundedRect 700 70 2 |> filled orange |> addOutline (solid 2) white |> move (-400 + 25*sin model.time, 190)) 
                         ,  (text "Maze Apprentice") |> size 50 |> filled white |> move (-450,175)
                         
                         ,  (roundedRect 700 70 2 |> filled red |> addOutline (solid 2) white |> move (-400 + 30*sin model.time, 115))
                         ,  (text "The Maze Racer") |> size 50 |> filled white |> move (-450,100)
                         
                         ,  (roundedRect 700 70 2 |> filled purple |> addOutline (solid 2) white |> move (-400 + 35*sin model.time, 40)) |> notifyTap MenuClick
                         ,  (text "Back To Menu") |> size 50 |> filled white |> move (-450,25) |> notifyTap MenuClick
                       ]
    
    howToScreen =  group [ square 1000 |> filled black
                         , text "How to Play" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title
                         ,  (text "The Instructions of the Game are simple:") |> size 25 |> filled white |> move (-450,250)
                         ,  (text "Get from the start to the end of the map as fast as possible") |> size 25 |> filled white |> move (-450,175)
                         ,  (text "If you hit something you shouldn't, you lose and you'll have to try again") |> size 25 |> filled white |> move (-450,100)
                         ,  (text "Try to beat your previous scores and other people.") |> size 25 |> filled white |> move (-450,25)

                         ,  (roundedRect 700 70 2 |> filled purple |> addOutline (solid 2) white|> move (-400 + 35*sin model.time, -35)) |> notifyTap MenuClick
                         ,  (text "Back to Menu") |> size 50 |> filled white |> move (-450,-50)
                       ]
    creditsScreen =  group [ square 1000 |> filled black
                         , text "Credits" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title
                         ,  (text "Programming: Tahseen") |> size 25 |> filled white |> move (-450,250)
                         ,  (text "Art/Design: Tahseen") |> size 25 |> filled white |> move (-450,175)
                         ,  (text "Poor Attempt at Database/Django: Tahseen") |> size 25 |> filled white |> move (-450,100)
                         ,  (text "Calculaemus: Gottfried Wilhelm Leibniz") |> size 25 |> filled white |> move (-450,25)

                         ,  (roundedRect 700 70 2 |> filled purple |> addOutline (solid 2) white|> move (-400 + 35*sin model.time, -35)) |> notifyTap MenuClick
                         ,  (text "Back to Menu") |> size 50 |> filled white |> move (-450,-50)
                       ]

    stageCompleteScreen =  group [ square 1000 |> filled black
                         ,  text "Stage Complete" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title
                         , (text ("Score: " ++ (String.fromFloat model.stageScore))) |> size 100 |> filled white |> move (-400 + 20*sin (2 * model.time),150)

                         ,  (roundedRect 900 70 2 |> filled purple |> addOutline (solid 2) white|> move (-300 + 35*sin model.time, -35)) |> notifyTap PlayClick
                         ,  (text "Back to Stage Selection") |> size 50 |> filled white |> move (-450,-50)
                       ]
                                    
    stageOneScreen =  group [ square 1000 |> filled black -- Plain Background
                         ,  group [   rect 100 1000 |> filled blue |> move (-500, 0) -- Anti-Cheat Border
                                    , rect 100 1000 |> filled blue |> move (500, 0)
                                    , rect 1000 100 |> filled blue |> move (0, -500)
                                    , rect 1000 100 |> filled blue |> move (0, 500)
                                  ] |> notifyEnter MazeTouch

                         , group [  rect 900 100 |> filled blue |> move (100, 350) -- Simple maze for baby steps stage.
                                  , rect 900 100 |> filled blue |> move (-100, 200)
                                  , rect 900 100 |> filled blue |> move (100, 50)
                                  , rect 900 100 |> filled blue |> move (-100, -100)
                                  , rect 900 100 |> filled blue |> move (100, -250)
                                  , rect 900 100 |> filled blue |> move (-50, -400)
                                 ] |> notifyEnter MazeTouch
                         , circle 20 |> filled green |> move (425, -425) |> notifyTap StartTouch
                         , circle 20 |> filled red |> move (425, 425) |> notifyTap EndTouch
                         , (roundedRect 75 25 2 |> filled purple |> addOutline (solid 2) white|> move (-400, 480)) |> notifyTap BackClick -- Back to Stages Button
                         , (text "Back") |> size 15 |> filled white |> move (-415,475)
                         , (text ("Score: " ++ (String.fromFloat model.stageScore))) |> size 15 |> filled white |> move (-300,475)
                       ]



    body  = collage 1000 1000 [ 
      if model.screenState == "MENU" then 
        menuScreen
      else if model.screenState == "PLAY" then
        playScreen
      else if model.screenState == "HOWTO" then
        howToScreen
      else if model.screenState == "CREDITS" then
        creditsScreen 
      else if model.screenState == "ONE" then
        stageOneScreen
      else if model.screenState == "COMPLETE" then
        stageCompleteScreen
      else 
        square 1000 |> filled red
        ] 

  in { title = title, body = body }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
