{- Module providing random useful helper functions -}

module Utility
    ( fromBool
    ) where

fromBool :: Bool -> a -> Maybe a
fromBool p = if p then Just else const Nothing
