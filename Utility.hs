module Utility where

import qualified Data.Set as S

-- This is a general file that performs various functions needed by CSCM

-- Returns a percent value of the fraction
-- Example: percent 2 4
-- Result: 50%
percent n d = ((fromIntegral n) / (fromIntegral d)) * 100

-- Return list of elements in xs that are not in ys
-- Example: uniqueElements [1,2,3,4] [1,2] 
-- returns: [3,4]
uniqueElements xs ys = S.toList $ S.difference (S.fromList xs) (S.fromList ys)

-- Checks whether 'a' comes before 'b' in the list
-- Example: constraintCheck a b [b,a]
-- Returns: False
constraintCheck a b (x:xs) | a == x = True
                           | b == x = False
                           | otherwise = constraintCheck a b xs
                           
-- Removes brackets and quotes from a string
-- Example: removeBrackets "[\"a\",\"b\"]"
-- Result: "a,b"
cleanString xs = [x | x <- xs, not (elem x "[]\"")]
