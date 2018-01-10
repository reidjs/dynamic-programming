require 'byebug'
class DynamicProgramming
  attr_accessor :cache, :frog_cache
  def initialize
    @cache = { 1=>1, 2=>2 }
    @frog_cache = { 0 => [[]], 1=> [[1]], 2=>[[1,1],[2]],3=>[[1,1,1],[1,2],[2,1],[3]]}
    @knapsack_cache = {}
    @super_frog_cache = {[1, 1] => [[1]], [2, 1] => [[1, 1]], [2, 2] => [[1,1], [2]]}
    @maze_cache = []
    @maze_pos = []
  end

  def blair_nums(n)
    return n if @cache[n]
    # p @cache
    #odds: 1, 3, 5, etc. n-1st odd
    if @cache[n-1]
      firstnum = @cache[n-1] 
    else 
      firstnum = blair_nums(n-1)
    end 
    if @cache[n-2]
      secondnum = @cache[n-2] 
    else 
      secondnum = blair_nums(n-2)
    end 

    sum = firstnum + secondnum
    odd = (((n-1)*2) - 1)
    # odd = 0÷
    new_blair = sum + odd
    new_blair
    @cache[n] = new_blair
    # p @cache
    # byebug if new_blair == 36
    new_blair  
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    frog_cache = {1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1],[1,2],[2,1],[3]]}
    (4..n).each do |i|
      hops = frog_cache[i-3] + frog_cache[i-2] + frog_cache[i-1]
      hops.each do |arr|
        missing_bit = i-arr.inject(:+)
        # byebug if missing_bit == 0
        arr << missing_bit if missing_bit > 0
      end 
      frog_cache[i] = hops
    end 
    frog_cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    sum = frog_hops_top_down(n-3) + frog_hops_top_down(n-2) + frog_hops_top_down(n-1)
    sum.each do |arr|
      missing_bit = n - arr.inject(:+)
      byebug if missing_bit > 3
      arr << missing_bit if missing_bit > 0
    end 
    @frog_cache[n] = sum 
    sum 
  end

  def super_frog_hops(n, k)
    return @super_frog_cache[[n,k]] if @super_frog_cache[[n,k]]
    return [1]*n if k == 1 #only one way to do it if we can only go up one stair at a time 
    #n is num stairs 
    #k is max stairs (number of stairs the frog can jump)

    sum_arr = []
    if k <= n 
      #not a base case 
      return [k] + super_frog_hops(n, k - 1)
      
    else 
      #In this case we just add together every k less than the value. For example, if the frog can 
      #jump 5 but there's only 4 steps there's no advantage to that 5-step hop 
      k = n 
      while k > 0
        sum_arr << super_frog_hops(n, k)
        k -= 1
      end 
    end 
    sum_arr
  end

  #returns min value in array 
  def min_value(arr)
    min = nil 
    idx = nil 
    arr.each_with_index do |val, i|
      if min.nil? || val < min 
        min = val
        idx = i 
      end 
    end 
    min 
  end 

  #input: array of values to take, values array 
  #output: value  (int)
  def calc_value(take_arr, values_arr)
    val = 0 
    take_arr.each_index do |i|
      val += values_arr[i] * take_arr[i]
    end 
    val 
  end 

  def knapsack(weights, values, capacity)
    #trivial cases 
    if (min_value(weights) > capacity)
      # byebug
      return 0
    end 
    if (min_value(weights) == capacity)
      return values[weights.index(capacity)]
    end 
    #actual cases 
    solution = {take_arr => [], total_value => nil} #take_arr array will be 0s or 1s where 1 means take, 0 means leave
    return @knapsack_cache[capacity] if @knapsack_cache[capacity]
    if min_value(weights) > capacity #nothing have a weight less than capacity 
      take_arr = [0]*weights.length
      solution[take_arr] << take_arr
      solution[total_value] = calc_value(take_arr, values)
    end 
    # return [[1]*if weights.length < 2 
    current_weight = 0
    best_value = 0
    weights.each_with_index do |weight, i|

      value[i] if weight[i] + current_weight < capacity 
    end 
    @knapsack_cache[capacity-1] #decrease capacity by one and then check each item to see if we can increase value 
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    best_value = nil
    total_weight = 0
    #find best value for given capacity 
    weights.each_index do |weight_idx|
      if total_weight + weights[weight_idx] < capacity
        values[weight_idx]
      end 
    end 
  end

  def add_arrs(arr1, arr2)
    new_arr = []
    arr1.each_index do |i|
      new_arr << arr1[i] + arr2[i]
    end 
    new_arr
  end 

  def move_right_and_down(maze, pos, end_pos)
    new_pos = add_arrs(pos, [0, 1])
    # byebug
    @maze_cache << new_pos 
    new_pos = add_arrs(new_pos, [1, 0])
    maze_solver(maze, new_pos, end_pos)
    
  end 

  def maze_solver(maze, start_pos, end_pos)
    return nil if end_pos == [0,6]
    @maze_cache << start_pos 
    return @maze_cache if start_pos == end_pos 
    #move right 
    move_right_and_down(maze, start_pos, end_pos)
    # move_down(maze, start_pos, end_pos)
    # byebug
  end
end
d = DynamicProgramming.new
# p d.frog_hops_bottom_up(4).sort
# p 'hi'
# p d.frog_hops_bottom_up(5).sort
# p d.frog_hops_top_down(10)
