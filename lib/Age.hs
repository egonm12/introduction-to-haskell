module Age ( Age, mkAge, getAge ) where

data Age = Age { getAge :: Int }

mkAge :: Int -> Maybe Age

mkAge int =
  if int < 0 then Nothing
  else Just (Age int)
