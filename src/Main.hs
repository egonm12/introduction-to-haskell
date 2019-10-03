module Main where
import System.Random
import Control.Monad()
import Data.List()
main :: IO ()
main = do
  startPos <- createRandomPos
  goalPos <- createRandomPos
  gameLoop startPos goalPos 0

rows :: Int
rows = 1000

cols :: Int
cols = 1000

type Pos = (Int, Int)
type Board = [Pos]

startBoard :: Board
startBoard =
  [ (row,col) | row <- [0..rows], col <- [0..cols] ]

randomPos :: Int -> IO Int
randomPos x = randomRIO (0, x)

createRandomPos :: IO Pos
createRandomPos = do
  x <- randomPos rows
  y <- randomPos cols
  let pos = (x, y)
  return pos

stepRight :: Pos -> Pos
stepRight x =
  let row = if fst x == rows then fst x else fst x + 1
      col = snd x
  in (row, col)

stepLeft :: Pos -> Pos
stepLeft x =
  let row = if fst x == 0 then fst x else fst x - 1
      col = snd x
  in (row, col)

stepUp :: Pos -> Pos
stepUp x =
  let row = fst x
      col = if snd x == cols then snd x else snd x + 1
  in (row, col)

stepDown :: Pos -> Pos
stepDown x =
  let row = fst x
      col = if snd x == 0 then snd x else snd x - 1
  in (row, col)

stepsFromGoal :: Pos -> Pos -> Int
stepsFromGoal pos goal =
  let posX = fst pos
      posY = snd pos
      goalX = fst goal
      goalY = snd goal
      xDiff = if (posX < goalX) then goalX - posX else if (posX > goalX) then posX - goalX else 0
      yDiff = if (posY < goalY) then goalY - posY else if (posY > goalY) then posY - goalY else 0
  in (xDiff + yDiff)

gameLoop :: Pos -> Pos -> Int -> IO ()
gameLoop currentPos goalPos stepsCount = do
  print currentPos
  print goalPos
  let posRight = stepRight currentPos
  let posLeft = stepLeft currentPos
  let posUp = stepUp currentPos
  let posDown = stepDown currentPos

  let right = stepsFromGoal posRight goalPos
  let left = stepsFromGoal posLeft goalPos
  let up = stepsFromGoal posUp goalPos
  let down = stepsFromGoal posDown goalPos

  let lowest = minimum [right, left, up, down]

  if currentPos == goalPos then
    print $ "It took " ++ show stepsCount ++ " steps to reach the goal"
  else if posRight == goalPos then do
    print "Go right"
    gameLoop posRight goalPos (stepsCount + 1)
  else if posLeft == goalPos then do
    print "Go left"
    gameLoop posLeft goalPos (stepsCount + 1)
  else if posUp == goalPos then do
    print "Go up"
    gameLoop posUp goalPos (stepsCount + 1)
  else if posDown == goalPos then do
    print "Go down"
    gameLoop posDown goalPos (stepsCount + 1)
  else if lowest == right then do
    print "Go right"
    gameLoop posRight goalPos (stepsCount + 1)
  else if lowest == left then do
    print "Go left"
    gameLoop posLeft goalPos (stepsCount + 1)
  else if lowest == up then do
    print "Go up"
    gameLoop posUp goalPos (stepsCount + 1)
  else do
    print "Go down"
    gameLoop posDown goalPos (stepsCount + 1)
  return ()