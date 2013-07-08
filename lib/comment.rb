# get item's path as url
def path_url()
   path = @item.path
   if path[0] == "\/" then path.slice!(0) end
   path
end

# get img path for blog
def img_path()
	path = path_url()
	path = path.gsub(/\Ablog/, 'img').gsub(/.html\z/, "/")
	path
end

def img_url(file)
	filePath = img_path << file
	innerPath = "static/" << filePath
	FileTest::exist?(innerPath) ? filePath : nil
end