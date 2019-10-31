module Main where

import System.IO

import Hangman (GameState (GameState), play)
import Words (importWords, randomWord)

-- TODO: Get these from program args instead
lives = 7
wordsFile = "words.txt"

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering

    hWord <- randomWord =<< importWords wordsFile
    GameState w l <-
        importWords wordsFile
        >>= randomWord
        >>= \hWord -> play (GameState hWord lives)

    return ()
