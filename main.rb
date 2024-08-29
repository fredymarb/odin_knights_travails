require_relative "graph"

knight = KnightPiece.new
p knight.knight_moves([0, 0], [3, 3])
p knight.knight_moves([3, 3], [0, 0])
p knight.knight_moves([0, 0], [7, 7])
