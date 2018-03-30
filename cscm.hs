import Control.Monad
import Combination
import Data.List.Split
import System.Environment

printUsage = do
	print "USAGE: cscm [tway] [testsuite.txt] [parameter names]"
        print "Example: cscm 3 testsuite.txt parameters.txt"

main = do 
	args <- getArgs
	if (length args) /= 3
		then do
			printUsage
	else if null args
		then printUsage
	else do
		content <- readFile (args !! 1)
		let tests = lines content
		parameters <- readFile (args !! 2)
		let params = lines parameters
		let p = splitOn "," (params !! 0)
		let testsuite = map (splitOn ",") tests
		let tway = read (args !! 0) :: Int
		let coverage = measureTwayCoverage tway testsuite p
		putStrLn (show tway ++ "-way coverage: " ++ show coverage ++ "%")
		
