require 'benchmark'

# The binary search is an efficient algorithm for finding an element
# in an ordered list. It works by repeatedly dividing the list in half
# and comparing the element of interest with the element in the middle
# of the list. The process continues until the element is found or the
# sublist can no longer be divided.

# Example of use:
# ruby binary_search.rb 100000

def binary_search(ordered_list:, target:, first: 0, last: nil)
  last ||= ordered_list.length - 1
  return -1 if first > last

  middle = (first + last) / 2
  return middle if target == ordered_list[middle]

  if target > ordered_list[middle]
    binary_search(
      ordered_list: ordered_list,
      target: target,
      first: middle + 1,
      last: last
    )
  else
    binary_search(
      ordered_list: ordered_list,
      target: target,
      first: first,
      last: middle - 1
    )
  end
end

def search_by_each(ordered_list:, target:)
  ordered_list.each_with_index do |element, index|
    return index if element == target
  end
  -1
end

ordered_list = (0..100000).to_a
target = ARGV[0].to_i

Benchmark.bmbm do |x|
  x.report('Binary search') { @index_bs = binary_search(ordered_list: ordered_list, target: target) }
  x.report('Search by each') { @index_se = search_by_each(ordered_list: ordered_list, target: target) }
end

puts "\n\n"
puts "Binary search result: #{@index_bs}"
puts "Search by each result: #{@index_se}"