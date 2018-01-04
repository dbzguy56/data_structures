require "pry"
class Node
  attr_accessor :value, :first, :second, :third, :fourth, :fifth, :sixth, :seventh, :eighth, :parent
  def initialize value, parent = nil
    arr = [6, 15, 10, 17]
    @value = value
    @parent = parent
    a = value / 8
    b = (value - arr[0]) / 8
    c = (value + arr[0]) / 8
    d = (value - arr[3]) / 8
    e = (value + arr[3]) / 8
    f = (value - arr[1]) / 8
    g = (value + arr[1]) / 8
    h = (value - arr[2]) / 8
    i = (value + arr[2]) / 8
    @first = value - arr[0] if a != b && value > 5
    @second = value - arr[1] if value > 14 && a - f == 2
    @third = value - arr[2] if value > 9 && a - h == 1
    @fourth = value - arr[3] if value > 16 && a - d == 2
    @fifth = value + arr[0] if a != c && value < 58
    @sixth = value + arr[1] if value < 49 && g - a == 2
    @seventh = value + arr[2] if value < 54 && i - a == 1
    @eighth = value + arr[3] if value < 47 && e - a == 2
    #puts "#{@first} #{@second} #{@third} #{@fourth} #{@fifth} #{@sixth} #{@seventh} #{@eighth}"
  end
end
#3b 1c 0a 25 10 0
#5f 3e 1d 45 28 11
class BinaryTree
  def initialize value
    @root = Node.new(value)
    @last = nil
  end

  def knight_moves pos
    if pos == @root.value
      puts "That is the same position!"
    else
      queue = [@root]
      found = false
      child_value = nil
      while !found
        nodes_shifted = []
        while !queue.empty?
          #puts queue.to_s
          node = queue.shift
          nodes_shifted.push(node)
          node.instance_variables.each_with_index do |attribute, i|
            if i > 1
              child_value = node.instance_variable_get(attribute)
              #puts child_value
              if child_value == pos
                found = true
                @last = Node.new(child_value, node)
                queue = []
              end
            end
            break if found
          end
        end
        if !found
          nodes_shifted.each do |current_node|
            current_node.instance_variables.each_with_index do |children, i|
              if i > 1
                child_value = current_node.instance_variable_get(children)
                c = Node.new(child_value, current_node)
                queue.push(c)
              end
            end
          end
        else
          print_path(@last)
        end
      end
    end
  end
  def print_path node
    start_row = @root.value / 8
    start_col = translate_num(@root.value)
    end_row = @last.value / 8
    end_col = translate_num(@last.value)
    print "knight_moves([#{start_row}#{start_col}],[#{end_row}#{end_col}]) == ["
    s = ""
    arr = []
    current_node = @last
    while  current_node != nil
      arr.push(current_node.value)
      current_node = current_node.parent
    end
    arr.length.times do
      num = arr.pop
      current_row = num / 8
      current_col = translate_num(num)
      s += "[#{current_row}#{current_col}]"
      s += "," if num != @last
    end
    #print "[#{start_row}#{start_col}]," if !s.include? "[#{start_row}#{start_col}],"
    print "#{s}]\n".sub("],]", "]]")
  end

  def translate_num num
    case num % 8
    when 0
      start_col = "a"
    when 1
      start_col = "b"
    when 2
      start_col = "c"
    when 3
      start_col = "d"
    when 4
      start_col = "e"
    when 5
      start_col = "f"
    when 6
      start_col = "g"
    when 7
      start_col = "h"
    end
  end
end


def print_game_board game_board
  8.times do |i|
    print "#{i} "
    8.times do |j|
      print "#{game_board[i*8+j]}, "
    end
    puts
  end
  print "  a  b  c  d  e  f  g  h\n"
end

#PIECE: 35
#possible moves:
# 18 => 2 * 8 + 2 => 35 - 18 = 17
# 25 => 3 * 8 + 1 => 35 - 25 = 10
# 20 => 2 * 8 + 4 => 35 - 20 = 15
# 29 => 3 * 8 + 5 => 35 - 29 = 6
# 40 => 5 * 8 + 1 => 35 - 41 = -6
# 49 => 6 * 8 + 2 => 35 - 50 = -15
# 44 => 5 * 8 + 5 => 35 - 45 = -10
# 51 => 6 * 8 + 4 => 35 - 52 = -17

game_board = []
64.times do
  game_board.push("O")
end

current_pos = 35
game_board[current_pos] = "k"
print_game_board(game_board)

puts "Choose a square to move by typing a number followed by a letter (eg. 3A)"
input = gets.chomp.split("")
row = input[0].to_i

case input[1].upcase!
  when "A"
    col = 0
  when "B"
    col = 1
  when "C"
    col = 2
  when "D"
    col = 3
  when "E"
    col = 4
  when "F"
    col = 5
  when "G"
    col = 6
  when "H"
    col = 7
end

find_pos = row * 8 + col
x = find_pos - current_pos

#starting_node = Node.new(current_pos)
=begin
if moving_options.include? x
  game_board[current_pos] = "O"
  game_board[pos] = "k"
  print_game_board(game_board)
else
  puts "nay"
end
=end

b = BinaryTree.new(current_pos)
b.knight_moves(find_pos)
