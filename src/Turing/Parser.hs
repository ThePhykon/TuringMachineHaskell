module Turing.Parser (parseTransitions, parseInput) where

-- imports
import Turing.Types
import Data.Maybe (mapMaybe)

-- Convert a char to the symbol
parseSymbol :: Char -> Symbol
parseSymbol '1' = One
parseSymbol '0' = Zero
parseSymbol 'B' = B

-- Convert string to direction
parseDirection :: String -> Direction
parseDirection "R" = R
parseDirection "L" = L
parseDirection "N" = N

-- Parse a single line
parseLine :: String -> Maybe Transition
parseLine line = case words line of
    [q, sym, nextQ, writeSym, dir] -> Just $ Transition config instr
      where
        config = Configuration q (parseSymbol (head sym))
        instr  = Instruction nextQ (parseSymbol (head writeSym)) (parseDirection dir)
    _ -> Nothing

-- Export function
-- Parse a user input to a list of symbols
parseInput :: String -> [Symbol]
parseInput s = map parseSymbol s

-- Export function
-- Parse a string (from a file etc.) to a TransitionFunction
parseTransitions :: String -> TransitionFunction
parseTransitions s = 
	let { instructions = lines s;
		delta = mapMaybe parseLine instructions;
		}
	in delta
