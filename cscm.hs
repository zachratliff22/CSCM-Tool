-- user files
import Combination
import Utility

-- Haskell libraries
import Control.Monad
import Data.List.Split
import System.Environment
import Control.Parallel
import System.IO

printUsage = do
	print "USAGE: cscm [tway] [testsuite.txt] [event names] +RTS -N[numProcessors]"
        print "Example: cscm 3 testsuite.txt events.txt +RTS -N4"

main = do 
	args <- getArgs
	if (length args) /= 3
		then do
			printUsage
	else if null args
		then printUsage
	else do
		outh <- openFile "missingSequences.txt" WriteMode
		content <- readFile (args !! 1)
		let tests = lines content
		parameters <- readFile (args !! 2)
		let params = lines parameters
		let p = splitOn "," (params !! 0)
		let testsuite = map (splitOn ",") tests
		let tway = read (args !! 0) :: Int
		let missing = findMissingSequences tway p testsuite
		hPutStrLn outh $ cleanString $ unlines $ map show missing
		let totalSeq = getTwaySequenceCount tway p
		let coverage = percent (totalSeq - (length missing)) totalSeq
		putStrLn ("\n================== CSCM OUTPUT ==================\n")
		putStrLn (show tway ++ "-way coverage: " ++ show coverage ++ "%\n")
        putStrLn "Missing sequences output to: missingSequences.txt" 
