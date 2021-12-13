require "yaml"
require "erb"

# First, we actually update all svg images to be pngs to preserve the privacy
# as the PNG might contain entries that aren't actually visible on the resulting graphs
# so we add `.svg` images to the .gitignore, while automatically creating the png version
# on the fly when running `update.rb`
raise "missing rsvg-convert" unless `which rsvg-convert`.start_with?("/opt")
raise "missing pngquant" unless `which pngquant`.start_with?("/opt")

Dir["graphs/screens/*.svg"].each do |svg|
  puts "Converting #{svg} to png"
  file_height = File.read(svg).match(/height="(\d+)"/)[1].to_i

  # file_height times 2, to get proper retina support
  puts `rsvg-convert -h #{file_height * 2} '#{svg}' > '#{svg.gsub(".svg", ".png")}'`
end

# png crunch all the pngs
Dir["graphs/screens/*.png"].each do |png|
  puts "Compressing #{png}..."
  puts `pngquant #{png} --force --output #{png}`
end

all_data = YAML.load_file("graphs/data.yml")
binding.local_variable_set(:all_data, all_data)

renderer = ERB.new(File.read("graphs/data.erb"))
output = renderer.result(binding)
File.write("data.md", output)
