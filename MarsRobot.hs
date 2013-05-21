-- Red Badger - Mars Robot exercise
-- Greg Dowling - mail@gregdowling.com - May 2013
-- Haskell implentation

module MarsRobot
(   Position(..)
,   Orientation(..)
,   Lost(..)
,   Robot(..)
,   Command(..)
,   foldEachRobot
,   multiRobotFold
) where


import Data.List

-- Define data types for Robot state

data Position = Position Integer Integer deriving (Eq,Show)
data Orientation = N | S | W | E deriving (Eq,Show)
data Lost = OK | Lost deriving (Eq,Show)
data Robot = Robot Position Orientation Lost deriving (Eq,Show) 

-- Define Command - modify to add additional commands as needed
data Command = L | R | F deriving (Eq, Show)

-- Execute the robot command - takes a state and a command and returns a new state 
execCommand :: Robot -> Command -> Robot
execCommand r c 
	| c == L = cmdLeft    r
	| c == R = cmdRight   r
	| c == F = cmdForward r
--Just for safety - do nothing with unnknown command
        | otherwise = r 
  where 
	cmdLeft :: Robot -> Robot
	cmdLeft (Robot p o l) 
	   | o == N = Robot p W l
	   | o == E = Robot p N l
	   | o == S = Robot p E l
	   | o == W = Robot p S l

	cmdRight :: Robot -> Robot
	cmdRight (Robot p o l)
	   | o == N = Robot p E l 
	   | o == E = Robot p S l 
	   | o == S = Robot p W l
	   | o == W = Robot p N l

	cmdForward :: Robot -> Robot
	cmdForward (Robot (Position x y) o l)
	   | o == N = Robot (Position  x   (y+1)) o l
	   | o == E = Robot (Position (x+1) y  ) o l 
	   | o == S = Robot (Position  x   (y-1)) o l
	   | o == W = Robot (Position (x-1) y  ) o l



-- makeMove will return the new robot state
-- lookat the new position and see if it drops off the world
-- if it does check whether there is a scent from a previous robot that would prevent ths loss
-- Parameters are Max x dim, Max y dim, Scent (list of Positions) old Robot state, proposed Robot statate

makeMove :: Integer->Integer->[Position]-> Robot -> Robot -> Robot
makeMove maxX maxY scent ro@(Robot roP roO roL) rn@(Robot (Position rnX rnY) rnO rnL)
-- Is Robot already lost? if so it can't move!
   | roL == Lost = ro
-- Is Robot still in the bounded world? - if so return the new state
   | rnX >= 0 && rnY >= 0 && rnX <= maxX && rnY <= maxY = rn
-- So Robot is out of the bounded world - is it protected by a Scent - if so return old position
   | (find (== roP) scent) /= Nothing = ro
-- Otherise - we just fell off the world - return the old position - but change the Lost value
   | otherwise = Robot roP roO Lost


-- foldEachRobot will take a command list for each robot and execute them producing a single final Robot state
-- Parameters are initial Max x dim, max y dim, scent list, initial Robot state
foldEachRobot :: Integer->Integer->[Position]->Robot->[Command]->Robot
foldEachRobot maxX maxY scent = foldl (\acc command -> makeMove maxX maxY scent acc (execCommand acc command))

--multiRobotFold looks complex but isn't!
--Parameter are Max co-ords as before and a list of tuples - one for each Robot
--each tuple is a Robot initial state - and a list of commands
--the other complexity is the scent list of positions - this is produced by using the intermediate list of Robot final states, choosing those that are lost 
-- and then extracting the Positions from them  - this is done by stripScent
-- note that because HAskell is lasy - this parameter is only evaluated when it is used - so this is much more effieicnet that it looks!
multiRobotFold :: Integer->Integer->[(Robot,[Command])]->[Robot]
multiRobotFold maxX maxY = foldl (\acc (r,cmd) -> acc ++ [foldEachRobot maxX maxY (stripScent acc) r cmd ] ) []

--take a list of Robot final postions, choose those that are lost - and then extract their Positions to make the scent list
stripScent:: [Robot]->[Position]
stripScent rl = foldl(\acc (Robot p _ _) -> acc ++ [p] ) [] $filter (\(Robot _ _ l) -> l == Lost) rl

