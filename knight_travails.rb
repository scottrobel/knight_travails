# frozen_string_literal: true

# a board represents a mesh of connected nodes
# that are connected threw all the positions that a knight can travel
class Board
  attr_reader :board
  def initialize
    @possible_shifts = create_possible_shift_array
    @possible_move_list = {}
    build_board
  end

  def print_possible_moves(x_position, y_position)
    possible_moves = @possible_move_list[[x_position, y_position]]
    print possible_moves
  end

  def knight_moves(start_position, end_position)
    position_distance, path, queue, searched = vars(start_position)
    until queue.empty?
      temp = queue.shift
      searched << temp
      @possible_move_list[temp].each do |position|
        distance = position_distance[temp] + 1
        if position_distance[position].nil? ||
           distance < position_distance[position]
          position_distance[position] = distance
          path[position] = temp
        end
        queue << position unless searched.include? position
      end
    end
    full_path = path(start_position, end_position, path)
    print_path(full_path)
  end

  def vars(start_position)
    position_distance = {}
    path = {}
    position_distance[start_position] = 0
    queue = []
    queue << start_position
    searched = []
    [position_distance, path, queue, searched]
  end

  def print_path(path)
    print "You made it in #{path.length} Moves!\n"
    path.each do |position|
      print "#{position}\n"
    end
  end

  def path(start_position, end_position, position_path)
    path = []
    temp = end_position
    until temp == start_position
      path.unshift(temp)
      temp = position_path[temp]
    end
    path.unshift(start_position)
    path
  end

  def build_board
    build_position_hash
    populate_position_hash
  end

  def build_position_hash
    8.times do |row|
      8.times do |column|
        @possible_move_list[[row, column]] = []
      end
    end
  end

  def populate_position_hash
    8.times do |row|
      8.times do |column|
        @possible_shifts.each do |shift|
          x_position, y_position = get_coordinates_of_move([row, column], shift)
          if on_board?(x_position, y_position)
            @possible_move_list[[row, column]] << [x_position, y_position]
          end
        end
      end
    end
  end

  private

  def get_coordinates_of_move(position, shift)
    x_move = position[0] + shift[0]
    y_move = position[1] + shift[1]
    [x_move, y_move]
  end

  def create_possible_shift_array
    possible_shifts = []
    [-1, 1].each do |x_shift|
      [-2, 2].each do |y_shift|
        shift_one = [x_shift, y_shift]
        shift_two = shift_one.reverse
        possible_shifts << shift_one
        possible_shifts << shift_two
      end
    end
    possible_shifts
  end

  def on_board?(x_position, y_position)
    board_range = (0..7)
    board_range.include?(x_position) && board_range.include?(y_position)
  end
end

