module Hangman
    ( play
    ) where

import Data.Char (isAlpha)

import Words (HangWord, reveal)

play :: HangWord -> IO HangWord
play hWord = do
    showGameStatus hWord

    -- Get player input and process the guess.
    letter <- getInput
    play $ reveal letter hWord

showGameStatus :: HangWord -> IO ()
showGameStatus hWord = do
    -- TODO: Show game status with hill and wrong characters etc.
    putStrLn $ "Word: " ++ show hWord

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
