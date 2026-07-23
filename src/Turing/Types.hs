module Turing.Types where

-- Datastructures and Types
data Zipper a = Zipper [a] a [a]
data Direction = L | R | N deriving (Show, Eq)
data Symbol = Zero | One | B deriving (Show, Eq)

type State = String
data Instruction = Instruction State Symbol Direction
data Configuration = Configuration State Symbol
data Transition = Transition Configuration Instruction

type Tape = Zipper Symbol
type TransitionFunction = [Transition]

data TuringMachine = TuringMachine
	{ tape :: Tape
	, state :: State
	, transitions :: TransitionFunction
	}
