module Combination where

import Control.Parallel.Strategies
import Data.List
import NumUtility 
import Data.List.Split
import Control.Parallel
import Distribution.Simple.Utils
import qualified Data.Set as S

-- Regular factorial definition
factorial::Int->Int
factorial n 
	| n < 1 = 1
	| otherwise = n * factorial (n - 1)

-- Alternative factorial definition for reducing combinatorial calculations
factorial'::Int->Int->Int
factorial' n k 
	| n == k = 1
	| otherwise = n * factorial' (n-1) k

-- Performs n choose k operation using the reduced factorial definition
nchoosek::Int->Int->Int
nchoosek n k = a `div` b where a = factorial' n (n-k)
			       b = factorial k

-- Gets the number of t-way combinations from a list of symbols
getTwayCombinationCount::[a]->Int->Int
getTwayCombinationCount xs t = nchoosek (length xs) t

-- Gets the number of t-way permutations from a list of symbols
getTwaySequenceCount::[a]->Int->Int
getTwaySequenceCount xs t = (getTwayCombinationCount xs t) * factorial t 

-- finds all the t-way sequences in a single test
findTwaySequences t xs = filter (\ys -> length ys == t) (subsequences xs)

-- gets all the t-way sequences from a list of symbols
getAllTwaySequences t (x:[]) = [s | s <- permutations x]
getAllTwaySequences t (x:xs) = [s | s <- permutations x] ++ (getAllTwaySequences t xs)  

-- finds all the t-way sequences in a list of tests
findAllTwaySequences t xs = parMap rdeepseq (findTwaySequences t) xs

-- return list of elements in xs that are not in ys
-- Example: uniqueElements [1,2,3,4] [1,2] 
-- returns: [3,4]
uniqueElements xs ys = S.toList $ S.difference (S.fromList xs) (S.fromList ys)

-- return a list of all the missing sequences from the list of tests
-- Example: findMissingSequences 3 [1,2,3,4,5] [[1,2,3,4,5],[5,4,3,2,1]]
findMissingSequences t xxs yys = uniqueElements (getAllTwaySequences t (findTwaySequences t xxs)) (concat (findAllTwaySequences t yys))


-- checks whether 'a' comes before 'b' in the list
constraintCheck a b (x:xs) | a == x = True
                           | b == x = False
                           | otherwise = constraintCheck a b xs

-- Takes in a integer, a list of tests, and a list of symbols
measureTwayCoverage t xs ys = percent (length (ordNub (concat (findAllTwaySequences t xs)))) (getTwaySequenceCount ys t)

