require 'byebug'
class DynamicProgramming
  attr_accessor :cache
  def initialize
    @cache = { 1=>1, 2=>2 }
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

  end

  def frog_cache_builder(n)
    frog_cache = {1 => [1], 2 => [[1,1],[2]], 3 => [[1,1,1],[1,2],[2,1],[3]]}
    (4...n).each do |i|
      byebug
      hops = frog_cache[i-1] + frog_cache[i-2] + frog_cache[i-3]
      frog_cache[i] = hops
    end 
    frog_cache
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
d = DynamicProgramming.new
p d.frog_cache_builder(6)
