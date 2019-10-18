module Main where

import System.IO

import Hangman (play)
import Words (randomWord, importWords)

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering

    print =<<  play =<< randomWord =<< importWords "words.txt"

