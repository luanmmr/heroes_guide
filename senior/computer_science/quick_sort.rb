require 'benchmark'

# Quick Sort is an efficient sorting algorithm that follows the divide
# and conquer paradigm. It selects an element as the pivot and
# partitions the elements in the list so that all elements smaller than
# the pivot are on the left and all elements greater than the pivot are
# on the right. The process is then repeated recursively for the sublists
# to the left and right of the pivot.

# Example of use:
# ruby quick_sort.rb

def quick_sort(list)
  return list if list.length <= 1

  pivot = list[list.length / 2]

  minors = list.select { |element| element < pivot }
  equals = list.select { |element| element == pivot }
  majors = list.select { |element| element > pivot }

  quick_sort(minors) + equals + quick_sort(majors)
end

def ordering_code(list)
  list_ordered = list.clone

  list_ordered.each_index do |index|
    list_ordered.each_with_index do |element, other_index|
      if element > list_ordered[index]
        list_ordered[other_index] = list_ordered[index]
        list_ordered[index] = element
      end
    end
  end

  list_ordered
end

def order_by_sort(list)
  list.sort
end

list = (0..200).to_a.shuffle

puts "List before being sorted: #{list}"
puts "\n\n"

Benchmark.bmbm do |x|
  x.report('Quick sort') { @quick_sort = quick_sort(list) }
  x.report('Order by sort') { @order_by_sort = order_by_sort(list) }
  x.report('Ordering code') { @ordering_code = ordering_code(list) }
end

puts "\n\n"
puts "Binary search result: #{@quick_sort}\n\n"
puts "Search by each result: #{@order_by_sort}\n\n"
puts "Ordering code result: #{@ordering_code}"
