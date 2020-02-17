This program uses dijkstra's algorithm to find the shortest path that a knight can take between any two given spaces on a board!
syntax
to find the shortest path between [0, 0] and [0, 1]
you would use this code
```
my_board = Board.new
my_board.knight_moves([0, 1], [7, 7])

=> You made it in 5 Moves!
   [0, 1]
   [2, 0]
   [3, 2]
   [4, 4]
   [5, 6]
   [7, 7]
```
