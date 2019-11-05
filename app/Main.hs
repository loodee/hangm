module Main where

import System.IO

import System.Console.ParseArgs

import Hangman (GameState (GameState), play)
import Words (importWords, randomWord)

-- TODO: Get these from program args instead
defaultLives = 7
defaultWordsPath = "words.txt"

argHelp = Arg
    { argIndex = "help"
    , argAbbr = Just 'h'
    , argName = Just "help"
    , argData = Nothing
    , argDesc = "Show options and usage for hangm."
    }

argWords = Arg
    { argIndex = "words"
    , argAbbr = Nothing
    , argName = Just "words"
    , argData = argDataDefaulted "WORDSFILE" ArgtypeString defaultWordsPath
    , argDesc = "Location of file containing potential words."
    }

argDefs = [argHelp, argWords]

apc = ArgsParseControl
    { apcComplete = ArgsComplete
    , apcDash     = ArgsHardDash
    }

doArgsParse :: IO (Args String)
doArgsParse = parseArgsIO apc argDefs

printHelp :: IO ()
printHelp = putStrLn $
       "--help                    Show this help and exit.\n"
    ++ "--words                   (Optional) Choose a word from a text\n"
    ++ "                          file. Words are separated by whitespaces."

main :: IO ()
main = do
    -- Set proper buffering.
    hSetBuffering stdout NoBuffering

    -- Prepare arguments.
    args <- doArgsParse
    let wordsPath = getRequiredArg args "words"
    let showHelp = gotArg args "help"

    if showHelp then printHelp else do
        GameState w l <-
            importWords wordsPath
            >>= randomWord
            >>= \hWord -> play (GameState hWord defaultLives)

        return ()
