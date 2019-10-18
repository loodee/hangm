{- Module for handling importing of words from an external file,
   providing functions for getting random words etc. -}

{-# LANGUAGE FlexibleInstances #-}

module Words
    ( HangWord
    , Letter (Visible, Hidden)
    , hangWord
    , importWords
    , randomWord
    , toChar
    , reveal
    , isRevealed
    ) where

import Data.List (intersperse)
import System.Random

type HangWord = [Letter]

data Letter = Visible Char | Hidden Char
    deriving (Eq, Show)

instance {-# OVERLAPPING #-} Show HangWord where
    show xs = intersperse ' ' $ map toChar xs

-- | Converts a Letter to the corresponding Char representation.
toChar :: Letter -> Char
toChar (Visible c) = c
toChar (Hidden _)  = '_'

-- | Parses and imports words from an external source (such as a text file).
importWords :: String -> IO [String]
importWords filepath = do
    ws <- readFile filepath
    return $ words ws

-- | Builds a fully hidden HangWord from a String.
hangWord :: String -> HangWord
hangWord xs = [Hidden c | c <- xs]

-- | Selects a string from a list at random and returns its corresponding
--   HangWord. Use this to get a word at the start of a game.
randomWord :: [String] -> IO HangWord
randomWord xs = do
    rand <- randomRIO (0, length xs - 1)
    return (hangWord (xs !! rand))

reveal :: Char -> HangWord -> HangWord
reveal x []  = []
reveal x (h:hs) | h == Hidden x = (Visible x):(reveal x hs)
                | otherwise = h:(reveal x hs)


isRevealed :: HangWord -> Bool
isRevealed h = all isRev h
  where
    isRev (Visible _) = True
    isRev n           = False
