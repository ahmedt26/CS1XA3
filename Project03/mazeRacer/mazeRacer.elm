import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url
import String
import Random
import Round

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
                     , stageName : String -- The name of the stage. Used for completion display.
                     , stageScore : Float -- Used to time
                     , canComplete : Bool -- Used to check if user clicked start circle
                     , stagePause : Bool -- Used to start/stop relative stage time for stages.
                     , screenState : String} -- Which screen the game is on currently.


init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url key = ( { time = 0
                        , stageName = "NOSTAGE" -- Baby Steps, Maze Apprentice and The Maze Racer and the three stages. NOSTAGE indicates no stage was initialized.
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
                          ( {model | time = ticks, stageScore = model.stageScore + (1/60)}, Cmd.none) -- 60 ticks per second is 60fps?
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
      -- Updates screen to stage and stage name. Resets stage score, pause bool and completion bool for redundancy/security.
       StageOneClick -> ({model | screenState = "ONE", stageName = "Baby Steps", stageScore = 0.0, stagePause = True, canComplete = False}, Cmd.none)

       StageTwoClick -> ({model | screenState = "TWO", stageName = "Maze Apprentice", stageScore = 0.0, stagePause = True, canComplete = False}, Cmd.none)

       StageThreeClick -> ({model | screenState = "THREE", stageName = "The Maze Racer", stageScore = 0.0, stagePause = True, canComplete = False}, Cmd.none)

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
                         ,  (text "Baby Steps") |> size 50 |> filled white |> move (-450,250) |> notifyTap StageOneClick
                        
                         ,  (roundedRect 700 70 2 |> filled orange |> addOutline (solid 2) white |> move (-400 + 25*sin model.time, 190)) |> notifyTap StageTwoClick
                         ,  (text "Maze Apprentice") |> size 50 |> filled white |> move (-450,175) |> notifyTap StageTwoClick
                         
                         ,  (roundedRect 700 70 2 |> filled red |> addOutline (solid 2) white |> move (-400 + 30*sin model.time, 115)) |> notifyTap StageThreeClick
                         ,  (text "The Maze Racer") |> size 50 |> filled white |> move (-450,100) |> notifyTap StageThreeClick
                         
                         ,  (roundedRect 700 70 2 |> filled purple |> addOutline (solid 2) white |> move (-400 + 35*sin model.time, 40)) |> notifyTap MenuClick
                         ,  (text "Back To Menu") |> size 50 |> filled white |> move (-450,25) |> notifyTap MenuClick
                       ]
    
    howToScreen =  group [ square 1000 |> filled black
                         , text "How to Play" |> size 100 |> filled white |> move (-450 + 100*tan (1.5*model.time),350)  -- Top Left Title
                         ,  (text "Get from the start of the maze to the end as fast as possible.") |> size 25 |> filled white |> move (-450,250)
                         ,  (text "You must click the green circle to start and click the red circle to end.") |> size 25 |> filled white |> move (-450,175)
                         ,  (text "If you hit the maze, it will reset your time and you must start again.") |> size 25 |> filled white |> move (-450,100)
                         ,  (text "Try to beat your previous scores and other people.") |> size 25 |> filled white |> move (-450,25)

                         ,  (roundedRect 700 70 2 |> filled purple |> addOutline (solid 2) white|> move (-400 + 35*sin model.time, -35)) |> notifyTap MenuClick -- Back to menu button
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

                         , (text ("Stage: " ++ model.stageName)) |> size 50 |> filled white |> move (-400 + 20*sin (2 * model.time),200)
                         , (text ("Time: " ++ (Round.round 3 model.stageScore))) |> size 50 |> filled white |> move (-400 + 20*sin (2 * model.time),100)

                         , group [circle 100 |> filled yellow  -- Happy Face :)
                                , circle 20 |> filled black |> move (-40, 40)
                                , circle 20 |> filled black |> move (40, 40)
                                , circle 50 |> filled black |> move (0, -25)
                                , oval 100 85 |> filled yellow |> move (0, -15)
                                ] |> move (150 + 20*sin (-2.0 * model.time) , 150)
                            
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

                         , circle 20 |> filled green |> move (425, -425) |> notifyTap StartTouch -- Start and end circles for map.
                         , circle 20 |> filled red |> move (425, 425) |> notifyTap EndTouch

                         , (roundedRect 75 25 2 |> filled purple |> addOutline (solid 2) white|> move (-400, 480)) |> notifyTap BackClick -- Back to Stages Button
                         , (text "Back") |> size 15 |> filled white |> move (-415,475) |> notifyTap BackClick
                         , (text ("Stage: Baby Steps || Time: " ++ (Round.round 3 model.stageScore))) |> size 15 |> filled white |> move (-300,475) -- Time Display
                       ]
    
    stageTwoScreen =  group [ square 1000 |> filled black -- Plain Background
                         ,  group [   rect 100 1000 |> filled orange |> move (-500, 0) -- Anti-Cheat Border
                                    , rect 100 1000 |> filled orange |> move (500, 0)
                                    , rect 1000 100 |> filled orange |> move (0, -500)
                                    , rect 1000 100 |> filled orange |> move (0, 500)
                                  ] |> notifyEnter MazeTouch

                         , group [  rect 900 900 |> filled orange |> move (0, 0) -- Merry Go Round Maze (Unsafe Part)
                                 ] |> notifyEnter MazeTouch |> rotate (0.1*sin 2*model.stageScore)
                         
                         , group [  rect 150 50 |> filled black |> move (-50, 0) -- Merry Go Round Maze (Safe Part)
                                  , rect 50 150 |> filled black |> move (-125, 50)
                                  , rect 250 50 |> filled black |> move (-125, 150)
                                  , rect 50 150 |> filled black |> move (-25, 150)
                                  , rect 350 50 |> filled black |> move (-175, 250)
                                  , rect 50 300 |> filled black |> move (-375, 200)
                                  , rect 200 50 |> filled black |> move (-300, 50)
                                  , rect 50 200 |> filled black |> move (-225, -50)
                                  , rect 250 50 |> filled black |> move (-250, -125)
                                  , rect 50 200 |> filled black |> move (-225, -200)
                                  , rect 300 50 |> filled black |> move (-225, -275)
                                  , rect 50 200 |> filled black |> move (-50, -200)
                                  , rect 250 50 |> filled black |> move (-0, -125)
                                  , rect 50 400 |> filled black |> move (125, -100)
                                  , rect 250 50 |> filled black |> move (175, 100)
                                  , rect 250 50 |> filled black |> move (175, 0)
                                  , rect 250 50 |> filled black |> move (175, -200)
                                  , rect 50 400 |> filled black |> move (250, -100)
                                  , rect 250 50 |> filled black |> move (300, -100)
                                  , rect 50 250 |> filled black |> move (400, -100)
           

                                 ] |> rotate (0.1*sin 2*model.stageScore)

                         , circle 20 |> filled green |> move (0, 0) |> notifyTap StartTouch -- Start and end circles for map.
                         , circle 20 |> filled red |> move (400, 0) |> notifyTap EndTouch |> rotate (0.1*sin 2*model.stageScore)

                         , (roundedRect 75 25 2 |> filled purple |> addOutline (solid 2) white|> move (-400, 480)) |> notifyTap BackClick -- Back to Stages Button
                         , (text "Back") |> size 15 |> filled white |> move (-415,475) |> notifyTap BackClick
                         , (text ("Stage: Maze Apprentice || Time: " ++ (Round.round 3 model.stageScore))) |> size 15 |> filled white |> move (-300,475) -- Time Display
                       ]

    stageThreeScreen =  group [ square 1000 |> filled black -- Plain Background
                         ,  group [   rect 100 1000 |> filled red |> move (-500, 0) -- Anti-Cheat Border
                                    , rect 100 1000 |> filled red |> move (500, 0)
                                    , rect 1000 100 |> filled red |> move (0, -500)
                                    , rect 1000 100 |> filled red |> move (0, 500)
                                  ] |> notifyEnter MazeTouch

                         , group [  rect 900 100 |> filled red |> move (100, 350) -- Simple maze for baby steps stage.
                                  , rect 900 100 |> filled red |> move (-100, 200)
                                  , rect 900 100 |> filled red |> move (100, 50)
                                  , rect 900 100 |> filled red |> move (-100, -100)
                                  , rect 900 100 |> filled red |> move (100, -250)
                                  , rect 900 100 |> filled red |> move (-50, -400)
                                 ] |> notifyEnter MazeTouch |> rotate (-0.15*sin model.stageScore)

                         , circle 20 |> filled green |> move (425, -425) |> notifyTap StartTouch -- Start and end circles for map.
                         , circle 20 |> filled red |> move (425, 425) |> notifyTap EndTouch

                         , (roundedRect 75 25 2 |> filled purple |> addOutline (solid 2) white|> move (-400, 480)) |> notifyTap BackClick -- Back to Stages Button
                         , (text "Back") |> size 15 |> filled white |> move (-415,475) |> notifyTap BackClick
                         , (text ("Stage: The Maze Racer || Time: " ++ (Round.round 3 model.stageScore))) |> size 15 |> filled white |> move (-300,475) -- Time Display
                       ]


    body  = collage 1000 1000 [
       -- Body depends on what screen is supposed to show. Bunch of conditionals which checks which screen is supposed to show. If no screen exists, then a red screen appears.
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
      else if model.screenState == "TWO" then
        stageTwoScreen
      else if model.screenState == "THREE" then
        stageThreeScreen
      else if model.screenState == "COMPLETE" then
        stageCompleteScreen
      else 
        square 1000 |> filled red
        ] 

  in { title = title, body = body }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
