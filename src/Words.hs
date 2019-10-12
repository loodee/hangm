{- Module for handling importing of words from an external file,
   providing functions for getting random words etc. -}

module Words where

type HangWord = [Letter]

data Letter = Visible Char | Hidden Char

-- | Parses and imports words from an external source (such as a text file).
importWords :: IO [String]
importWords = error "(TODO) Not yet implemented"

-- | Builds a fully hidden HangWord from a String.
hangWord :: String -> HangWord
hangWord xs = error "(TODO) Not yet implemented"

-- | Selects a string from a list at random and returns its corresponding
--   HangWord. Use this to get a word at the start of a game.
randomWord :: [String] -> IO HangWord
randomWord xs = error "(TODO) Not yet implemented"
