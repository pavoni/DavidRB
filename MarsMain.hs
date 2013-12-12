-- Red Badger - Mars Robot exercise
-- Greg Dowling - mail@gregdowling.com - May 2013
-- Haskell implentation

-- Main routine - read input data and parse it into the Haskell data structures and then call the core code
-- Also print the results in the prescribed format
-- Always the least attractive bit of a Haskell program!

import System.IO
import Data.List
import MarsRobot

-- 
main = do
--   h <- openFile "SampleInput.txt" ReadMode	
   cont <- getContents
   
   let imp = words cont ::[String]
   let maxX = (read $ head imp)::Integer
   let maxY = read (head $ drop 1 imp )::Integer

   let robotTuples = parseRobots $ drop 2 $ imp 

   -- Do the real work - code in MarsRobots.hs
   let results =    multiRobotFold maxX maxY robotTuples

   -- Format and output as requested
   putStr $toStringResults results


parseRobots :: [String] -> [(Robot,[Command])]
parseRobots [] = []
parseRobots (x:y:d:cmd:xs) = [ (Robot (Position (read x ::Integer) (read y ::Integer ) ) (txt2dir d)  OK , (map txt2cmd cmd)) ] ++ parseRobots xs
        where txt2dir :: String -> Orientation
	      txt2dir x
         	 | x == "N" = N
	         | x == "W" = W
		 | x == "S" = S
		 | x == "E" = E

	      txt2cmd :: Char -> Command
	      txt2cmd x 
		 | x == 'F' = F
	         | x == 'R' = R
		 | x == 'L' = L

--- Actually like the Haskell Show default better myself - but best to give the customer what they asked for!
toStringResults :: [Robot] -> String
toStringResults list = foldl (\acc x -> acc ++  (toStringOneRobot x) ++ "\n") [] list
   where
	toStringOneRobot :: Robot -> String
	toStringOneRobot (Robot p o l) = toStringPosition p ++ " " ++ toStringOrientation o ++ (if (l == Lost) then " Lost" else "")

	toStringOrientation :: Orientation -> String
	toStringOrientation x
         	 | x == N = "N"
	         | x == W = "W"
		 | x == S = "S"
		 | x == E = "E"

	toStringPosition :: Position -> String
	toStringPosition (Position x y) = show x ++ " " ++ show y
      
   


