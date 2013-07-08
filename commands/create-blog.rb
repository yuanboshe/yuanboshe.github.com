summary     'creates a new blog post'
description <<desc
This command creates a new blog post under content/blog/{year}/{month}/example.html. 
You can additionally pass in the description, the tags and the creation date.
desc
usage     'create-blog name [options]'

option :f, :filter,  'filter for this blog post (ex. "kramdown")', :argument => :optional
option :t, :tags,         'tags for this blog post (ex. "these,are,tags")', :argument => :optional
option :c, :created_at,   'creation date for this blog post (ex. "2013-01-03 10:24")', :argument => :optional

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  # requirements
  require 'stringex'
  require 'highline'
  
  # load up HighLine
  line = HighLine.new
  
  # get the name and description parameter or the default
  name = args[0] || "New blog post"
  filter = opts[:filter] || "kramdown"
  
  # convert the tags string to and array of trimmed strings
  tags = opts[:tags].split(",").map(&:strip) rescue []
  
  # convert the created_at parameter to a Time object or use now
  timestamp = DateTime.parse(opts[:created_at]).to_time rescue Time.now
  
  # make the directory for the new blog post
  dir = "content/blog/#{timestamp.year}/#{'%02d' % timestamp.month}"
  imgDir = "static/img/#{timestamp.year}/#{'%02d' % timestamp.month}/#{name}"
  FileUtils.mkdir_p dir
  FileUtils.mkdir_p imgDir
  
  # make the full file name
  filename = "#{dir}/#{name}.html"

  # check if the file exists, and ask the user what to do in that case
  if File.exist?(filename) && line.ask("#{filename} already exists. Want to overwrite? (y/n)", ['y','n']) == 'n'
  
    # user pressed 'n', abort!
    puts "Blog post creation aborted!"
    exit 1
  end

  # write the scaffolding
  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "title: #{name}"
    post.puts "created_at: #{timestamp}"
    post.puts "filter: #{filter}"
    post.puts "kind: article"
    post.puts "layout: article"
    post.puts "tags: #{tags.inspect}"
    post.puts "---\n\n"
    post.puts "<!-- more -->"
  end
end