module Lib
    ( someFunc
    ) where

import Data.Map as Map
import Data.Maybe as Maybe
import Flow ((|>))

getname name =
  Map.lookup name |> Maybe.maybe

hello :: String -> String
hello name = "Hello " ++ name ++ "!"

someFunc :: IO ()
someFunc = do
  putStrLn $ hello "Teodor"
  print $ Map.fromList [("1", "Num"), ("2", "Num"), ("c", "Char")]
