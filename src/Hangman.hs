module Hangman
    ( GameState (GameState)
    , play
    ) where

import Data.Char (isAlpha)

import Utility (fromBool)
import Words
    ( HangWord
    , guess
    , isRevealed
    , randomWord
    )

data GameState = GameState HangWord Lives

type Lives = Int

play :: GameState -> IO GameState
play gs@(GameState hWord lives) = do
    showGameStatus gs

    -- Get player input and process the guess.
    char <- getInput

    let newGS@(GameState newWord newLives) = updateState char hWord

    if isRevealed newWord
        then return newGS
        else play newGS

   where updateState c w = case guess c w of
                            Just nw -> GameState nw lives
                            Nothing -> GameState w (lives - 1)

showGameStatus :: GameState -> IO ()
showGameStatus (GameState hWord lives) = do
    -- TODO: Show game status with hill and wrong characters etc.
    putStrLn ""
    putStrLn $ "❤️: " ++ show lives
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
