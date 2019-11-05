module Main where

import System.IO

import System.Console.ParseArgs

import Hangman (GameState (GameState), play)
import Words (importWords, randomWord)

-- TODO: Get these from program args instead
lives = 7
wordsFile = "words.txt"

argHelp = Arg
    { argIndex = "help"
    , argAbbr = Just 'h'
    , argName = Just "help"
    , argData = argDataOptional "help" ArgtypeString
    , argDesc = "Show options."
    }

argLives = Arg
    { argIndex = "lives"
    , argAbbr = Nothing
    , argName = Just "lives"
    , argData = argDataDefaulted "lives" ArgtypeInt 7
    , argDesc = "Number of starting lives."
    }

argWords = Arg
    { argIndex = "words"
    , argAbbr = Nothing
    , argName = Just "words"
    , argData = argDataDefaulted "words" ArgtypeString "words.txt"
    , argDesc = "Location of file containing potential words."
    }

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering

    hWord <- randomWord =<< importWords wordsFile
    GameState w l <-
        importWords wordsFile
        >>= randomWord
        >>= \hWord -> play (GameState hWord lives)

    return ()
