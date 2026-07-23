module Turing.Pretty where

-- imports
import Turing.Types

-- Turn 'Symbol' into a String
showSym :: Symbol -> String
showSym One = "1"
showSym Zero = "0"
showSym _ = "_"

-- Create a string-representation of the Tape/Zipper
showTape :: Tape -> String
showTape (Zipper xs head ys) = 
	let { leftStr = unwords (map showSym (reverse xs));
		rightStr = unwords (map showSym ys);
		center = "[" ++ showSym head ++ "]";
		}
	in leftStr ++ " " ++ center ++ " " ++ rightStr

-- Print the TM to the console
printTM :: TuringMachine -> IO ()
printTM tm = do
	putStrLn $ "State: " ++ (state tm)
	putStrLn $ "Tape:  " ++ (showTape (tape tm))
	putStrLn "------------------------"
	putStrLn ""
