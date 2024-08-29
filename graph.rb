class KnightPiece
  KNIGHT_MOVES = [
    [-1, 2], [1, 2], [-1, -2], [1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]
  ].freeze

  attr_reader :graph

  def initialize
    @graph = build_adjecency_list
  end

  def knight_moves(source, destination)
    return "Invalid move" if !valid_move?(source) || !valid_move?(destination)
    return [source] if source == destination

    queue = Queue.new
    queue << [source, Set[source]]
    already_explored = Set[]

    until queue.empty?
      vertex, path = queue.deq

      # p "Exploring #{vertex}, #{path}"

      @graph[vertex].each do |child_node|
        if child_node == destination
          path << child_node
          puts "You made it in #{path.length} moves"
          return path.to_a
        else
          if already_explored.include?(child_node) == false # rubocop:disable Style/IfInsideElse
            queue << [child_node, path.dup << child_node]
            already_explored << child_node
          end
        end
      end
    end
  end

  private

  def build_adjecency_list
    list = {}

    (0..7).each do |i|
      (0..7).each do |j|
        vertex = [i, j]
        list[vertex] = get_connections(vertex)
      end
    end

    list
  end

  def get_connections(curr_move)
    possible_moves = Set.new

    KNIGHT_MOVES.each do |move|
      new_move = [curr_move[0] + move[0], curr_move[1] + move[1]]
      possible_moves << new_move if valid_move?(new_move) == true
    end

    possible_moves.to_a
  end

  def valid_move?(move)
    x_axis = move[0]
    y_axis = move[1]

    (x_axis >= 0 and x_axis <= 7) && (y_axis >= 0 and y_axis <= 7)
  end
end
