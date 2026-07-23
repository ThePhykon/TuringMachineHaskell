module Turing.Machine where

-- Import
import Turing.Types

-- Write a word onto a tape
initTape :: [Symbol] -> Tape -> Tape 
initTape [] tape = tape
initTape [x] tape = write x tape
initTape (x:xs) tape = initTape xs (move R (write x tape))

initTM :: [Symbol] -> TransitionFunction -> TuringMachine
initTM symbols tf = 
	let tape = initTape symbols (Zipper [] B [])
	in TuringMachine { tape = tape, state = "q0", transitions = tf }

-- Finding the transition, which gets executed
getInstruction :: TransitionFunction -> Symbol -> State -> Maybe Instruction
getInstruction [] _ _ = Nothing
getInstruction (Transition (Configuration st sb) instr : xs) targetSb targetSt
	| st == targetSt && sb == targetSb = Just instr -- Found transition
	| otherwise = getInstruction xs targetSb targetSt -- Continue searching

-- Writing a symbol to the tape, where the head is located
write :: Symbol -> Tape -> Tape
write sb (Zipper left head right) = Zipper left sb right

-- Move the head one position to the left or right
move :: Direction -> Tape -> Tape
move N tape = tape
move L (Zipper (x:xs) head ys) = Zipper xs x (head:ys)
move L (Zipper [] head ys) = Zipper [] B (head:ys)
move R (Zipper xs head (y:ys)) = Zipper (head:xs) y ys
move R (Zipper xs head []) = Zipper (head:xs) B []

-- Apply one instruction to the Turing-Machine
applyInstruction :: TuringMachine -> Instruction -> TuringMachine
applyInstruction tm (Instruction st sb dir) =
	let
		newSymbolTape = write sb (tape tm)
		newTape = move dir newSymbolTape
	in
		tm { tape = newTape, state = st }

tapeHead :: Tape -> Symbol
tapeHead (Zipper xs head ys) = head

-- Run one step in the TM, moving it from one state to the next
runStep :: TuringMachine -> Maybe TuringMachine
runStep tm = case getInstruction (transitions tm) (tapeHead (tape tm)) (state tm) of
	Nothing -> Nothing
	Just instr -> Just (applyInstruction tm instr)
