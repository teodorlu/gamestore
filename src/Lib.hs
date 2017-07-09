{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( servermain
    ) where

import qualified Data.Map as Map
import qualified Data.Maybe as Maybe
import Flow ((|>))
import qualified Web.Scotty as Scotty
import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as Text

import Data.IORef
import Control.Monad.IO.Class (liftIO)

getname name =
  Map.lookup name |> Maybe.maybe

-- handle :: Text -> Text
handle "" = "hoover"
handle s = s

playerscoreboard :: Map.Map Text.Text Int
playerscoreboard =
  Map.fromList
    [ ("teodor", 5)
    , ("erlend", 6)
    ]

getScore database key =
  Map.lookup key database
    |> Maybe.maybe 0 id

showScore :: Text.Text -> Int -> Text.Text
showScore name score =
  mconcat [ "Player ", name, " has score ", (Text.pack . show) score, "." ]

servermain :: IO ()
servermain = do
  -- Starting server
  dbref <- newIORef playerscoreboard

  -- Declaring server actions on each request
  Scotty.scotty 3000 $ do

    Scotty.get "/playerscoreboard/player/:name" $ do
      playername <- Scotty.param "name"
      db <- liftIO $ readIORef dbref
      Scotty.html $ (getScore db playername |> showScore playername)
