import Browser
import Browser.Navigation exposing (Key(..))
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Url

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
  , gmtrans : Float
  , x : Float
  , y : Float
  , dx : Float
  , dy : Float}

init : () -> Url.Url -> Key -> ( Model, Cmd Msg )
init flags url key = ( { time = 0 , gmtrans = 0.0, x = 0.0 , y = 0.0, dx = 0.0 , dy = 0.0 } , Cmd.none )

type Msg = Tick Float GetKeyState
         | MakeRequest Browser.UrlRequest
         | UrlChange Url.Url
        --  | MoveMsg 
         | EnemyMsg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of
      
      {--}
       Tick ticks (keyToState,(arrowX,arrowY),(wasdX,wasdY)) -> 
          {--}
          case keyToState (Key "w") of
            Down ->  ( { model | time = ticks, y = model.y + model.dy, dy = 1.0}, Cmd.none )
            Up   -> ( { model | time = ticks, dy = 0.0}, Cmd.none )
            _    -> ({model | time = ticks} , Cmd.none)
          --}
       EnemyMsg -> ( {model | gmtrans = 1.0}, Cmd.none)
       MakeRequest req ->
           ( model, Cmd.none ) -- do nothing

       UrlChange url ->
           ( model, Cmd.none ) -- do nothing

view : Model -> { title : String, body : Collage Msg }

view model = 
  let 
    title = "Space Tag"
    background = square 100000 |> filled black

    gameover = text "Game Over ! :(" |> bold |> filled red |> move (-40, 0)
                                 |> scale 10 |> makeTransparent model.gmtrans
  
    spaceship = group [ circle 20 |> filled white, triangle 20 |> filled blue] 
                      |> rotate (degrees 90) |> move (model.x, model.y)

    badguy = group [ circle 20 |> filled red, triangle 20 |> filled lightBlue] 
                   |> rotate (degrees 90) |> move (100*sin model.time, 100*cos model.time)
                   |> notifyEnter EnemyMsg

    body  = collage 1000 1000 [background, spaceship, badguy,gameover]

  in { title = title, body = body }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

