class Node
  attr_accessor :value, :parent, :left, :right
  def initialize value
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end
end

class BinaryTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def build_tree arr
    arr.each do |element|
      if @root == nil
        @root = Node.new(element)
      else
        insert(@root, element)
      end
    end
  end

  def insert node, element
    if node == nil
      node = Node.new(element)
    elsif element < node.value
      node.left = insert(node.left, element)
      node.left.parent = node
    else
      node.right = insert(node.right, element)
      node.right.parent = node
    end
    node
  end

  def breadth_first_search key
    queue = [@root]
    while !queue.empty?
      node = queue.shift
      if node.value == key
        puts "The key: #{key} was found in the binary tree!"
        return node
      end
      queue.push(node.left) if node.left != nil
      queue.push(node.right) if node.right != nil
    end
    puts "The key: #{key} was not found in the binary tree."
    nil
  end

  def depth_first_search key
    stack = [@root]
    node = @root
    while !stack.empty?
      stack.push(node.left) if node.left != nil
      stack.push(node.right) if node.right != nil
      node = stack.pop
      if node.value == key
        puts "Yay, the key was found!"
        return node
      end
    end
    puts "The node was not found :("
    nil
  end

  def dfs_rec key, node = @root
    if key == node.value
      puts "The key was found!"
      return node
    end
    dfs_rec(key, node.left) if node.left != nil
    dfs_rec(key, node.right) if node.right != nil
  end

end


arr = [7,1,4,23,8,9,4,3,5,7,9,6345,324]

b = BinaryTree.new
b.build_tree(arr)

b.breadth_first_search(324)
b.breadth_first_search(10)

b.depth_first_search(324)
b.depth_first_search(54)

b.dfs_rec(324)
b.dfs_rec(54)
