import Data.List (sort, group, intercalate, transpose)
skips :: [a] -> [[a]]
skips temp = [[i | (j, i) <- zip [1..] temp, j `mod` k == 0] | k <- [1..length temp]]
localMaxima :: [Integer] -> [Integer]
localMaxima (a:b:c:d) = if (b > a && b > c) then b : localMaxima (b:c:d) else localMaxima (b:c:d)
localMaxima d = []
astrics :: (temp -> Bool) -> temp -> Char
astrics function fill |function fill = '*' |otherwise = ' '
filler :: [Int] -> [Int]
filler temp = map (subtract 1 . length) (group . sort $ [0..9] ++ filter (\i -> i >= 0 && i <= 9) temp)
helper :: [Int] -> [String]
helper temp = map (\i -> '=' : replicate i '*' ++ replicate (maximum temp - i) ' ') temp
histogram :: [Int] -> String
histogram xs = intercalate "\n" (reverse . transpose . helper . filler $ xs) ++ "\n" ++ "0123456789" ++ "\n"
