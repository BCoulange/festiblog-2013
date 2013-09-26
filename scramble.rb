require "rmagick"
include Magick

img = ImageList.new(ARGV[0])

tiles = []

tile_size_x = ARGV[1].to_i
tile_size_y = ARGV[2].to_i

local_x = 0

# extraction des tuiles
while local_x < img.columns
	local_y = 0
	while local_y < img.rows
		tiles << img.excerpt(local_x, local_y, tile_size_x, tile_size_y)
		local_y += tile_size_y
	end
	local_x += tile_size_x
end






page = Rectangle.new(0,0,0,0)
tiles_list = ImageList.new


local_x = 0
local_y = 0
tiles.shuffle.each do |tile|
	page.x = local_x
	page.y = local_y
	tiles_list << tile
	tiles_list.page = page

	local_x += tile_size_x
	if local_x >= img.columns
		local_y += tile_size_y
		local_x = 0
	end
end

output = tiles_list.mosaic
output.write(ARGV[3])
