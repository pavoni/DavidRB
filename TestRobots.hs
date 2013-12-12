-- Red Badger - Mars Robot exercise
-- Greg Dowling - mail@gregdowling.com - May 2013
-- Haskell implentation
-- Tests to be executed from the Haskell REPL environment
--- Just load and then run main - all test should print true

import System.IO
import Data.List
import MarsRobot


main =
	do


		-- test folding function function 
		-- Rotation functions
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L]) == (Robot (Position 0 0) W OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L,L]) == (Robot (Position 0 0) S OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L,L,L]) == (Robot (Position 0 0) E OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L,L,L,L]) == (Robot (Position 0 0) N OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L,L,L]) == (Robot (Position 0 0) E OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,R]) == (Robot (Position 0 0) S OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,R,R]) == (Robot (Position 0 0) W OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,R,R,R]) == (Robot (Position 0 0) N OK))
		
		-- Boundaries
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,R,F]) == (Robot (Position 0 0) S Lost))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [F,F,F]) == (Robot (Position 0 3) N OK))		
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [F,F,F,F]) == (Robot (Position 0 3) N Lost))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [L,F]) == (Robot (Position 0 0) W Lost))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,F,F]) == (Robot (Position 2 0) E OK))
		print ((foldEachRobot 2 3 [] (Robot (Position 0 0) N OK) [R,F,F,F]) == (Robot (Position 2 0) E Lost))

		-- Scent
		print ((foldEachRobot 2 3 [Position 0 0, Position 0 3, Position 2 0] (Robot (Position 0 0) N OK) [R,R,F]) == (Robot (Position 0 0) S OK))
		print ((foldEachRobot 2 3 [Position 0 0, Position 0 3, Position 2 0] (Robot (Position 0 0) N OK) [F,F,F,F]) == (Robot (Position 0 3) N OK))
		print ((foldEachRobot 2 3 [Position 0 0, Position 0 3, Position 2 0] (Robot (Position 0 0) N OK) [L,F]) == (Robot (Position 0 0) W OK))
		print ((foldEachRobot 2 3 [Position 0 0, Position 0 3, Position 2 0] (Robot (Position 0 0) N OK) [R,F,F,F]) == (Robot (Position 2 0) E OK))
		
		-- these three examples from the exercise

		print ((foldEachRobot 5 3 [] (Robot (Position 1 1) E OK) [R,F,R,F,R,F,R,F]) == (Robot (Position 1 1) E OK) )
		print ((foldEachRobot 5 3 [] (Robot (Position 3 2) N OK) [F,R,R,F,L,L,F,F,R,R,F,L,L]) == (Robot (Position 3 3) N Lost) )
		print ((foldEachRobot 5 3 [Position 3 3] (Robot (Position 0 3) W OK) [L,L,F,F,F,L,F,L,F,L]) == (Robot (Position 2 3) S OK) )

		-- test the overall multiFold
		let inp = [(Robot (Position 1 1) E OK,[R,F,R,F,R,F,R,F]),
		           (Robot (Position 3 2) N OK,[F,R,R,F,L,L,F,F,R,R,F,L,L]),
			   (Robot (Position 0 3) W OK,[L,L,F,F,F,L,F,L,F,L])]
		let result = [(Robot (Position 1 1) E OK), (Robot (Position 3 3) N Lost), (Robot (Position 2 3) S OK)]
		print ((multiRobotFold 5 3 inp) == result)