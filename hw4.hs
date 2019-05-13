import System.IO
import System.IO.Unsafe
import System.Random
import Data.IORef
import Control.Monad
loadFile :: [String]
loadFile = words temp
	where temp = unsafePerformIO . readFile $ "words.txt"
loop :: String -> String -> IO()
loop chars prev = do
	let line = guess chars prev
	putStrLn line
	when(line /= chars) $ do
		x <- getLine
		loop chars(prev ++ x)
character :: [a] -> IO a
character temp = do
	x <- randomRIO(0, length temp - 1)
	return(temp !! x)
guess :: String -> String -> String
guess chars [] = replicate(length chars) '_'
guess [] _ = []
guess chars prev | works = [head chars] ++ (guess(tail chars) prev) | otherwise = "_" ++ (guess(tail chars) prev) 
	where
		works = elem(head chars) prev
main = do
	chars <- character(loadFile)
	loop chars ""
