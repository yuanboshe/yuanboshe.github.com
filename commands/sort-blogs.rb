usage       'sort-blogs [options]'
summary     'sorts the blogs in a year/month dir structure'
description 'moves blog posts to their respective folders, e.g. content/blog/{year}/{month}/example.html'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

option :p, :prune,  'removes empty folders', :argument => :optional
option :y, :yaml,   'create yaml overview of blog posts', :argument => :optional


run do |opts, args, cmd|
  blog_posts = {}
  site = Nanoc::Site.new(".")
  items = site.items.select{|i| i[:kind] == 'article'}
  for item in items
    source = item[:content_filename]
    return unless item[:created_at]
    year = item[:created_at].year
    month = item[:created_at].month
    month_name = Date::MONTHNAMES[month]
    day = item[:created_at].day
    dir = "content/blog/#{year}/#{'%02d' % month}"
    FileUtils.mkdir_p(dir)
    dest = "#{dir}/#{File.basename(source)}"
    unless source == dest
      puts "#{source}\t\t->\t\t#{dest}"
      FileUtils.mv(item[:content_filename], dest)
    end
    if opts[:prune]
      old_dir = File.dirname(source)
      FileUtils.rm_rf(old_dir) if Dir.glob("#{old_dir}/*").empty?
    end 
    if opts[:yaml]
      blog_posts[year] ||= {}
      blog_posts[year][month_name] ||= {}
      blog_posts[year][month_name][day] = item[:title]
    end
  end
  
  if opts[:yaml]
    open('blogs.yaml', 'w') do |post|
      post.puts blog_posts.to_yaml
    end
  end
end