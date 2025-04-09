require 'csv'  # we’re working with CSV files, so grab the built-in Ruby CSV lib

# adjust all email/phone to be in the same format: lowercase, strip spaces, remove special chars
def clean(value)
  return '' if value.nil?
  value.strip.downcase.gsub(/[^a-z0-9@]/, '')
end

# Union-Find: find the root of a group
def find(parents, ranks, i)
  parents[i] = find(parents, ranks, parents[i]) if parents[i] != i
  parents[i]
end

# Union-Find: combine two groups (with rank optimization)
def union(parents, ranks, i, j)
  root_i = find(parents, ranks, i)
  root_j = find(parents, ranks, j)

  return if root_i == root_j # already grouped

  # add smaller tree under bigger one
  if ranks[root_i] > ranks[root_j]
    parents[root_j] = root_i
  elsif ranks[root_i] < ranks[root_j]
    parents[root_i] = root_j
  else
    parents[root_j] = root_i
    ranks[root_i] += 1
  end
end

# get command-line args like:
# ruby match_users.rb email phone input.csv
match_types = ARGV[0..-2]
filename = ARGV[-1]

# Read all rows from the CSV into memory
rows = []
CSV.foreach(filename, headers: true) { |row| rows << row.to_h }
puts "Loaded #{rows.length} rows from #{filename}"

n = rows.length
parents = Array.new(n) { |i| i }  # start with each row as its own group
ranks = Array.new(n, 0)          

# Build lookup maps: each cleaned value points to a list of row index
email_map = Hash.new { |h, k| h[k] = [] }
phone_map = Hash.new { |h, k| h[k] = [] }

# Go row by row, clean the values, and populate the lookup maps
rows.each_with_index do |row, idx|
  emails = [row['Email'], row['Email1'], row['Email2']].map { |e| clean(e) }.reject(&:empty?)
  phones = [row['Phone'], row['Phone1'], row['Phone2']].map { |p| clean(p) }.reject(&:empty?)

  emails.each { |e| email_map[e] << idx }
  phones.each { |p| phone_map[p] << idx }
end

# For every value in each map, union all rows that share that same value
[email_map, phone_map].each_with_index do |map, i|
  next unless match_types.include?(i == 0 ? "email" : "phone")

  map.each_value do |indexes|
    base = indexes.first
    indexes[1..].each do |other|
      union(parents, ranks, base, other)
    end
  end
end

# give each group a user_id
group_ids = {}
current_id = 1
user_ids = Array.new(n)

(0...n).each do |i|
  root = find(parents, ranks, i)
  unless group_ids[root]
    group_ids[root] = current_id
    current_id += 1
  end
  user_ids[i] = group_ids[root]
end

# Add the resulta new CSV file
output_file = filename.sub(".csv", "_output.csv")
CSV.open(output_file, "w", write_headers: true, headers: ['user_id'] + rows.first.keys) do |csv|
  rows.each_with_index do |row, i|
    csv << [user_ids[i]] + row.values
  end
end

puts "\n View output: #{output_file}"
