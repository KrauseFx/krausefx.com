require "yaml"
require "erb"


all_data = YAML.load_file("graphs/data.yml")
binding.local_variable_set(:all_data, all_data)

renderer = ERB.new(File.read("graphs/data.erb"))
output = renderer.result(binding)
puts output
File.write("data.md", output)
