module Hangman
    ( play
    ) where

import Data.Char (isAlpha)

play :: IO ()
play = do
    letter <- getInput

    -- TODO: Logic for updating state depending on guessed letter
    play

getInput :: IO Char
getInput = do
    putStr "Input a letter > "
    input <- getLine

    -- Return char on valid input, otherwise prompt again.
    maybe getInput return $ validateString input

validateString :: String -> Maybe Char
validateString xs = fromBool (valid xs) (head xs)
    where valid xs = length xs == 1 && isAlpha (head xs)
          fromBool p = if p then Just else const Nothing
