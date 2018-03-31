module Combination where

import Control.Parallel.Strategies
import Data.List
import NumUtility 
import Data.List.Split
import Control.Parallel
import Control.Concurrent
import Distribution.Simple.Utils

--Regular factorial definition
factorial::Int->Int
factorial n 
	| n < 1 = 1
	| otherwise = n * factorial (n - 1)

--Alternative factorial definition for reducing combinatorial calculations
factorial'::Int->Int->Int
factorial' n k 
	| n == k = 1
	| otherwise = n * factorial' (n-1) k


nchoosek::Int->Int->Int
nchoosek n k = a `div` b where a = factorial' n (n-k)
			       b = factorial k

getTwayCombinationCount::[a]->Int->Int
getTwayCombinationCount xs t = nchoosek (length xs) t

getTwaySequenceCount::[a]->Int->Int
getTwaySequenceCount xs t = (getTwayCombinationCount xs t) * factorial t 

findTwaySequences t xs = filter (\ys -> length ys == t) (subsequences xs) 

findAllTwaySequences t xs = parMap rdeepseq (findTwaySequences t) xs

measureTwayCoverage t xs ys = percent (length (ordNub (concat (findAllTwaySequences t xs)))) (getTwaySequenceCount ys t)


