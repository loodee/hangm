{- Module for handling importing of words from an external file,
   providing functions for getting random words etc. -}

{-# LANGUAGE FlexibleInstances #-}

module Words
    ( HangWord
    , Letter (Visible, Hidden)
    , guess
    , hangWord
    , importWords
    , isRevealed
    , randomWord
    , revealAll
    , toChar
    ) where

import Data.Char (toUpper)
import Data.List (intersperse)
import System.Random

import Utility (fromBool)

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
hangWord xs = [Hidden (toUpper c) | c <- xs]

-- | Selects a string from a list at random and returns its corresponding
--   HangWord. Use this to get a word at the start of a game.
randomWord :: [String] -> IO HangWord
randomWord xs = do
    rand <- randomRIO (0, length xs - 1)
    return (hangWord (xs !! rand))

guess :: Char -> HangWord -> Maybe HangWord
guess c hWord = fromBool (hWord /= newWord) newWord
    where newWord = map ((tryReveal . toUpper) c) hWord
          tryReveal :: Char -> Letter -> Letter
          tryReveal c l | l == (Hidden c) = Visible c
                        | otherwise = l

-- | Set all letters of a HangWord to be visible.
revealAll :: HangWord -> HangWord
revealAll w = map revealLetter w
    where revealLetter (Hidden c) = Visible c
          revealLetter l = l

isRevealed :: HangWord -> Bool
isRevealed h = all isRev h
  where
    isRev (Visible _) = True
    isRev n           = False
