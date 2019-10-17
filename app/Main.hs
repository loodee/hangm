module Main where

import System.IO

import Hangman (play)

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    play
