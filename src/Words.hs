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
    ) where

import Data.List (intersperse)

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
randomWord xs = error "(TODO) Not yet implemented"
