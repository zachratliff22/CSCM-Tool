module Combination where

-- User files
import Utility 

-- Haskell libraries
import Control.Parallel.Strategies
import Data.List
import Data.List.Split
import Control.Parallel
import Distribution.Simple.Utils

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
-- Example: (n choose k) = [ n! / ((n - k)!k!)] = [ n*(n-1)*...*(n-k+1) / k! ]
nchoosek::Int->Int->Int
nchoosek n k = a `div` b where a = factorial' n (n-k)
			       b = factorial k

-- Gets the number of t-way combinations from a list of symbols
-- Example: getTwayCombinationCount 2 [a,b,c] 
-- Returns: 3
getTwayCombinationCount::Int->[a]->Int
getTwayCombinationCount t xs = nchoosek (length xs) t

-- Gets the number of t-way permutations from a list of symbols
-- Formula: (n choose t) * t!
-- Example: getTwaySequenceCount 2 [a,b,c]
-- Returns: 6
getTwaySequenceCount::Int->[a]->Int
getTwaySequenceCount t xs = (getTwayCombinationCount t xs) * factorial t 

-- Finds all the t-way sequences in a single test
-- Example: findTwaySequences 2 [a,b,c] 
-- Returns: [[a,b],[a,c],[b,c]]
findTwaySequences t xs = filter (\ys -> length ys == t) (subsequences xs)

-- Gets all the t-way sequences from a list of symbols
-- Example: getAllTwaySequences 2 [a,b,c]
-- Returns: [[a,b],[a,c],[b,c],[c,b],[c,a],[b,a]]
getAllTwaySequences t (x:[]) = [s | s <- permutations x]
getAllTwaySequences t (x:xs) = [s | s <- permutations x] ++ (getAllTwaySequences t xs)  

-- Finds all the t-way sequences in a list of tests
-- Example: findAllTwaySequences 2 [[a,b,c],[a,c,b]]
-- Returns: [[a,b],[a,c],[b,c],[c,b]]
findAllTwaySequences t xs = parMap rdeepseq (findTwaySequences t) xs

-- Return a list of all the missing sequences from the list of tests
-- Example: findMissingSequences 2 [a,b,c] [[a,b,c],[a,c,b]]
-- Returns: [[c,a],[b,a]]
findMissingSequences t xxs yys = uniqueElements (getAllTwaySequences t (findTwaySequences t xxs)) (concat (findAllTwaySequences t yys))

-- Takes in a integer t, a list of tests, and a list of symbols, and returns the t-way coverage of the tests
-- Example: measureTwayCoverage 2 [[a,b,c],[a,c,b]] [a,b,c]
-- Returns: 2-way coverage: 66.66667%
measureTwayCoverage t xs ys = percent (length (ordNub (concat (findAllTwaySequences t xs)))) (getTwaySequenceCount t ys)
