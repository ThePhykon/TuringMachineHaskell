module Main where

-- imports
import Turing.Machine
import Turing.Parser
import Turing.Pretty
import Turing.Types

import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hFlush, stdout)
import Control.Concurrent (threadDelay)

runAndPrint :: TuringMachine -> IO ()
runAndPrint tm = do
	printTM tm	
	threadDelay 500000
	case runStep tm of
		Nothing -> putStrLn "MACHINE HOLD"
		Just nextTM -> runAndPrint nextTM


main :: IO ()
main = do
	args <- getArgs

	case args of
		[filePath] -> do
			putStrLn $ "Loading file: " ++ filePath
			content <- readFile filePath

			let transitions = parseTransitions content

			-- Init TM
			putStr $ "Starting word: "
			hFlush stdout
			input <- getLine

			let symbols = parseInput input
			let tm = initTM symbols transitions

			runAndPrint tm

		_ -> putStrLn $ "Error: No .tm file given!"
